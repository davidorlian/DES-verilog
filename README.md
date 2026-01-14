# DES in Hardware (Verilog) — Course Final Project

This repository contains a full RTL (hardware) implementation of the DES block cipher, developed as a final project for the
course **"Algorithms in Cryptography and Verilog Implementation"**.

If you are not familiar with Verilog/HDL workflows:
- the **RTL** files describe the hardware blocks of DES (permutations, S-boxes, key schedule, and 16 Feistel rounds)
- a **testbench (TB)** is a simulation program that applies inputs and checks outputs
- a ModelSim **.do** file is a small script that automates compilation and simulation

## What we implemented (high level)

DES encrypts a **64-bit plaintext block** into a **64-bit ciphertext block** using a **64-bit key** (effective key size is
56 bits after parity drop).

This implementation includes:
- Initial permutation (IP) and inverse permutation (IP⁻¹)
- 16-round Feistel network
- DES F-function: Expansion **E**, XOR with round key, **S-box** layer, permutation **P**
- Full key schedule: **PC-1**, per-round left shifts, **PC-2** (16 round keys)
- Simulation verification via a main testbench with PASS/FAIL checks

## Repository map (where to look)

- `DES/des Implementation/` — main RTL implementation + main testbench
- `DES/test vectors/` — Python tooling used to generate/collect and parse verification vectors
- `DES/reports/` — reports/artifacts kept from the course workflow

## Main entry point

- RTL top: `DES/des Implementation/des_top.v`
- Main testbench: `DES/des Implementation/tb_des_top.v`

## Verification & reliable test vectors (Python tooling)

To verify the RTL against a trusted reference, we built a small Python pipeline that generates known-answer tests and can
also extract per-round intermediate values.

Workflow:
1. `DES/test vectors/des_scraper.py` uses Selenium to run an online DES reference demo and capture a detailed trace.
2. `DES/test vectors/parse_des_vectors.py` parses that trace into `des_test_vectors.txt` (Verilog-friendly format):
   plaintext, key, expected ciphertext, and optional intermediate round values.
3. `DES/test vectors/tb_generate.py` can generate assignment snippets for module-level testbenches using the parsed vectors.

The main DES testbench (`tb_des_top.v`) already contains a fixed set of vectors for a simple PASS/FAIL run.
The Python tools are kept for reproducibility and for deeper, module-level verification.

## Optional / legacy wrapper (IO/package constraint experiment)

`DES/des Implementation/des_top_wrapper.v` is an integration experiment that assembles 64-bit data/key through a narrower
32-bit bus-like interface with a simple `ready` handshake. It was motivated by FPGA package IO limitations when initially
targeting `xc7a35tcpg236-1`. Later the work moved to `xc7a75tfgg676-1`, so the **main flow** is `des_top.v + tb_des_top.v`.
The wrapper is kept for reference.

## Run (ModelSim)

1. Open ModelSim
2. Set the working directory to: `DES/des Implementation/`
3. Run the one-command script:
   - `do scripts/run_des_top.do`

(If you prefer: you can compile manually and run `vsim work.tb_des_top` then `run -all`.)

## Regenerating vectors (optional)

From `DES/test vectors/`:
- `python parse_des_vectors.py`  
  Runs the scraper on an example (plaintext/key) and writes `des_test_vectors.txt`.

- `python tb_generate.py`  
  Interactive helper that generates assignment snippets (e.g., for Feistel/IP/F-function submodules).

Note: the scraper uses Selenium and may require a local Chrome/Chromium installation and Python packages such as
`selenium` and `webdriver-manager`.

## Roadmap (optional next steps)

The RTL implementation is complete as submitted for the course. In the future, the following improvements could be added
without changing the existing RTL:
- Standardize all module testbenches to a single, consistent PASS/FAIL loop structure (fixed number of vectors, uniform
  printout of got/expected, final summary).
- Add more convenient ModelSim helper scripts to select and run a specific testbench target without editing compile/run
  commands.

## Credits
Developed by Runi Zukerman and David Orlian.

## Acknowledgements
This project was developed with assistance from ChatGPT. ChatGPT provided code drafting and documentation support. The overall architecture and approach were defined by the authors, and the implementation was iteratively refined through author-led design decisions, bug fixing, and simulation-based validation.
