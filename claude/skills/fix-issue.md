---
description: Fix a Linear issue end-to-end
argument-hint: [ISSUE-ID]
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, Task, AskUserQuestion, Skill, mcp__linear-server__list_issues, mcp__linear-server__get_issue, mcp__linear-server__list_comments
---

## Arguments

$ARGUMENTS

## Your Task

### 1. Identify the Linear Issue

- If an ISSUE-ID (e.g., SFDC-1234) was provided in arguments:
  - Use `mcp__linear-server__get_issue` to fetch the issue details
  - Verify the issue is assigned to "me" - if not, warn the user and ask if they want to proceed anyway
- If no ISSUE-ID was provided:
  - Use `mcp__linear-server__list_issues` to fetch issues assigned to "me" with status "In Progress" or "In Cycle"
  - Present a numbered list showing: identifier, title, and status
  - Ask the user to select which issue to work on
  - Fetch the full issue details with `mcp__linear-server__get_issue`

### 2. Understand the Issue

Gather all available context about the issue:
- **Title**: What is being requested
- **Description**: Full details, acceptance criteria, technical notes
- **Comments**: Use `mcp__linear-server__list_comments` to get any discussion or clarifications
- **Attachments**: Review any screenshots, designs, or linked documents
- **Related issues**: Note any blocking or related issues mentioned

### 3. Develop a Plan

- Explore the codebase to understand the relevant code areas
- Identify which files need to be created or modified
- Consider edge cases and potential impacts
- Present your implementation plan to the user for approval before proceeding
- If there are multiple approaches, explain the trade-offs and ask which to pursue

### 4. Prepare a Workspace

Once the plan is approved, ask the user if they'd like to do this work in a new workspace.

**If yes (recommended for isolated work):**

Use the `/create-workspace` skill with the issue ID:
```
/create-workspace <ISSUE-ID>
```

This will:
- Create an isolated jj workspace with dedicated Docker infrastructure
- Set up the database and environment
- Create a bookmark from the Linear issue's branch name

After workspace creation:

1. **Write the implementation plan** to `.claude/implementation-plan.md` in the new workspace:
   ```markdown
   # Implementation Plan: <ISSUE-ID>

   ## Issue
   **<Title>**
   <Description summary>

   ## Plan
   <The approved implementation plan with specific files and changes>

   ## Files to Modify
   - `path/to/file1.rb` - <what to change>
   - `path/to/file2.rb` - <what to change>

   ## Acceptance Criteria
   - <criterion 1>
   - <criterion 2>
   ```

2. **Instruct the user** to start Claude in the workspace with the plan:
   ```
   cd <workspace-path> && claude "Implement the plan in .claude/implementation-plan.md"
   ```

Then **STOP here** - the new Claude session will read the plan and continue with implementation.

**If no (working in the current workspace):**
- Run `jj git fetch` to update bookmarks
- Create a bookmark using the issue's `branchName`: `jj bookmark create <branchName>`
- Continue to step 5

### 5. Implement the Changes

Once in the correct workspace:
- Make the necessary code changes following the project's coding standards
- Write tests if appropriate for the type of change
- Run linting and formatting as needed (check project's CLAUDE.md for commands)
- Ensure the changes are complete and working

### 6. Review Checkpoint

Before committing:
- Summarize all changes made
- Show the diff of modified files
- Ask the user to review and approve the changes
- Address any feedback or requested modifications

### 7. Commit and Open PR

Once the user approves the changes:
- Use the `/commit-and-open-pr` skill with the Linear issue ID to:
  - Create a detailed commit message
  - Set the bookmark from the Linear issue's branch name
  - Push and open the PR
