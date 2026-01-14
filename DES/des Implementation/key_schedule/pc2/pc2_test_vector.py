
import random

# PC-2 permutation table from DES standard
PC2 = [
    14, 17, 11, 24, 1,  5,
    3,  28, 15, 6,  21, 10,
    23, 19, 12, 4,  26, 8,
    16, 7,  27, 20, 13, 2,
    41, 52, 31, 37, 47, 55,
    30, 40, 51, 45, 33, 48,
    44, 49, 39, 56, 34, 53,
    46, 42, 50, 36, 29, 32
]

def generate_random_56bit_hex():
    return ''.join(random.choice('0123456789ABCDEF') for _ in range(14))

def hex_to_bin56(hex_str):
    return bin(int(hex_str, 16))[2:].zfill(56)

def apply_pc2(input_56bit_hex):
    bin_key = hex_to_bin56(input_56bit_hex)
    return ''.join(bin_key[i - 1] for i in PC2)

def generate_verilog_pc2_test_vectors_code(n=10):
    print("Generated Python code output for Verilog testbench:")
    for i in range(n):
        key = generate_random_56bit_hex()
        pc2_output = apply_pc2(key)
        print(f"        test_keys[{i}]     = 56'h{key};")
        print(f"        expected_outs[{i}] = 48'b{pc2_output};\n")

generate_verilog_pc2_test_vectors_code(10)
