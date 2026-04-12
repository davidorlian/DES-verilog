# Test Vector Tooling

This directory contains the Python-based verification tooling used to generate, collect, parse, and format DES reference vectors for Verilog simulation.

## Purpose

The goal of this tooling is to provide a **reference-driven verification flow**.

Instead of relying only on manually written vectors or AI-generated outputs, the verification flow uses a trusted external DES reference implementation and converts its results into formats suitable for RTL/module-level testbenches.

## Verification Flow

1. **Reference acquisition**  
   `des_scraper.py` uses Selenium to drive the JS-DES educational demo and collect DES execution traces from a trusted external implementation.

2. **Trace parsing and normalization**  
   `parse_des_vectors.py` parses the raw DES trace and extracts:
   - plaintext
   - key
   - expected ciphertext
   - intermediate round values such as:
     - initial L/R
     - round keys
     - expansion output
     - XOR with round key
     - S-box output
     - P-permutation output
     - round outputs

3. **Testbench-oriented output generation**  
   `tb_generate.py` converts parsed vector data into assignment snippets suitable for Verilog testbenches of individual RTL modules, including:
   - `ip`
   - `round_logic`
   - `f_function`
   - `sbox_layer`
   - `e_permutation`
   - `p_permutation`
   - `feistel`

## Files

- `des_scraper.py`  
  Collects DES reference traces from the external JS-DES implementation using Selenium.

- `parse_des_vectors.py`  
  Parses the collected trace and writes a normalized vector file (`des_test_vectors.txt`) for later processing.

- `tb_generate.py`  
  Generates module-specific assignment blocks for Verilog testbenches from the parsed reference data.

## Engineering Notes

This tooling was built to solve a verification reliability problem.

A key improvement was reducing runtime overhead by reusing the Selenium browser driver across multiple vector-generation iterations, instead of repeatedly creating a new browser session for each test case.

The overall approach provides:
- reliable reference outputs
- reusable intermediate DES states
- efficient generation of module-level verification data
- reduced dependence on manually written or AI-generated test vectors

## Requirements

- Python
- Selenium
- Chrome/Chromium
- `webdriver-manager` (if used in the local setup)

## 🚀 Usage

Example flow:

```bash
python parse_des_vectors.py
python tb_generate.py
```

## 🧠 Notes

- This tooling is intended for **verification support**, not as a standalone DES software implementation.
- The DES algorithm is **not fully reimplemented in Python** here; instead, Python is used to acquire and transform trusted reference data into verification assets.