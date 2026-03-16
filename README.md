# Beyond Multiply-Accumulate: Bitwise Neural Computation

Research project exploring whether neural networks can be built from bitwise operations (AND, OR, XOR, table lookups) instead of floating-point multiply-accumulate — removing GPU dependency entirely.

## Project Goal

Replace traditional MAC-based neural network inference with bitwise logic, demonstrated on MNIST digit recognition and evaluated for scalability to large language models.

## Approach

Four paradigms are combined into a hybrid architecture:

| Paradigm | Core Operation | Role in Hybrid |
|----------|---------------|----------------|
| **Binary Neural Networks** | XNOR + popcount | Ternary weights for projections |
| **Tsetlin Machines** | Propositional clauses | Interpretable feature extraction |
| **Logic Gate Networks** | Learned 2-input gates | Flexible composition layer |
| **KAN / LUT Compilation** | Table lookups | Efficient deployment |

## Documents

- **Overview** (`doc/overview/`): 50-page survey of all four paradigms, transformer architecture primer, and scaling analysis for LLMs. Engineer-friendly, builds intuition before math.
- **Theory** (`doc/theory/`): 102-page detailed design document for the hybrid architecture — Boolean foundations through Rust implementation plan.

Build either document:
```bash
cd doc/overview && latexmk -lualatex -outdir=out overview.tex
cd doc/theory   && latexmk -lualatex -outdir=out book.tex
```

## Repository Structure

```
doc/
  overview/       Overview article (LuaLaTeX)
  theory/         Theory book (LuaLaTeX)
research/
  papers/         Referenced arXiv papers (PDFs)
```

## Implementation Stack

- **Language:** Rust (training + inference)
- **Documentation:** LuaLaTeX
- **Target:** CPU-only, no GPU dependency
- **Dataset:** MNIST (28x28 grayscale digits)

## Current Status

- Research and theory phase complete
- Overview and theory documents written with verified citations
- Scaling analysis for LLMs: all transformer components have demonstrated integer-only implementations; integration at scale is the open problem
- Next: Rust implementation of the hybrid architecture

## Owner

Bernhard Gerlach
