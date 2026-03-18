---
description: Commit changes with jj, create bookmark, and open PR
argument-hint: [ISSUE-ID] [--reviewer <team-or-user>] [--draft]
allowed-tools: Bash(jj:*), AskUserQuestion, mcp__linear-server__list_issues, mcp__linear-server__get_issue, mcp__github__list_pull_requests, mcp__github__create_pull_request, mcp__github__get_me
---

## Context

- Current jj status: !`jj status`
- Changes vs main: !`jj diff --from main`
- Recent commits for style reference: !`jj log -r 'ancestors(main, 5)' --no-graph`

## Arguments

$ARGUMENTS

## Your Task

1. Review the diff above and generate a detailed commit message:
   - First line: Brief summary of the change (50-72 chars)
   - Blank line
   - Body: Explain WHAT changed and WHY, including:
     - New fields/objects added and their purpose
     - Permission changes and which permission sets were updated
     - Layout changes
     - Any other notable modifications
   - Follow the general style of recent commits but ensure sufficient detail
2. Create the commit using `jj commit -m "<message>"`
3. Find the related Linear issue for the bookmark name:
   - If an ISSUE-ID (e.g., SFDC-1234) was provided in arguments, use `mcp__linear-server__get_issue` to fetch it directly and use its `gitBranchName`
   - Otherwise, use `mcp__linear-server__list_issues` to fetch issues assigned to "me" with status "In Progress" or "In Cycle"
   - Analyze the diff content to find the best matching issue based on keywords, file names, or object names
   - If a clear match is found, use its `gitBranchName` as the bookmark name
   - If multiple issues could match or no clear match exists, show the user a numbered list of recent issues (identifier, title) and ask them to select one
   - Extract the `gitBranchName` from the selected issue
4. Set the bookmark on the new commit using `jj bookmark set <bookmark-name> -r @-`
5. Push the bookmark and open PR:
   - Push the bookmark: `jj git push -r <bookmark-name>`
   - Export to git: `jj git export`
   - Get the repo owner/name from `jj git remote list` (parse the GitHub URL)
   - Use `mcp__github__get_me` to get the current user's login for the assignee
   - Create PR using `mcp__github__create_pull_request` with:
     - `owner`: repository owner
     - `repo`: repository name
     - `title`: first line of commit message
     - `body`: rest of commit message
     - `head`: `<bookmark-name>`
     - `base`: `main` (or the default branch)
     - `draft`: true if `--draft` provided in arguments
   - If `--reviewer` provided in arguments, after creating the PR use `mcp__github__update_pull_request` with `reviewers` parameter
   - If no reviewer specified, use `mcp__github__list_pull_requests` with `state: "closed"` to find recent merged PRs, then ask which reviewer(s) to use (or none)

Note: `jj git root` returns the complete path to the git directory (e.g., `/path/to/.jj/repo/store/git`). Do NOT append `/.git` to it.
