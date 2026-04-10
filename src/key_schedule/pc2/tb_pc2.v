
module tb_pc2;
    reg  [55:0] test_keys     [0:9];
    reg  [47:0] expected_outs [0:9];
    reg  [55:0] key_in;
    wire [47:0] key_out;
    integer i;

    pc2 uut (
        .key_in(key_in),
        .key_out(key_out)
    );

    initial begin
        test_keys[0]     = 56'h575720F4B243E3;
        expected_outs[0] = 48'b100000011101011111111001000011101011011100011100;

        test_keys[1]     = 56'hA0BDE91AC2AFBF;
        expected_outs[1] = 48'b111110110010011000100010111011001111011111100010;

        test_keys[2]     = 56'h10553D84EE6E39;
        expected_outs[2] = 48'b100100000011011100100100010110101110001111110000;

        test_keys[3]     = 56'h6B2DFC41E61E46;
        expected_outs[3] = 48'b111001100010010011110111000011000110101010101001;

        test_keys[4]     = 56'hA2E8D2FCB2BB5D;
        expected_outs[4] = 48'b011010110001100010011110110010100111101101001110;

        test_keys[5]     = 56'h13CF6A1EED719A;
        expected_outs[5] = 48'b100000011011110101110010011101110011110011010010;

        test_keys[6]     = 56'h52518680666F2D;
        expected_outs[6] = 48'b010000000001101100110001000010001101001111110000;

        test_keys[7]     = 56'hA5FB43BFED08CF;
        expected_outs[7] = 48'b001110111101101001101010001101110110010111001011;

        test_keys[8]     = 56'h50E60BF671C8B6;
        expected_outs[8] = 48'b101100011011100110001001111001111100010010010100;

        test_keys[9]     = 56'hAE65451327DE60;
        expected_outs[9] = 48'b101111110101000000110000101010011100101000111001;


        // Apply test vectors
        for (i = 0; i < 10; i = i + 1) begin
            key_in = test_keys[i];
            #1;  // allow for propagation

            if (key_out === expected_outs[i]) begin
                $display("Test %02d Passed", i+1);
            end else begin
                $display("Test %02d Failed", i+1);
                $display("  Input     : %h", key_in);
                $display("  Expected  : %048b", expected_outs[i]);
                $display("  Got       : %048b", key_out);
            end
        end

        $display("All tests done.");
        $finish;
    end
endmodule
