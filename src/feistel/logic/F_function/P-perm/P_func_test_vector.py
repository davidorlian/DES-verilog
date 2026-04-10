import random

# P-func permutation table from DES standard
P_func = [
    16,  7, 20, 21,
    29, 12, 28, 17,
     1, 15, 23, 26,
     5, 18, 31, 10,
     2,  8, 24, 14,
    32, 27,  3,  9,
    19, 13, 30,  6,
    22, 11,  4, 25
]

def generate_random_hex_data():
    return ''.join(random.choice('0123456789ABCDEF') for _ in range(8))

def hex_to_bin(hex_str):
    return bin(int(hex_str, 16))[2:].zfill(32)

def apply_P_func(data_32bit_hex):
    data_bin = hex_to_bin(data_32bit_hex)
    return ''.join(data_bin[i - 1] for i in P_func)

def generate_verilog_test_vectors_code(n=10):
    print("Generated Python code output for Verilog testbench:")
    for i in range(n):
        data = generate_random_hex_data()
        P_func_output = apply_P_func(data)
        print(f"        test_data[{i}]     = 8'h{data};")
        print(f"        expected_outs[{i}] = 32'b{P_func_output};\n")

# Run the generator
generate_verilog_test_vectors_code(10)
