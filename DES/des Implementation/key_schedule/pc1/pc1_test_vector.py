import random

# PC1 permutation table from DES standard
PC1 = [
    57, 49, 41, 33, 25, 17, 9,
    1,  58, 50, 42, 34, 26, 18,
    10, 2,  59, 51, 43, 35, 27,
    19, 11, 3,  60, 52, 44, 36,
    63, 55, 47, 39, 31, 23, 15,
    7,  62, 54, 46, 38, 30, 22,
    14, 6,  61, 53, 45, 37, 29,
    21, 13, 5,  28, 20, 12, 4
]

def generate_random_hex_key():
    return ''.join(random.choice('0123456789ABCDEF') for _ in range(16))

def hex_to_bin(hex_str):
    return bin(int(hex_str, 16))[2:].zfill(64)

def apply_pc1(key_64bit_hex):
    key_bin = hex_to_bin(key_64bit_hex)
    return ''.join(key_bin[i - 1] for i in PC1)

def generate_verilog_test_vectors_code(n=10):
    print("Generated Python code output for Verilog testbench:")
    for i in range(n):
        key = generate_random_hex_key()
        pc1_output = apply_pc1(key)
        print(f"        test_keys[{i}]     = 64'h{key};")
        print(f"        expected_outs[{i}] = 56'b{pc1_output};\n")

# Run the generator
generate_verilog_test_vectors_code(10)
