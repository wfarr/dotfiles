---
description: Update an existing PR with new changes
argument-hint:
allowed-tools: Bash(jj:*), AskUserQuestion, mcp__github__update_pull_request, mcp__github__list_pull_requests
---

## Context

- Current jj status: !`jj status`
- Current bookmarks: !`jj bookmark list`
- Current commit: !`jj log -r @ --no-graph`
- Parent commit: !`jj log -r @- --no-graph`
- Recent commits for style reference: !`jj log -r 'ancestors(main, 5)' --no-graph`

## Your Task

### 1. Fetch Latest Changes

Run `jj git fetch` to get the latest changes from the remote.

### 2. Check if Rebase is Needed

- Compare the local `main` bookmark position before and after fetch
- If `main` has moved forward, rebase our work onto the new main:
  ```
  jj rebase -d main
  ```
- Report any conflicts that need resolution and help resolve them if needed

### 3. Identify the Working Bookmark

- Look at the bookmarks on `@-` (the parent commit, which should be our feature commit)
- The working bookmark is a non-main bookmark on `@-` (e.g., `will/sfdc-1234-...`)
- If no bookmark is found on `@-`, check `@` for bookmarks
- If still no bookmark found, ask the user which bookmark to use

### 4. Squash Changes (if needed)

If there are uncommitted changes in `@` (working copy has modifications):
- Review the changes in `@` using `jj diff`
- Squash them into the parent commit: `jj squash`
- This combines the working copy changes with the feature commit

### 5. Update Commit Message

After squashing (or if the commit content has changed):
- Review the full diff of the feature commit: `jj diff -r <bookmark>`
- Update the commit message to accurately reflect ALL changes in the commit:
  ```
  jj describe -r <bookmark> -m "<updated message>"
  ```
- First line: Brief summary (50-72 chars)
- Body: Explain what changed and why, covering all modifications

### 6. Push Changes

Push the updated bookmark to the remote:
```
jj git push -r <bookmark>
```

If the push requires a force push (due to rebase or squash), use:
```
jj git push -r <bookmark> --allow-new
```

### 7. Update PR on GitHub

Update the PR title and body to match the commit:
- Extract the commit subject (first line) for PR title
- Extract the commit body for PR description
- Get the repo owner/name from `jj git remote list` (parse the GitHub URL)
- Use `mcp__github__list_pull_requests` with `head` filter to find the PR number for the bookmark
- Use `mcp__github__update_pull_request` with:
  - `owner`: repository owner
  - `repo`: repository name
  - `pullNumber`: the PR number found above
  - `title`: the commit subject
  - `body`: the commit body

Note: The PR body should include the full commit message body, maintaining any formatting.

Note: `jj git root` returns the complete path to the git directory (e.g., `/path/to/.jj/repo/store/git`). Do NOT append `/.git` to it.

## Example Flow

```bash
# 1. Fetch
jj git fetch

# 2. Rebase if needed
jj rebase -d main

# 3. Squash working changes into feature commit
jj squash

# 4. Update commit message
jj describe -r @- -m "Updated commit message

Full body explaining changes..."

# 5. Push
jj git push -r will/sfdc-1234-feature-name

# 6. Update PR - use mcp__github__update_pull_request with:
#    - owner/repo from `jj git remote list`
#    - pullNumber from mcp__github__list_pull_requests
#    - title: "Updated commit message"
#    - body: "Full body explaining changes..."
```
