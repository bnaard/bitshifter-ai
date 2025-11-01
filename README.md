# bitshifter

Minimal repository for the Bitshifter paper and supporting sources (LaTeX, figures, and auxiliary materials).

## Quick start — build the paper locally
Prerequisites: a working LaTeX installation (TeX Live / MacTeX) and `latexmk`.

From the repository root:

```bash
cd /workspaces/bitshifter
cd doc/article
latexmk -pdf article.tex
```

This produces `article.pdf` (or similarly named PDF) in `doc/article/`.

## Continuous integration
A minimal GitHub Actions workflow is configured at `.github/workflows/latex.yml`. It runs on pushes and pull requests to `main`, compiles `doc/article/article.tex`, and uploads any generated PDF(s) as build artifacts so reviewers can download the compiled paper.

## Contributing
See `CONTRIBUTING.md` for branching rules, PR checklist, and how to run the build locally. Open pull requests against `main` and include a short description of changes and a link to any related issue.

## Files of interest
- `doc/article/article.tex` — main LaTeX source (build root)
- `doc/article/sections/` — section source files
- `.github/workflows/latex.yml` — CI build for LaTeX
- `CONTRIBUTING.md` — contribution guidelines and PR checklist

## License
See `LICENSE` if present. If there is no `LICENSE` file, please ask the maintainers before reusing code or figures.
