`timescale 1ns / 1ps

module tb_pc1;
    reg  [63:0] key_in;
    wire [55:0] key_out;

    // Instantiate your PC1 module
    pc1 uut (
        .key_in(key_in),
        .key_out(key_out)
    );

    // Input test vectors (64-bit keys)
    reg [63:0] test_keys     [0:9];
    // Expected outputs after PC1 (56-bit values)
    reg [55:0] expected_outs [0:9];

    integer i;

    initial begin
        // Initialize test vectors
        test_keys[0]     = 64'h74ABBDA83B018E2B;
        expected_outs[0] = 56'b01001110000000011001111100011101001001000101110111100101;

        test_keys[1]     = 64'h6A4752E3AC25FCB5;
        expected_outs[1] = 56'b11011000010011111111100111000000111111110010010100010100;

        test_keys[2]     = 64'hAB2EF71C84748773;
        expected_outs[2] = 56'b01010101101001001010011110101100011101111110000010111100;

        test_keys[3]     = 64'h16D7B0CC36C3BEA0;
        expected_outs[3] = 56'b11101110001010101101010001010111001101011011010010000111;

        test_keys[4]     = 64'h82862D62299CAD67;
        expected_outs[4] = 56'b01100011100010001101110000101000101111100110011101000000;

        test_keys[5]     = 64'h6A89690A41159497;
        expected_outs[5] = 56'b11000010000101010000010111101000100111100000000011110000;

        test_keys[6]     = 64'h0DA6DFA92F77CE6C;
        expected_outs[6] = 56'b01001110111001001011101000100111011011110111110111010100;

        test_keys[7]     = 64'h298B527B1F1AEFAE;
        expected_outs[7] = 56'b11000010010011001100100100111111111011010000111110111100;

        test_keys[8]     = 64'h6143F94408524BB5;
        expected_outs[8] = 56'b10000100011011111000010110100110001010001000010101000100;

        test_keys[9]     = 64'hBEF16413B2766A8F;
        expected_outs[9] = 56'b10010011011001100111011100111111100110100101110000011011;
        
        // Apply test vectors
        for (i = 0; i < 10; i = i + 1) begin
            key_in = test_keys[i];
            #1;  // allow for propagation

            if (key_out === expected_outs[i]) begin
                $display("Test %02d Passed", i+1);
            end else begin
                $display("Test %02d Failed", i+1);
                $display("  Input     : %h", key_in);
                $display("  Expected  : %056b", expected_outs[i]);
                $display("  Got       : %056b", key_out);
            end
        end

        $display("All tests done.");
        $finish;
    end
endmodule
