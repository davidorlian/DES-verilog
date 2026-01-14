# DES RTL Implementation

This folder contains the main DES RTL implementation and the primary testbench used for end-to-end verification.

## Main files
- `des_top.v` — main DES core top module
- `tb_des_top.v` — main testbench (PASS/FAIL using known vectors)

## Optional / legacy wrapper
- `des_top_wrapper.v` — optional integration experiment for a narrower interface (kept for reference)

## Subfolders
- `feistel/` — Feistel network, IP / inverse IP, F-function (E, S-boxes, P), round logic
- `key_schedule/` — PC-1, per-round shifts, PC-2, key schedule generation
- `Register/` — shared register module(s)

Note: Some subfolders include additional module-level testbenches (`tb_*.v`) used during development.

## Run (ModelSim)
From this directory:
- `do scripts/run_des_top.do`
