module f_function (
    input  wire [31:0] R_in,
    input  wire [47:0] round_key,
    output wire [31:0] f_out
);

    wire [47:0] expanded;
    wire [47:0] xored;
    wire [31:0] sbox_out;

    // Step 1: Expansion
    e_function e_exp (
        .in(R_in),
        .out(expanded)
    );

    // Step 2: XOR with round key
    assign xored = expanded ^ round_key;

    // Step 3: S-Box layer
    sbox_layer s_layer (
        .in(xored),
        .out(sbox_out)
    );

    // Step 4: P-function (Permutation)
    p_function p_perm (
        .in(sbox_out),
        .out(f_out)
    );

endmodule
