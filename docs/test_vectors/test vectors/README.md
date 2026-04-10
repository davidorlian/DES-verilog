# Test Vectors (Verification Tooling)

This folder contains Python utilities used to generate/collect and parse DES test vectors for simulation verification.

## Files
- `des_scraper.py` — collects DES vectors from an online reference demo (educational verification).
- `parse_des_vectors.py` — runs the scraper and parses the reference trace into a Verilog-friendly format.
- `tb_generate.py` — interactive helper to generate assignment blocks for module-level testbenches.

## Main outputs
- `des_test_vectors.txt` — parsed vectors in a format convenient for Verilog/TB usage (plaintext/key/expected ciphertext,
  and optionally intermediate round values depending on the trace).

## Quick usage
From this directory:
- Generate/parse an example vector file:
  - `python parse_des_vectors.py`
- Generate module-level assignment snippets (interactive):
  - `python tb_generate.py`

## Notes
- The vectors are used for simulation/verification only.
- The scraper uses Selenium; you may need local Chrome/Chromium and Python packages such as `selenium` and
  `webdriver-manager`.
