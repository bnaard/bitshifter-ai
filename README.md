# Bitshifter AI: Bitwise Neural Computation

<p align="center">
  <img src="assets/brand/bitshifter-logo.svg" alt="Bitshifter AI logo"
    width="144">
</p>

Research project exploring whether neural networks can be built from bitwise
operations (AND, OR, XOR, and table lookups) instead of floating-point
multiply-accumulate operations.

## Project Goal

Develop and evaluate CPU-first building blocks that can complement or replace
traditional MAC-based neural-network inference. The initial proof of concept
targets MNIST digit recognition; the accompanying research assesses how far
the approach may generalise to language models.

## Approach

Four paradigms are combined into a hybrid architecture:

| Paradigm | Core Operation | Role in Hybrid |
|----------|---------------|----------------|
| **Binary Neural Networks** | XNOR + popcount | Ternary weights for projections |
| **Tsetlin Machines** | Propositional clauses | Interpretable feature extraction |
| **Logic Gate Networks** | Learned 2-input gates | Flexible composition layer |
| **KAN / LUT Compilation** | Table lookups | Efficient deployment |

## Read the Documents

- **Overview** (`doc/overview/`): survey of the four paradigms, a
  transformer primer, and LLM-scaling analysis. It builds intuition before
  introducing the formal details.
- **Theory** (`doc/theory/`): detailed design document for the hybrid
  architecture, from Boolean foundations through a Rust implementation plan.

## Build and Preview

The project scripts are the canonical document-build interface. Run them from
the repository root, inside the development container:

```bash
./scripts/build-documents.sh overview
```

Start the host-side Aibox environment with `aibox up`, then open the browser
companion at [http://127.0.0.1:8766/](http://127.0.0.1:8766/). The companion
serves completed PDFs only and refreshes after a successful rebuild.

For continuous rebuilding while editing:

```bash
./scripts/build-documents.sh watch overview
```

The optional terminal-preview workflow is intended for a tmux client running
WezTerm:

```bash
./scripts/watch-document.sh overview
```

Use `PREVIEW_PROTOCOL=symbols` for the portable text-only fallback.

## Repository Structure

```
doc/
  overview/       Overview article (LuaLaTeX)
  theory/         Theory book (LuaLaTeX)
research/
  papers/         Offline research copies and provenance index
assets/
  brand/          Canonical project logo
```

## Implementation Stack

- **Language:** Rust (training + inference)
- **Documentation:** LuaLaTeX
- **Target:** CPU-only, no GPU dependency
- **Dataset:** MNIST (28x28 grayscale digits)

## Current Status

- The repository is currently in the research and architecture-design phase.
- The overview and theory documents define and assess candidate building
  blocks; they are not evidence of a completed production implementation.
- The immediate milestone is a Rust MNIST benchmark that compares packed
  bitwise, LUT, and low-bit integer blocks against the same CPU baseline.
- LLM-scale integration remains an open research problem.

## Research Corpus

`research/papers/` contains convenience copies of selected openly available
papers for offline reading. The index records the citation key and source
identifier. Paper copyrights and licence terms remain with their respective
authors and publishers; use the canonical source when redistributing or
verifying a version.

## Citation and License

Use [`CITATION.cff`](CITATION.cff) to cite this repository. The project itself
is released under the [MIT License](LICENSE).

## AI-Assisted Project Disclaimer

This project, including its research synthesis and documentation, was created
with substantial assistance from AI systems. The owner directs the research
questions, architectural direction, and editorial decisions, but AI-generated
material may contain errors, omissions, unsupported claims, or hallucinations.
Do not treat the documents as a substitute for reading the cited primary
sources, reproducing experiments, or obtaining expert review.

## Maintainer

Bernhard Gerlach
