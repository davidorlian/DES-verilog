`timescale 1ns / 1ps

module tb_e_function;
    reg  [31:0] in;
    wire [47:0] out;

    // Instantiate your perm function module
    e_function uut (
        .in(in),
        .out(out)
    );

    // Input test vectors (32-bit data)
    reg [31:0] test_data     [0:9];
    // Expected outputs after E-perm (48-bit values)
    reg [47:0] expected_outs [0:9];

    integer i;

    initial begin
        // Initialize test vectors
        test_data[0]     = 32'hAA147474;
        expected_outs[0] = 48'b010101010100000010101000001110101000001110101001;

        test_data[1]     = 32'h189EE4C9;
        expected_outs[1] = 48'b100011110001010011111101011100001001011001010010;

        test_data[2]     = 32'h6C60BCD3;
        expected_outs[2] = 48'b101101011000001100000001010111111001011010100110;

        test_data[3]     = 32'hD5456D43;
        expected_outs[3] = 48'b111010101010101000001010101101011010101000000111;

        test_data[4]     = 32'h0F1EAD1D;
        expected_outs[4] = 48'b100001011110100011111101010101011010100011111010;

        test_data[5]     = 32'h8A79C990;
        expected_outs[5] = 48'b010001010100001111110011111001010011110010100001;

        test_data[6]     = 32'hA7039F2A;
        expected_outs[6] = 48'b010100001110100000000111110011111110100101010101;

        test_data[7]     = 32'hE9DCDE70;
        expected_outs[7] = 48'b011101010011111011111001011011111100001110100001;

        test_data[8]     = 32'h5EB7498D;
        expected_outs[8] = 48'b101011111101010110101110101001010011110001011010;

        test_data[9]     = 32'hDF49FC52;
        expected_outs[9] = 48'b011011111110101001010011111111111000001010100101;
        
        // Apply test vectors
        for (i = 0; i < 10; i = i + 1) begin
            in = test_data[i];
            #1;  // allow for propagation

            if (out === expected_outs[i]) begin
                $display("Test %02d Passed", i+1);
            end else begin
                $display("Test %02d Failed", i+1);
                $display("  Input     : %h", in);
                $display("  Expected  : %032b", expected_outs[i]);
                $display("  Got       : %032b", out);
            end
        end

        $display("All tests done.");
        $finish;
    end
endmodule
