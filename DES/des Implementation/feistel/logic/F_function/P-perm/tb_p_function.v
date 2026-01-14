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
        test_data[0] = 32'h98C36FAF; expected_outs[0] = 32'h98EF2DAB;
        test_data[1] = 32'h94BE923C; expected_outs[1] = 32'h2FE01576;
        test_data[2] = 32'h727AFC43; expected_outs[2] = 32'h75578ACE;
        test_data[3] = 32'hFCEE687E; expected_outs[3] = 32'h1ADF97F6;
        test_data[4] = 32'h43886112; expected_outs[4] = 32'h4206E1C0;
        test_data[5] = 32'hC842AFFB; expected_outs[5] = 32'h1BFBAC89;
        test_data[6] = 32'h2EEBCA4B; expected_outs[6] = 32'hD97F0B54;
        test_data[7] = 32'h4AB8918A; expected_outs[7] = 32'h6D0AA145;
        test_data[8] = 32'h40A273C6; expected_outs[8] = 32'h2076A1A5;
        test_data[9] = 32'h7CE5B191; expected_outs[9] = 32'hA309BB97;

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
