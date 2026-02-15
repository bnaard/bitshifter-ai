# Project Plan

## Phases & Milestones
| Phase          | Tasks                                                                 | Timeline  | Owner               |
|----------------|-----------------------------------------------------------------------|-----------|---------------------|
| Research       | Literature review; collect papers on bit-op models vs. MAC-based.    | Weeks 1-4 | Model Researcher    |
| Design         | MNIST model architecture (bit ops only); LaTeX design paper.         | Weeks 3-6 | Architect           |
| Python PoC     | Jupyter prototypes (MAC baseline + bitwise model); benchmarking.     | Weeks 5-10| Software Engineer   |
| Rust PoC       | Optimized CPU implementation (SIMD, parallelism).                     | Weeks 11-14| Software Engineer   |
| Validation     | Benchmarking; draft whitepaper.                                      | Weeks 15-16| Project Manager     |

## Dependencies
- Research → Design → Implementation → Validation.
- LaTeX papers updated iteratively.

## Resources
- Tools: PyTorch, Rust (`ndarray`), LaTeX, Jupyter.
- Data: MNIST dataset.
- Agents: Model Researcher, Architect, Software Engineer.
