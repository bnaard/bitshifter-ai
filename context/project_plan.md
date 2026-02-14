# Project Plan

## Phases & Milestones
| Phase          | Tasks                                                                 | Timeline  | Owner               |
|----------------|-----------------------------------------------------------------------|-----------|---------------------|
| Research       | Literature review; collect papers on bit-op models vs. MAC-based.    | Weeks 1-4 | Model Researcher    |
| Design         | MNIST model architecture (bitwise layers, training approach).        | Weeks 5-6 | Collaborative       |
| Python PoC     | Jupyter prototype; validate accuracy/speed vs. MAC baseline.          | Weeks 7-10| Software Engineer*  |
| Rust PoC       | Optimized CPU implementation (SIMD, parallelism).                     | Weeks 11-14| Software Engineer*  |
| Validation     | Benchmarking; draft whitepaper.                                      | Weeks 15-16| Project Manager     |

*Software Engineer agent to be added.

## Dependencies
- Research → Design → Implementation → Validation.
- LaTeX paper updated iteratively.

## Resources
- Tools: PyTorch, Rust (`ndarray`), LaTeX.
- Data: MNIST dataset.
