`timescale 1ns / 1ps

module tb_round_logic;

    // Inputs
    reg [63:0] round_in;
    reg [47:0] round_key;

    // Output
    wire [63:0] round_out;

    // Instantiate the Unit Under Test (UUT)
    round_logic uut (
        .round_in(round_in),
        .round_key(round_key),
        .round_out(round_out)
    );

    // Test vectors
    reg [63:0] in_vec [0:9];
    reg [47:0] key_vec [0:9];
    reg [63:0] exp_vec [0:9];

    integer i;

    initial begin
        // Initialize test vectors
        in_vec[0] = 64'h57EB7A1E36E9AC50; key_vec[0] = 48'h0F614A0CFE6E; exp_vec[0] = 64'h36E9AC50E1D7B110;
        in_vec[1] = 64'h11B09F10F2BF8D40; key_vec[1] = 48'h4568EA1FA722; exp_vec[1] = 64'hF2BF8D4061E4B306;
        in_vec[2] = 64'hD97A00364C5D5F8A; key_vec[2] = 48'h1B26724DC372; exp_vec[2] = 64'h4C5D5F8ADF5F29A5;
        in_vec[3] = 64'h5745492D2752A149; key_vec[3] = 48'h4272CA56AC5B; exp_vec[3] = 64'h2752A14918F309EF;
        in_vec[4] = 64'h63A478F1D9D7D059; key_vec[4] = 48'h6EB98251B846; exp_vec[4] = 64'hD9D7D059E8ACE4A5;
        in_vec[5] = 64'hB7BF407968A4EAC9; key_vec[5] = 48'hFC62F8F3C2CD; exp_vec[5] = 64'h68A4EAC9422562B8;
        in_vec[6] = 64'h509195D71A2A8FCF; key_vec[6] = 48'h14ECC01F836A; exp_vec[6] = 64'h1A2A8FCF2946D05F;
        in_vec[7] = 64'hCE86862A58A5239A; key_vec[7] = 48'hA200445A2ED1; exp_vec[7] = 64'h58A5239AE17D025B;
        in_vec[8] = 64'h87802A7B4A47E99B; key_vec[8] = 48'h476AE9D25850; exp_vec[8] = 64'h4A47E99BD7BC216C;
        in_vec[9] = 64'hA475D8405EA77ECA; key_vec[9] = 48'hC489542E868F; exp_vec[9] = 64'h5EA77ECADCF6AA38;

        // Run tests
        for (i = 0; i < 10; i = i + 1) begin
            round_in = in_vec[i];
            round_key = key_vec[i];
            #10; // Wait for combinational logic to settle

            if (round_out === exp_vec[i]) begin
                $display("Test %2d PASS: round_in=%h round_key=%h round_out=%h",
                    i+1, round_in, round_key, round_out);
            end else begin
                $display("Test %2d FAIL: round_in=%h round_key=%h round_out=%h (expected %h)",
                    i+1, round_in, round_key, round_out, exp_vec[i]);
            end
        end

        $finish;
    end

endmodule
