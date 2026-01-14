`timescale 1ns / 1ps

module tb_p_function;
    reg  [31:0] in;
    wire [31:0] out;

    // Instantiate your perm function module
    p_function uut (
        .in(in),
        .out(out)
    );

    // Input test vectors (32-bit data)
    reg [31:0] test_data     [0:9];
    // Expected outputs after P-perm (32-bit values)
    reg [31:0] expected_outs [0:9];

    integer i;

    initial begin
        // Initialize test vectors
        test_data[0]     = 32'h5FE4612A;
        expected_outs[0] = 32'b01001000000011111111010110010110;

        test_data[1]     = 32'h40E8EA6D;
        expected_outs[1] = 32'b00011001001101011000110111100100;

        test_data[2]     = 32'hC008B585;
        expected_outs[2] = 32'b00100001100000001010100011101001;

        test_data[3]     = 32'hBD18299A;
        expected_outs[3] = 32'b00011110100010100110001011010011;

        test_data[4]     = 32'h01FCAE5F;
        expected_outs[4] = 32'b00011111001100110101100111101100;

        test_data[5]     = 32'h60ABB36B;
        expected_outs[5] = 32'b10101001011100101010111111000100;

        test_data[6]     = 32'hECD71AA3;
        expected_outs[6] = 32'b10110100111010111001111100010001;

        test_data[7]     = 32'hC36D352B;
        expected_outs[7] = 32'b11101000100000111111110011001100;

        test_data[8]     = 32'hFA62D14F;
        expected_outs[8] = 32'b01101001110111111010101000100110;

        test_data[9]     = 32'h89565092;
        expected_outs[9] = 32'b00100110110011110101000000000001;
        
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
