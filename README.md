# 📡 Information Theory & Digital Communications Assignment

> A MATLAB-based project covering core **Information Theory** and **Digital Communications** concepts, including source coding (Huffman & Lempel–Ziv), entropy-rate analysis, and iterative decoding over noisy channels.

---

## ✨ Overview

This repository contains the implementation and report for an assignment in digital communications (taught by **Dr. Behnia**), focused on practical coding and decoding workflows.

The project includes:

- 🧠 **Source Coding** with custom Huffman and Lempel–Ziv implementations.
- 📊 **Entropy & Efficiency Analysis** for block sources with different block lengths.
- 📶 **Channel Decoding** using a Sum-Product style iterative decoder under a noisy BPSK setting.
- 📝 A consolidated report in `Assignment1.pdf`.

---

## 🗂️ Repository Structure

- `Assignment1.pdf` — Assignment report and documented results.
- `Q1.m` — Main script for Question 1 (source coding, compression ratios, dictionary cost, entropy comparison).
- `myHuffman.m` — Custom Huffman encoder used in Q1.
- `myLempelziv.m` — Custom Lempel–Ziv-style encoder used in Q1.
- `Q2.m` — Entropy-rate and coding-efficiency analysis for grouped source symbols.
- `Q3.m` — BPSK simulation with iterative Sum-Product decoding and decoding accuracy evaluation.

---

## 🔬 What Each Question Covers

### 1) `Q1.m` — Source Coding Benchmark

- Generates a 5000-symbol synthetic English-like source using letter probabilities.
- Encodes the source with:
  - Huffman coding (`myHuffman.m`)
  - Lempel–Ziv coding (`myLempelziv.m`)
- Compares:
  - ⚖️ Compression ratio vs fixed-length 5-bit symbol coding
  - 💾 Dictionary storage overhead
  - 📉 Average code length per symbol
  - 📚 Source entropy reference

---

### 2) `Q2.m` — Block Entropy Rate & Huffman Efficiency

- Simulates a binary source (`-1`, `1`) with non-uniform probability.
- Builds grouped symbols of size `k = 1..10`.
- Computes:
  - `G_k = H(X_1, ..., X_k)/k`
  - Mean Huffman length per original symbol
  - Coding efficiency trend
- Plots all three metrics to visualize convergence behavior.

---

### 3) `Q3.m` — Iterative Decoding over AWGN

- Generates a random binary codeword.
- Applies BPSK modulation and additive Gaussian noise.
- Performs iterative message passing with a Sum-Product update routine.
- Reports reconstruction accuracy after fixed iterations.

---

## 🚀 How to Run

> Requires **MATLAB** (or a compatible environment that supports the used functions).

Run each question script independently:

```matlab
Q1
Q2
Q3
```

Expected behavior:

- `Q1`: printed compression/entropy/dictionary statistics
- `Q2`: generated plots for entropy rate, mean code length, and coding efficiency
- `Q3`: printed decoding accuracy percentage

---

## 🧩 Methods & Topics Demonstrated

- Entropy and source modeling
- Huffman coding (custom implementation)
- Lempel–Ziv dictionary parsing and binary serialization
- Block-source analysis and coding efficiency
- BPSK over AWGN
- Iterative message passing (Sum-Product style)

---

## 📌 Suggested GitHub “About” Description

**Short professional description:**

> MATLAB implementations of information theory and digital communications algorithms: Huffman/Lempel–Ziv source coding, entropy-rate analysis, and iterative BPSK decoding.

**Optional website/about tagline:**

> From source entropy to noisy-channel decoding — practical coding experiments in MATLAB.

---

## 👤 Author

- **Ilia Hashemi Rad**

---

## 📄 License

This repository is currently provided for academic and educational use. Add a formal `LICENSE` file (e.g., MIT) if you plan to distribute or reuse the code publicly.
