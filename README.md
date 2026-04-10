# DES in Verilog

Hardware implementation of the **Data Encryption Standard (DES)** algorithm in Verilog.

This project implements a full 16-round Feistel network, including key scheduling, permutations, and substitution boxes, with a complete simulation and verification flow.

---

## 🧠 Architecture

The design follows the standard DES structure:

* Initial Permutation (IP)
* 16-round Feistel network
* Expansion (E)
* Substitution (S-boxes)
* Permutation (P)
* Key schedule generation (PC1, shifts, PC2)
* Final Permutation (IP⁻¹)

The top-level module (`des_top`) integrates:

* 64-bit data and key registers
* Key schedule generation
* Full Feistel datapath
* Registered ciphertext output

---

## 📁 Project Structure

```
src/  - RTL implementation
        - DES core (des_top and submodules)
        - optional wrapper variants for alternative integration scenarios

tb/   - Verification environment (testbenches for all modules and top-level designs)

sim/  - ModelSim simulation scripts (primary flow uses des_top)

docs/ - Reports, presentation, and test vector generation tools
```

---

## 🔌 Alternative Integration (Wrapper)

In addition to the main `des_top` implementation, this repository includes an optional wrapper module (`des_top_wrapper`) for reduced-I/O integration scenarios.

The wrapper allows loading the 64-bit DES key and input block through a 32-bit shared data bus using a selector-based interface. It also provides serialized access to the 64-bit result.

This variant was explored to support FPGA targets with limited I/O resources, where exposing full 64-bit interfaces is not practical.

While the primary simulation and implementation flow uses `des_top`, the wrapper is preserved as part of the project to document an alternative architectural approach and demonstrate integration flexibility.

---

## ⚙️ Simulation

Simulation is performed using ModelSim.

Run the full flow with:

```bash
vsim -do sim/run.do
```

This script:

* Compiles all RTL and testbench files
* Loads waveforms automatically
* Runs the simulation to completion

---

## ✅ Verification

The design is verified using a **self-checking testbench**:

* Known DES test vectors are applied
* Outputs are compared automatically
* PASS/FAIL is printed per test case

---

## 📊 Results

- Functional simulation: ✔ PASS  
- Encryption output matches known DES reference vectors  

### FPGA Implementation

- Target device: Artix-7 FPGA  
- Fmax (post-synthesis): ~55 MHz  
- LUTs: ~1455  
- Flip-flops: ~184  

Detailed reports are available in `docs/reports/`.

---

## 🧩 What this project demonstrates

* RTL implementation of a non-trivial cryptographic algorithm
* Design of a multi-stage datapath (Feistel architecture)
* Modular hardware design (key schedule, S-boxes, permutations)
* Self-checking verification methodology
* Simulation automation using ModelSim

---

## 📄 Full Project Presentation

See full project slides in:
`docs/DES_Algorithm_Presentation.pptx`

---

## Credits

Developed by Runi Zukerman and David Orlian.
