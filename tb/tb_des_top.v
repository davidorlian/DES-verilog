`timescale 1ns / 1ps

module tb_des_top;

    // Inputs
    reg clk;
    reg rst;
    reg [63:0] data_in;
    reg [63:0] key_in;

    // Output
    wire [63:0] data_out;

    // Instantiate DUT
    des_top uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .key_in(key_in),
        .data_out(data_out)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test vectors
    reg [63:0] data_vec [0:9];
    reg [63:0] key_vec  [0:9];
    reg [63:0] expected [0:9];
    integer i;

    initial begin
        // Initialize test vectors
        data_vec[0] = 64'h0123456789ABCDEF; key_vec[0] = 64'h133457799BBCDFF1; expected[0] = 64'h85e813540f0ab405;
        data_vec[1] = 64'hFEDCBA9876543210; key_vec[1] = 64'h0F1571C947D9E859; expected[1] = 64'h76660e2d7926aa92;
        data_vec[2] = 64'h0123456789ABCDEF; key_vec[2] = 64'h0123456789ABCDEF; expected[2] = 64'h56cc09e7cfdc4cef;
        data_vec[3] = 64'h1111111111111111; key_vec[3] = 64'h2222222222222222; expected[3] = 64'h08024fcf811da672;
        data_vec[4] = 64'h3333333333333333; key_vec[4] = 64'h4444444444444444; expected[4] = 64'h1c8dc4fb9460cb0a;
        data_vec[5] = 64'h5555555555555555; key_vec[5] = 64'h6666666666666666; expected[5] = 64'hcf4a51bfa9bc67fc;
        data_vec[6] = 64'h7777777777777777; key_vec[6] = 64'h8888888888888888; expected[6] = 64'h6967f244302c7692;
        data_vec[7] = 64'h9999999999999999; key_vec[7] = 64'hAAAAAAAAAAAAAAAA; expected[7] = 64'h5f7bc0f4e1b50174;
        data_vec[8] = 64'hBBBBBBBBBBBBBBBB; key_vec[8] = 64'hCCCCCCCCCCCCCCCC; expected[8] = 64'h3b03ec4ad82d4b67;
        data_vec[9] = 64'hDDDDDDDDDDDDDDDD; key_vec[9] = 64'hEEEEEEEEEEEEEEEE; expected[9] = 64'h6af68ce7dce807f4;

        // Apply reset
        rst = 1;
        data_in = 64'b0;
        key_in = 64'b0;
        #12;

        rst = 0;

        // Loop through vectors
        for (i = 0; i < 10; i = i + 1) begin
            data_in = data_vec[i];
            key_in = key_vec[i];
            #20; // wait for registers to load and outputs to propagate

            // Display current vector result
            $display("Test %2d | data_in=%h | key_in=%h | data_out=%h | expected=%h",
                     i+1, data_in, key_in, data_out, expected[i]);

            // Compare with expected
            if (data_out === expected[i])
                $display("Test %2d PASS", i+1);
            else
                $display("Test %2d FAIL: output does not match expected.", i+1);
        end

        // Finish simulation
        $finish;
    end

endmodule
