# Contributing

Short guide to the project workflow.

## Branching

- Treat `main` as the stable integration branch and keep it buildable.
- Use short-lived branches with prefixes: `feat/`, `fix/`, `doc/`, `chore/`, `hotfix/`.

## Pull Requests

- Open PRs against `main`. Keep them small and focused.
- PR checklist:
  - [ ] Changed LaTeX documents compile without errors
  - [ ] No generated artifacts (.aux, .log, .synctex.gz) included
  - [ ] Figures and tables regenerated if changed
  - [ ] All citations verified against actual papers

## Commit Messages

Format: `type: short description`

Types: `feat`, `fix`, `doc`, `chore`, `refactor`, `test`

Examples:
- `doc: add transformer architecture section to overview`
- `feat: implement Tsetlin Machine automaton in Rust`
- `fix: correct equation numbering in chapter 5`

## Building Documents

Requires TeX Live with LuaLaTeX. The DevContainer includes everything needed.

```bash
# Overview
./scripts/build-documents.sh overview

# Theory book
./scripts/build-documents.sh theory
```

For a browser preview, run `aibox up` on the host and open
`http://127.0.0.1:8766/`. For continuous rebuilding, use
`./scripts/build-documents.sh watch overview` or `theory`.

## DevContainer

The repository includes a DevContainer configuration with LuaLaTeX, Rust, and all required TeX packages. Open in VS Code with the Dev Containers extension or use GitHub Codespaces.

## Questions

Open an issue or ping the maintainer.
