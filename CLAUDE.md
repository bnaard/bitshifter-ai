# Bitwise AI Research Project

## Project Overview
Research project exploring bit-operation-based neural networks for MNIST digit recognition.
Goal: Replace traditional MAC (multiply-accumulate) operations with bitwise logic, removing GPU dependency.

**Owner:** Bernhard Gerlach
**Implementation stack:** Rust (full training + inference)
**Documentation:** LuaLaTeX

## Key Decisions

### 2026-02-14 (from original decisions.log)
- Repository restructured with `/context/` for project documentation
- LaTeX-based scientific paper approach confirmed
- MNIST dataset selected
- Python (Jupyter) and Rust implementation stack chosen
- MAC-based baseline model approved for comparison

### 2026-03-16 (current session)
- **Model approach:** Hybrid of Tsetlin Machines + Logic Gate Networks, incorporating LUT/KAN compilation
- **Four paradigms identified:**
  1. Binary/Ternary Neural Networks (XNOR-Net, BitNet b1.58)
  2. Tsetlin Machines (propositional logic, automata-based)
  3. Differentiable Logic Gate Networks (learnable gate connectivity)
  4. KAN/LUT compilation (train with learnable activations, compile to lookup tables)
- **Implementation:** Full Rust (training + inference), not Python->Rust. User wants to learn Rust.
- **Benchmarking:** Against standard FP32 MLP/CNN baseline on MNIST
- **Theory first:** Write theory document before any implementation
- **LaTeX documents:** Start fresh, discard existing scaffold in `/doc/article/`
- **Document plan:**
  1. Overview article: accessible intro to all four paradigms, engineer-friendly, building from basics to math
  2. Theory book: detailed model design document for the hybrid approach
  3. Implementation follows after theory is solid
- **Writing style:** Accessible to engineers, not academic researchers. Build concepts gradually. Use diagrams. Formalize only after intuition is established.

## Research Findings

### Binary/Ternary Neural Networks
- XNOR-Net: 56x CPU speedup, 32x memory reduction by approximating convolutions with XNOR+popcount
- BitNet b1.58: ternary weights {-1, 0, +1}, 10x memory reduction at 70B scale
- ARM NEON: 1.37x-5.07x speedup; x86 AVX-512: 2.37x-6.17x speedup
- Well-proven on MNIST, most mature paradigm

### Tsetlin Machines
- Logic-based learning using propositional clauses and automata
- 99.35% on MNIST with interpretable structure
- Game-theoretic convergence proofs exist
- Regression and autoencoder variants available
- Key strength: interpretability and formal verifiability

### Differentiable Logic Gate Networks (LGNs)
- Learnable gate connectivity (which gate: AND/OR/XOR/etc. is itself learned)
- Hardware-native optimization (maps directly to FPGA/ASIC)
- Most novel paradigm, least mature
- Combines neural training with logic gate inference

### KAN / LUT Compilation (new finding, 2026-03-16)
- Kolmogorov-Arnold Networks: learnable B-spline functions on edges, no fixed activations
- Key insight: trade memory for computation (store complex functions, reduce connections needed)
- LUT-compiled KANs: 68x speedup, <0.04% accuracy loss after compiling splines to int8 tables
- KAN on MNIST via FPGA LUT: 98.02% accuracy
- ULEEN (Weightless Neural Networks): 96.2% MNIST, 16.9 kB model, 0.21 us latency, pure table lookups
- PolyLUT/NeuraLUT: embed learned polynomials inside FPGA lookup tables
- LAB (Learnable Activation Binarizer): improves BNNs by making binarization threshold learnable

### Key References
- KAN: Kolmogorov-Arnold Networks (arXiv:2404.19756, Liu et al. 2024)
- LUT-Compiled KAN for IoT (arXiv:2601.08044)
- ULEEN (arXiv:2304.10618)
- PolyLUT (arXiv:2309.02334)
- LAB: Learnable Activation Binarizer (arXiv:2210.13858)
- BitNet b1.58: "The Era of 1-bit LLMs" (arXiv:2402.17764)
- Tsetlin Machine (ResearchGate, original paper by Ole-Christoffer Granmo)
- BNN on FPGA for MNIST (arXiv:2512.19304)
- Binary Neural Networks: A Survey (arXiv:2004.03333)

