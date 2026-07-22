<!-- aibox-managed:latex-guidance -->
# LaTeX Project Workflow

Build and watch LaTeX only inside the development container. The managed scripts below apply the project's configured engine, options, output directories, and project-local TeX caches. The read-only preview sidecar serves completed PDFs and never compiles source files.

| Document | Source | Build | Watch | Preview |
|---|---|---|---|---|
| `overview` | `doc/overview/overview.tex` | `aibox-latex-build overview` | `aibox-latex-watch overview` | `http://127.0.0.1:8766/documents/overview/` |
| `theory` | `doc/theory/book.tex` | `aibox-latex-build theory` | `aibox-latex-watch theory` | `http://127.0.0.1:8766/documents/theory/` |

Run `aibox-latex-build` with no argument to build every configured document. Run one `aibox-latex-watch <name>` process per document that should rebuild continuously; stop it with Ctrl-C. Host-side `aibox up` starts the shared Compose preview sidecar when `latex.preview.enabled = true`. The sidecar index is at `http://127.0.0.1:8766/`. Loopback previews on a remote host require SSH port forwarding.
