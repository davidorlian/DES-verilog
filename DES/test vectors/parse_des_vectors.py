"""
parse_des_vectors.py
DES Test Vector Generator
Parses DES trace output and generates test vectors for Verilog implementation
"""
from des_scraper import run_des_test_vectors


def parse_des_trace_from_text(des_trace_text, output_file):
    """Parse DES trace text directly and generate formatted test vectors"""

    test_vectors = {}
    lines = des_trace_text.strip().split('\n')

    # Parse each line and extract key-value pairs
    for line in lines:
        line = line.strip()
        if not line:
            continue
        if line[:6] == 'Output':
            line = line[:6] + ":" + line[6:]
        if line[:6] == 'LR[16]':
            line = line[:6] + ":" + line[6:]

        # Split on colon to get key and value
        if ':' in line:
            parts = line.split(':', 1)
            key = parts[0].strip()
            value = parts[1].strip()

            # Clean up the value (remove spaces)
            value = value.replace(' ', '')

            # Store the parsed data
            test_vectors[key] = value

    # Generate output file with formatted test vectors
    with open(output_file, 'w') as f:
        f.write("// DES Test Vectors - Clean Format\n")
        f.write("// Generated from DES trace output\n\n")

        # Input and Key
        if 'Input bits' in test_vectors:
            f.write("// Input values\n")
            input_hex = bin_to_hex(test_vectors['Input bits'])
            f.write(f"INPUT_PLAINTEXT = 64'h{input_hex};\n")

        if 'Key bits' in test_vectors:
            key_hex = bin_to_hex(test_vectors['Key bits'])
            f.write(f"INPUT_KEY = 64'h{key_hex};\n\n")

        # Final output
        if 'Output' in test_vectors:
            f.write("// Output value\n")
            output_hex = bin_to_hex(test_vectors['Output'])
            f.write(f"EXPECTED_CIPHERTEXT = 64'h{output_hex};\n\n")

        # Initial values
        f.write("// Initial Values\n")
        if 'L[0]' in test_vectors:
            l0_hex = bin_to_hex(test_vectors['L[0]'])
            f.write(f"INITIAL_L = 32'h{l0_hex};\n")

        if 'R[0]' in test_vectors:
            r0_hex = bin_to_hex(test_vectors['R[0]'])
            f.write(f"INITIAL_R = 32'h{r0_hex};\n\n")

        # Process each round
        for round_num in range(1, 17):
            f.write(f"// Round {round_num}\n")

            # Round key
            key_name = f'KS[{round_num}]'
            if key_name in test_vectors:
                ks_hex = bin_to_hex(test_vectors[key_name])
                f.write(f"{key_name} = 48'h{ks_hex};\n")

            # Find round-specific data
            round_data = extract_round_data(lines, round_num)

            # Expansion (E)
            if 'E' in round_data:
                e_hex = bin_to_hex(round_data['E'])
                f.write(f"E[{round_num}] = 48'h{e_hex};\n")

            # E XOR KS
            if 'E xor KS' in round_data:
                exor_hex = bin_to_hex(round_data['E xor KS'])
                f.write(f"E_XOR_KS[{round_num}] = 48'h{exor_hex};\n")

            # S-box output
            if 'Sbox' in round_data:
                sbox_hex = bin_to_hex(round_data['Sbox'])
                f.write(f"SBOX[{round_num}] = 32'h{sbox_hex};\n")

            # Permutation (P)
            if 'P' in round_data:
                p_hex = bin_to_hex(round_data['P'])
                f.write(f"P[{round_num}] = 32'h{p_hex};\n")

            # L[i] and R[i] (output of round)
            if 'L[i]' in round_data:
                li_hex = bin_to_hex(round_data['L[i]'])
                f.write(f"L_OUT[{round_num}] = 32'h{li_hex};\n")

            if 'R[i]' in round_data:
                ri_hex = bin_to_hex(round_data['R[i]'])
                f.write(f"R_OUT[{round_num}] = 32'h{ri_hex};\n")

            f.write("\n")

        # Final LR[16] value
        if 'LR[16]' in test_vectors:
            lr16_hex = bin_to_hex(test_vectors['LR[16]'])
            f.write(f"// Final Values\n")
            f.write(f"FINAL_RL = 64'h{lr16_hex};\n")


def extract_round_data(lines, round_num):
    """Extract all data for a specific round"""
    round_data = {}
    in_round = False

    for i, line in enumerate(lines):
        line = line.strip()

        # Check if we're entering the target round
        if f'Round {round_num}' in line:
            in_round = True
            continue

        # Check if we're entering the next round
        if in_round and f'Round {round_num + 1}' in line:
            break

        # Extract data if we're in the target round
        if in_round and ':' in line:
            parts = line.split(':', 1)
            key = parts[0].strip()
            value = parts[1].strip().replace(' ', '')
            round_data[key] = value

    return round_data


def bin_to_hex(binary_string):
    """Convert binary string to hexadecimal"""
    # Remove any spaces
    binary_string = binary_string.replace(' ', '')

    # Convert binary to integer, then to hex
    try:
        decimal_value = int(binary_string, 2)
        hex_value = format(decimal_value, 'X')

        # Pad with zeros if needed
        expected_length = len(binary_string) // 4
        if len(binary_string) % 4 != 0:
            expected_length += 1

        hex_value = hex_value.zfill(expected_length)
        return hex_value
    except ValueError:
        return "ERROR"


def main(plaintext, key, num_inputs=1, driver=None):
    if __name__ == "__main__":
        print("Running DES scraper...")

    # Call scraper and handle return value
    if num_inputs == 1:
        des_trace_data = run_des_test_vectors(plaintext, key, num_inputs=1)
    else:
        des_trace_data, driver = run_des_test_vectors(plaintext, key, num_inputs, driver)

    output_file = "des_test_vectors.txt"

    try:
        parse_des_trace_from_text(des_trace_data, output_file)
        print(f"✅ Test vectors generated successfully in {output_file}")
        return driver  # Return updated driver if reused
    except Exception as e:
        print(f"❌ Error processing data: {e}")
        return None


if __name__ == "__main__":
    plaintext = "0123456789ABCDEF"
    key = "133457799BBCDFF1"
    main(plaintext, key)