### Proposed Hybrid Architecture (working hypothesis)
Train with expressive learnable activations (KAN splines or similar), use Tsetlin Machine automata
for interpretable clause learning, structure the inference network as Logic Gate Networks, then
compile learned functions to binary LUTs for deployment. This gives:
- Accuracy from complex training-time activations
- Interpretability from Tsetlin clause structure
- Hardware efficiency from logic gate inference
- Minimal memory footprint from LUT compilation

## Future Vision: Bitwise World Models for Sound Synthesis (2026-03-16)

### The Question
Could the bitwise hybrid approach serve for creating "world models" -- specifically,
a super-specialized model that generates physically accurate sounds (glass breaking
on concrete, a stick hitting a tree, a plucked metal string in a specific room)?

### Two Possible Approaches

**Approach A: Decomposed pipeline (conservative)**
Binary scene understanding -> parameter estimation -> classical DSP synthesis.
Each stage plays to bitwise strengths. Lower risk, but limits novelty.

**Approach B: End-to-end neural sound generation (ambitious, user-preferred)**
A neural network that LEARNS the physics implicitly from data, similar to how image
diffusion models learn optics without ray tracers. The model learns what shattering
glass sounds like from recordings, potentially capturing chaotic/nonlinear physics
that classical DSP can't model (fractures, multi-impact events, frequency scattering).
The bitwise angle is the novel contribution -- nobody is doing this.

User preference: Approach B. The classical DSP backend is a fallback, not the goal.
The key analogy: image models predict pixels without physics engines; this model
should predict audio samples without DSP algorithms.

### Challenges for Approach B
- Sampling rate: 44.1kHz requires temporal coherence over thousands of samples
- Ear sensitivity to temporal artifacts is higher than eye to spatial artifacts
- Mitigations: latent space generation, spectrogram prediction (2D like images),
  multi-scale generation (coarse then refine)

### Three Nested Research Questions (incremental)
1. Can a neural network generate physically accurate sound end-to-end? (Medium risk)
2. Can it learn an implicit physical world model for acoustics? (High risk)
3. Can it do so using bitwise/binary operations? (Very high risk, very high novelty)

MNIST project is the prerequisite for question 3. Questions 1-2 can use FP first.

### What's Realistic
- Hybrid parameter estimator + classical DSP synthesis (near-term)
- LUT-compiled KANs for learned transfer functions (near-term)
- Logic gate networks for real-time audio effects (proven in GSoC 2024, lo-fi quality)

### What's Plausible but Unproven
- Binary "world model" predicting acoustic latent dynamics (JEPA-style)
- Recurrent Logic Gate Networks for temporal audio modeling (RDDLGNs paper 2025)
- Tsetlin Machines for acoustic feature regression

### What's Speculative
- End-to-end binary network generating high-fidelity audio (fundamental bit-depth mismatch)
- Replacing billion-parameter diffusion models with binary equivalents

### Key References
- GSoC 2024: Differentiable Logic for Generative Music (ijc8.me/2024/08/26/gsoc-difflogic/)
- KANELE: KAN on FPGA (arXiv:2512.12850)
- Recurrent DDLGNs (arXiv:2508.06097)
- DDSP: Differentiable Digital Signal Processing (magenta.tensorflow.org/ddsp)
- PTR physics-informed engine sound (arXiv:2603.09391)
- C-JEPA: 1.02% of latent tokens for world model (compression insight)
- Conv. Diff. Logic Gate Networks, NeurIPS 2024 Oral (arXiv:2411.04732)

### Key Insight
Classical physical modeling synthesis (Karplus-Strong, waveguide) already operates
with near-bitwise operations: delay lines + low-pass filters (averaging = bit shift).
The neural component only needs to ESTIMATE PARAMETERS for these algorithms, not
generate audio directly. This is a much smaller, tractable problem for bitwise networks.

## Project Structure
- `/context/` - Project governance (vision, plan, risks, stakeholders, roadmap)
- `/research/` - Literature review PDF (14 pages, 66 references)
- `/doc/` - LaTeX documents (being rebuilt from scratch)
- DevContainer with LuaLaTeX, latexmk, full TeX Live

## Working Conventions
- LaTeX engine: LuaLaTeX via latexmk
- Output directory: `./out`
- Commit style: `type: short description` (feat, fix, doc, chore, refactor, test)
- Branch strategy: protected main, feature branches
