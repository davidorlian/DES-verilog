# DES in Verilog

## Project Context

This project was developed as part of the course  
**"Cryptography Algorithms and Verilog Implementation"**.

The assignment required implementing the **Data Encryption Standard (DES)** algorithm in Verilog and demonstrating a complete digital design flow, including:

- RTL simulation
- synthesis
- place & route (P&R)
- post-place & route timing simulation

The implementation follows a loop-unrolled DES architecture, as specified in the assignment.

AI tools were used primarily to generate initial RTL code.

The generated code was often incomplete or incorrect and required significant manual work, including:
- debugging functional errors
- fixing incorrect logic and edge cases
- resolving integration issues between modules
- validating behavior through simulation

As a result, the final design reflects substantial independent verification, debugging, and refinement beyond the initial generated code.

A significant part of the effort was invested in verification infrastructure:
- building Python tooling for test-vector generation
- using an external trusted DES reference implementation
- parsing intermediate DES trace data into Verilog-friendly form
- generating module-level verification data for blocks such as `ip`, `f_function`, `e_permutation`, `p_permutation`, and `sbox_layer`

This project therefore reflects not only functional RTL design, but also verification methodology, full implementation flow, and result analysis.

---

## Architecture Overview

### System-Level Design

![DES System](docs/architecture/des_encryption_block_diagram.png)

The top-level module `des_top` integrates:
- `key_schedule`, which generates round keys
- `feistel`, which performs the 16-round Feistel network
- internal input, key, and output registers

---

### Feistel Network

![Feistel Network](docs/architecture/des_feistel_network.png)

This structure maps directly to the RTL modules:
- `ip` for the initial permutation
- `round_logic` for round-level transformation
- `f_function` for the core nonlinear round function
- `inv_ip` for the final permutation

---

### Key Schedule

![Key Schedule](docs/architecture/des_key_schedule.png)

The key-schedule implementation is decomposed into:
- `pc1` for the initial key permutation
- `key_round_step` for round shifting logic
- `pc2` for subkey generation

---

### f-function

![F Function](docs/architecture/des_f_function.png)

The internal structure of the DES round function includes:
- `e_permutation` for expansion from 32 to 48 bits
- `sbox_layer` for substitution using 8 S-boxes (`sbox1`–`sbox8`)
- `p_permutation` for the final permutation stage

---

### Reference

Base diagrams were adapted from FIPS PUB 46-3, with RTL module annotations corresponding to this implementation.

---

## Project Structure

```text
src/  - RTL implementation
        - DES core (des_top and submodules)
        - optional wrapper variant for alternative integration scenarios

tb/   - Verification environment
        - testbenches for modules and top-level designs

sim/  - ModelSim simulation scripts
        - primary flow uses des_top

docs/ - Reports, presentation, architecture diagrams, and test-vector tooling
```

---

## Test Vector Generation and Verification Tooling

To ensure reliable verification, a Python-based workflow was developed for generating and validating DES test vectors.

This workflow uses a trusted external DES implementation (JS-DES) as a reference and extracts both final outputs and intermediate round values. The generated data is then:
- parsed and normalized
- converted into Verilog-compatible testbench inputs
- reused for both module-level and system-level verification

This approach enables:
- reference-driven verification
- reuse of intermediate DES states across multiple modules
- reduced reliance on manually written or AI-generated test data

Additional details about the verification tooling are available in:  
`docs/test_vectors/README.md`

---

## Alternative Integration Wrapper

In addition to the main `des_top` implementation, this repository includes an optional wrapper module, `des_top_wrapper`, for reduced-I/O integration scenarios.

The wrapper allows loading the 64-bit DES key and input block through a 32-bit shared data bus using a selector-based interface. It also provides serialized access to the 64-bit result.

This variant was explored to support FPGA targets with limited I/O resources, where exposing full 64-bit interfaces is not practical.

While the primary simulation and implementation flow uses `des_top`, the wrapper is preserved as part of the project to document an alternative architectural approach and demonstrate integration flexibility.

---

## Simulation

Simulation is performed using ModelSim.

Run the full flow with:

```bash
vsim -do sim/run.do
```

This script:
- compiles all RTL and testbench files
- loads waveforms automatically
- runs the simulation to completion

---

## Verification

The design is verified using self-checking testbenches driven by reference-based test vectors.

The verification flow includes:
- known DES reference vectors
- module-level verification using parsed intermediate DES states
- automatic output comparison
- PASS/FAIL reporting in simulation

### Debugging Example

During verification, a systematic mismatch was observed between expected and simulated outputs.

By converting the hexadecimal outputs to binary representation, a clear pattern emerged:  
each bit was inverted (0 → 1, 1 → 0).

This observation indicated that the issue was not related to the core logic, but rather to an incorrect bit mapping.

Further inspection revealed an error in one of the permutation stages, where the bit ordering was implemented incorrectly.

This significantly reduced the debugging search space by focusing on permutation stages instead of functional logic.

After correcting the permutation mapping, the design produced the expected results.

This debugging process highlights the importance of:
- bit-level analysis
- recognizing systematic error patterns
- distinguishing between logic errors and data-path mapping issues

This allowed narrowing the issue to the permutation stage quickly, instead of investigating the full data path.

---

## Results

- Functional simulation: PASS (RTL and post-P&R)
- Encryption output matches known DES reference vectors

### FPGA Implementation

- Target device: Artix-7 FPGA
- Fmax (post-synthesis): ~55 MHz
- LUTs: ~1455
- Flip-flops: ~184

Detailed reports are available in `docs/reports/`.

---

## What This Project Demonstrates

- RTL implementation of a non-trivial cryptographic algorithm
- Design of a multi-stage datapath based on the DES Feistel architecture
- Modular hardware decomposition of key schedule, permutations, and substitution logic
- Reference-driven verification methodology
- Simulation, synthesis, place & route, and post-route timing validation
- Python-based automation for verification data preparation

---

## Full Project Presentation

The project presentation is available in:  
`docs/DES_Algorithm_Presentation.pptx`

---

## Credits

Developed by Runi Zukerman and David Orlian.