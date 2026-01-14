# tb_generate.py
import random
from parse_des_vectors import main as parse_main


def random_hex(bits):
    return f"{random.getrandbits(bits):0{bits//4}X}"


def generate_feistel_assignments(vectors, output_file):
    lines = []

    lines.append(f"data_in = 64'h{vectors['INPUT_PLAINTEXT']};")

    for i in range(16):
        rk = vectors.get(f"KS[{i+1}]", None)
        if rk:
            lines.append(f"round_key_{i} = 48'h{rk};")

    with open(output_file, 'a') as f:
        f.write("\n".join(lines))
        f.write("\n\n")


def generate_ip_assignments(vectors, input_value, output_file):
    ip_line = f"in_vec[{input_value[0]}] = 64'h{input_value[1]}; exp_vec[{input_value[0]}] = 64'h{vectors['INITIAL_L']}{vectors['INITIAL_R']};"
    with open(output_file, 'a') as f:
        f.write(ip_line + '\n')

def generate_round_logic_assignments(vectors, input_value, output_file):
    in64 = vectors['INITIAL_L'] + vectors['INITIAL_R']
    print(in64)
    key = vectors['KS[1]']
    print(key)
    out64 = vectors['L_OUT[1]'] + vectors['R_OUT[1]']
    print(out64)
    line = f"in_vec[{input_value[0]}] = 64'h{in64}; key_vec[{input_value[0]}] = 48'h{key}; exp_vec[{input_value[0]}] = 64'h{out64};"
    with open(output_file, 'a') as f:
        f.write(line + '\n')


def generate_f_function_assignments(vectors, input_value, output_file):
    R_in = vectors['INITIAL_R']
    key = vectors['KS[1]']
    fout = vectors['P[1]']
    line = f"R_vec[{input_value[0]}] = 32'h{R_in}; K_vec[{input_value[0]}] = 48'h{key}; expected_out[{input_value[0]}] = 32'h{fout};"
    with open(output_file, 'a') as f:
        f.write(line + '\n')


def generate_sbox_layer_assignments(vectors, input_value, output_file):
    sbox_in = vectors['E_XOR_KS[1]']
    sbox_out = vectors['SBOX[1]']
    line = f"in_vec[{input_value[0]}] = 48'h{sbox_in}; expected_out[{input_value[0]}] = 32'h{sbox_out};"
    with open(output_file, 'a') as f:
        f.write(line + '\n')


def generate_p_function_assignments(vectors, input_value, output_file):
    p_in = vectors['SBOX[1]']
    p_out = vectors['P[1]']
    line = f"test_data[{input_value[0]}] = 32'h{p_in}; expected_outs[{input_value[0]}] = 32'h{p_out};"
    with open(output_file, 'a') as f:
        f.write(line + '\n')


def generate_e_function_assignments(vectors, input_value, output_file):
    e_in = vectors['INITIAL_R']
    e_out = vectors['E[1]']
    line = f"in_vec[{input_value[0]}] = 32'h{e_in}; expected_out[{input_value[0]}] = 48'h{e_out};"
    with open(output_file, 'a') as f:
        f.write(line + '\n')


def parse_vectors_to_dict(filename):
    vectors = {}
    with open(filename, 'r') as f:
        for line in f:
            if '=' in line:
                parts = line.split('=')
                key = parts[0].strip().split()[0]  # first word before '='
                val = parts[1].strip().strip(';').split("'h")[-1]
                vectors[key] = val.upper()
            elif 'KEY' in line and '=' in line:
                parts = line.split('=')
                key = parts[0].strip()
                val = parts[1].strip().strip(';').split("'h")[-1]
                round_num = len([k for k in vectors if k.startswith("KS[")]) + 1
                vectors[f"KS[{round_num}]"] = val.upper()
    return vectors


def main():
    print("=== Testbench Generator ===")
    mode = input("Select testbench type (feistel / ip / round_logic / f_function / sbox_layer / p_function / e_function) [Default: feistel]: ").strip().lower()
    if mode not in ['feistel', 'ip', 'round_logic', 'f_function', 'sbox_layer', 'p_function', 'e_function', '']:
        print("Invalid mode. Choose 'feistel' or 'ip' or round_logic or f_function.")
        return
    mode = 'feistel' if mode == '' else mode

    try:
        num_inputs = int(input("Enter number of test vectors [Default: 1]: ").strip())
    except ValueError:
        num_inputs = 1

    output_file = {
        "feistel": "feistel_assignments.txt",
        "ip": "ip_assignments.txt",
        "round_logic": "round_logic_assignments.txt",
        "f_function": "f_function_assignments.txt",
        "sbox_layer": "sbox_layer_assignments.txt",
        "p_function": "p_function_assignments.txt",
        "e_function": "e_function_assignments.txt"
    }.get(mode, "output.txt")

    open(output_file, 'w').close()  # Clear file before writing

    print(f"\nGenerating {num_inputs} test vector(s) for {mode.upper()}...\n")

    driver = None
    for i in range(num_inputs):
        if mode == "feistel":
            pt = random_hex(64)
            key = random_hex(64)
            print(f"Test {i+1}: plaintext={pt}, key={key}")

            driver = parse_main(pt, key, num_inputs - i + 1, driver)  # This calls the scraper inside
            vectors = parse_vectors_to_dict("des_test_vectors.txt")
            generate_feistel_assignments(vectors, output_file)

        elif mode == "ip":
            pt = random_hex(64)
            print(f"Test {i+1}: input={pt}")

            driver = parse_main(pt, "0000000000000000", num_inputs - i + 1, driver)  # dummy key for IP only
            vectors = parse_vectors_to_dict("des_test_vectors.txt")
            generate_ip_assignments(vectors, (i, pt), output_file)

        elif mode == "round_logic":
            pt = random_hex(64)
            key = random_hex(64)
            print(f"Test {i + 1}: input={pt}")
            driver = parse_main(pt, key, num_inputs - i + 1, driver)
            vectors = parse_vectors_to_dict("des_test_vectors.txt")
            generate_round_logic_assignments(vectors, (i, pt), output_file)

        elif mode == "f_function":
            pt = random_hex(64)
            key = random_hex(64)
            print(f"Test {i + 1}: input={pt}")
            driver = parse_main(pt, key, num_inputs - i + 1, driver)
            vectors = parse_vectors_to_dict("des_test_vectors.txt")
            generate_f_function_assignments(vectors, (i, pt), output_file)

        elif mode == "sbox_layer":
            pt = random_hex(64)
            key = random_hex(64)
            print(f"Test {i + 1}: input={pt}")
            driver = parse_main(pt, key, num_inputs - i + 1, driver)
            vectors = parse_vectors_to_dict("des_test_vectors.txt")
            generate_sbox_layer_assignments(vectors, (i, pt), output_file)

        elif mode == "p_function":
            pt = random_hex(64)
            key = random_hex(64)
            print(f"Test {i + 1}: input={pt}")
            driver = parse_main(pt, key, num_inputs - i + 1, driver)
            vectors = parse_vectors_to_dict("des_test_vectors.txt")
            generate_p_function_assignments(vectors, (i, pt), output_file)

        elif mode == "e_function":
            pt = random_hex(64)
            key = random_hex(64)
            print(f"Test {i + 1}: input={pt}")
            driver = parse_main(pt, key, num_inputs - i + 1, driver)
            vectors = parse_vectors_to_dict("des_test_vectors.txt")
            generate_e_function_assignments(vectors, (i, pt), output_file)

    print(f"\nDone! Vectors written to {output_file}")


if __name__ == "__main__":
    main()
