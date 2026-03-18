#!/bin/bash

# Read JSON input from stdin
input=$(cat)
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')

# Change to the current directory
cd "$current_dir" 2>/dev/null || exit 0

# Check if current revision has bookmarks
current_bookmarks=$(jj log --revisions @ --no-graph --ignore-working-copy --template 'bookmarks' 2>/dev/null)

# Get bookmark info with distance calculation
if [[ -n "$current_bookmarks" && "$current_bookmarks" != "" ]]; then
    # Current revision has bookmarks
    bookmark_info="$current_bookmarks"
else
    # Find nearest bookmark and calculate distance
    # First try immediate parents (looking backward)
    # Check each parent individually for bookmarks
    parent_bookmarks=""
    while IFS= read -r parent_id; do
        if [[ -n "$parent_id" ]]; then
            parent_bookmark=$(jj log --revisions "$parent_id" --no-graph --ignore-working-copy --template 'bookmarks.join(",")' 2>/dev/null)
            if [[ -n "$parent_bookmark" && "$parent_bookmark" != "" ]]; then
                parent_bookmarks="$parent_bookmark"
                break
            fi
        fi
    done < <(jj log --revisions "parents(@)" --no-graph --template 'change_id.shortest(4) ++ "\n"' 2>/dev/null)
    
    if [[ -n "$parent_bookmarks" && "$parent_bookmarks" != "" ]]; then
        # Since parent has the bookmark and current @ is one ahead, show +1
        bookmark_info="${parent_bookmarks}+1"
    else
        # Try broader ancestors (looking backward)
        ancestor_info=$(jj log --revisions "ancestors(@) & bookmarks" --no-graph --ignore-working-copy --template 'bookmarks.join(",") ++ " " ++ change_id.shortest(4)' --limit 1 2>/dev/null)
        
        if [[ -n "$ancestor_info" && "$ancestor_info" != "" ]]; then
            ancestor_bookmark=$(echo "$ancestor_info" | cut -d' ' -f1)
            ancestor_id=$(echo "$ancestor_info" | cut -d' ' -f2)
            # Calculate distance using jj log from ancestor to current
            distance=$(jj log --revisions "${ancestor_id}::@" --no-graph --ignore-working-copy --template '1' 2>/dev/null | wc -l | tr -d ' ')
            # Subtract 1 because the range includes both endpoints
            distance=$((distance - 1))
            if [[ "$distance" -gt 0 ]]; then
                bookmark_info="${ancestor_bookmark}+${distance}"
            else
                bookmark_info="$ancestor_bookmark"
            fi
        else
            # Try descendants (looking forward)
            descendant_info=$(jj log --revisions "descendants(@) & bookmarks" --no-graph --ignore-working-copy --template 'bookmarks.join(",") ++ " " ++ change_id.shortest(4)' --limit 1 2>/dev/null)
            
            if [[ -n "$descendant_info" && "$descendant_info" != "" ]]; then
                descendant_bookmark=$(echo "$descendant_info" | cut -d' ' -f1)
                descendant_id=$(echo "$descendant_info" | cut -d' ' -f2)
                # Calculate distance using jj log from current to descendant
                distance=$(jj log --revisions "@::${descendant_id}" --no-graph --ignore-working-copy --template '1' 2>/dev/null | wc -l | tr -d ' ')
                # Subtract 1 because the range includes both endpoints
                distance=$((distance - 1))
                if [[ "$distance" -gt 0 ]]; then
                    bookmark_info="${descendant_bookmark}-${distance}"
                else
                    bookmark_info="$descendant_bookmark"
                fi
            else
                bookmark_info="no-bookmarks"
            fi
        fi
    fi
fi

# Extract bookmark name and distance for separate coloring
if [[ "$bookmark_info" =~ ^(.+)([+-][0-9]+)$ ]]; then
    # Has distance indicator - purple for bookmark name, default color for distance
    bookmark_name="${BASH_REMATCH[1]}"
    distance_part="${BASH_REMATCH[2]}"
    colored_bookmark_info=$(printf "\x1b[1;35m%s\x1b[0m%s" "$bookmark_name" "$distance_part")
else
    # No distance indicator, color the whole thing purple
    colored_bookmark_info=$(printf "\x1b[1;35m%s\x1b[0m" "$bookmark_info")
fi

# Get basic jj status info without bookmark coloring
jj_basic=$(jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
  separate(" ",
    change_id.shortest(4),
    "BOOKMARK_PLACEHOLDER",
    "|",
    concat(
      if(conflict, "💥"),
      if(divergent, "🚧"),
      if(hidden, "👻"),
      if(immutable, "🔒"),
    ),
    raw_escape_sequence("\x1b[1;32m") ++ if(empty, "(empty)"),
    raw_escape_sequence("\x1b[1;32m") ++ coalesce(
      truncate_end(29, description.first_line(), "…"),
      "(no description set)",
    ) ++ raw_escape_sequence("\x1b[0m"),
  )
' 2>/dev/null)

# Replace the placeholder with properly colored bookmark info
jj_status=$(echo "$jj_basic" | sed "s|BOOKMARK_PLACEHOLDER|$colored_bookmark_info|")

# Get project name and add bold cyan color
project_name=$(basename "$current_dir")

# Output the status line with colors: project_name in bold cyan, "jj:" in yellow, then jj status
printf "\x1b[1;36m%s\x1b[0m \x1b[1;33mjj:\x1b[0m%s" "$project_name" "$jj_status"