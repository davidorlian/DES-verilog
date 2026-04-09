# DES in Verilog

Hardware implementation of the **Data Encryption Standard (DES)** algorithm in Verilog.

This project implements a full 16-round Feistel network, including key scheduling, permutations, and substitution boxes.

---

## 🧠 Architecture

- Initial Permutation (IP)
- 16-round Feistel network
- Expansion (E)
- Substitution (S-boxes)
- Permutation (P)
- Key schedule generation
- Final Permutation (IP⁻¹)

---

## ✅ Verification

The design is verified using a **self-checking testbench**:

- Known DES test vectors are applied
- Output is compared automatically
- PASS/FAIL result is printed

---

## ⚙️ Simulation

Tested using **ModelSim**.

### Quick Run
1. Compile all files
2. Run `tb_des_top`
3. Observe PASS/FAIL output

---

## 📊 Results

- Functional simulation: ✔ PASS
- Correct encryption output verified against reference vectors

---

## 🧩 What this project demonstrates

- RTL implementation of a non-trivial cryptographic algorithm
- Design of multi-stage datapath (Feistel structure)
- Testbench development and automated verification
- Debugging at signal level using simulation tools
