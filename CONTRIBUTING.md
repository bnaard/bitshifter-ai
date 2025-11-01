# Contributing

Thanks for helping improve this project. This is a short guide to our workflow and expectations so contributions stay small and reviewable.

## Branching and naming
- Keep `main` protected and always production-ready.
- Create short-lived branches for work, using one of these prefixes:
  - `feature/<short-desc>` or `feat/<short-desc>` for new features
  - `fix/<short-desc>` for bug fixes
  - `doc/<short-desc>` for documentation or paper edits
  - `hotfix/<short-desc>` for urgent fixes to `main`

## Pull requests (PRs)
- Open PRs against `main`.
- Keep PRs small and focused — one logical change per PR.
- Include a clear title, description, and list any files that must be reviewed (figures, equations, results).

Suggested PR checklist (authors should complete before requesting review):

- [ ] The branch builds locally (LaTeX compiles without errors).
- [ ] Figures and tables are updated and regenerated if necessary.
- [ ] No large generated artifacts (intermediate .aux/.log/etc.) are included; see `.gitignore`.
- [ ] Tests (if any) pass locally.
- [ ] At least one reviewer is requested.

## Building the paper locally
We use standard TeX toolchain (latexmk/TeX Live). To build the main paper from the repository root:

```bash
cd /workspaces/bitshifter
latexmk -pdf -jobname=article -cd doc/article/article.tex
```

Or from the `doc/article` directory:

```bash
cd doc/article
latexmk -pdf article.tex
```

If you don't have latexmk installed, install TeX Live or your system's LaTeX distribution. Mac users can use MacTeX; Ubuntu users can install `texlive-full` (or minimal sets if preferred).

## Code of conduct
Be respectful when giving feedback. If a larger design discussion is needed, open an issue first and link it in the PR.

## Questions
If you're unsure how to proceed with a contribution, open an issue or ping a maintainer in the PR.
