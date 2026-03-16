# Contributing

Short guide to the project workflow.

## Branching

- `main` is protected and always buildable.
- Use short-lived branches with prefixes: `feat/`, `fix/`, `doc/`, `chore/`, `hotfix/`.

## Pull Requests

- Open PRs against `main`. Keep them small and focused.
- PR checklist:
  - [ ] LaTeX documents compile without errors
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
# Overview (50-page survey)
cd doc/overview && latexmk -lualatex -outdir=out overview.tex

# Theory book (102-page design document)
cd doc/theory && latexmk -lualatex -outdir=out book.tex
```

## DevContainer

The repository includes a DevContainer configuration with LuaLaTeX, Rust, and all required TeX packages. Open in VS Code with the Dev Containers extension or use GitHub Codespaces.

## Questions

Open an issue or ping the maintainer.
