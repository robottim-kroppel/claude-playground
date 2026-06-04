# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is a personal playground repository for experimenting with code across multiple technology stacks. The `.gitignore` covers Rails, Python, Node.js, Java, Firebase, and Terraform, so projects here may span any of these.

## Terminology

For clarity, assume the following more precise meanings for the following words whenever they are capitalized, instead of assuming their more general, coloquiial meaning.  When they are not capitalized, take a looser interpretation, but still biased in the direction of these definitions.

- `User` - the end user who is using the software or tool being developed in this repository
- `Operator` - the software engineer, devops or infrastructure person who is responsible for keeping this software running in production, monitoring it, and finding and fixing issues, slowdowns, and bugs. 
- `Developer` - the software engineer altering and evolving this software.
- `Frontend` - The portion of the software stack that the User sees and interacts directly with, most typically written in a Javascript framework like React and executing inside a web browser on the User's computer.  Even though it's most typically a web application, it might also sometimes be an SMS based interface, or an AI tool like a skills repository for Claude Desktop, or some other way of interacting.  If there is an MCP server, consider that a "frontend" that interacts with a more traditional "backend" in a separate process.
- `Backend` - The portion of the software stack that runs in cloud infrastructure and contains the vast majority of the "business logic" and data storage and retrieval logic.  Most typcially a Flask application with a REST interface.


## Rule files

Project-level guidance lives in `.claude/rules/` as separate topic files:

- `backend.md` — backend conventions
- `frontend.md` — frontend conventions
- `visual-style.md` — visual/UI style
- `testing.md` — testing approach
- `security.md` — security guidelines
- `code-metrics.md` — code quality metrics
- `terraform.md` — infrastructure conventions
- `database-and-sql.md` - conventions for designing table structure and schemas and writing SQL

## Folder layout

Artifacts should be laid out in the repo as follows (all subdiretories under the project root):

- `infra` - terraform scripts and shell scripts and other devops related artifacts
- `backend` - the backend application (e.g. Flask or Ruby on Rails)
- `frontend` - the front end application (e.g. React or Vue)
- `scripts` - small little convenience scripts and tools that don't fit somewhere else.  Try not to use if you can avoid it.


## General technical approach

Regardless of the focus (frontend, backend, infrastructure), please prefer solutions that get most directly to the point, have the minimum number of layers of abstraction, are timeless (as opposed to trendy) in their approach and are cost-aware without being cheap.  For all scripts, endpoints, transactions, and other code-like executables, to the extent feasible, always make them both idempotent and reentrant.

## Security

At all times, take a security approach that is as unobtrusive and low a burden as it can feasibly be for the User and Operator while still meeting the requirements of a lightweight SOC2 Type 2 audit.  Use defense in depth without assuming that the outer layer of security will hold.  Generally prefer zero-trust approaches except where they become ridiculously burdensome for the operator or user.
