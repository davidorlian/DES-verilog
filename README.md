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
src/   - RTL implementation (DES core, Feistel, key schedule, S-boxes)
tb/    - Top-level testbench
sim/   - ModelSim automation (run.do)
docs/  - Presentation and documentation
```

Additional materials (module-level testbenches, Python scripts, reports) are preserved under the original project directories.

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

* Functional simulation: ✔ PASS
* Encryption output matches known DES reference vectors

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
