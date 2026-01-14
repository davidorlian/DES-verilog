import random

# E-func permutation table from DES standard
E_func = [
    32,  1,  2,  3,  4,  5,
     4,  5,  6,  7,  8,  9,
     8,  9, 10, 11, 12, 13,
    12, 13, 14, 15, 16, 17,
    16, 17, 18, 19, 20, 21,
    20, 21, 22, 23, 24, 25,
    24, 25, 26, 27, 28, 29,
    28, 29, 30, 31, 32,  1
]

def generate_random_hex_data():
    return ''.join(random.choice('0123456789ABCDEF') for _ in range(8))

def hex_to_bin(hex_str):
    return bin(int(hex_str, 16))[2:].zfill(32)

def apply_E_func(data_32bit_hex):
    data_bin = hex_to_bin(data_32bit_hex)
    return ''.join(data_bin[i - 1] for i in E_func)

def generate_verilog_test_vectors_code(n=10):
    print("Generated Python code output for Verilog testbench:")
    for i in range(n):
        data = generate_random_hex_data()
        E_func_output = apply_E_func(data)
        print(f"        test_data[{i}]     = 32'h{data};")
        print(f"        expected_outs[{i}] = 48'b{E_func_output};\n")

# Run the generator
generate_verilog_test_vectors_code(10)
