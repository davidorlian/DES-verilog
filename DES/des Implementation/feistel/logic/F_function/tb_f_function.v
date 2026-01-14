`timescale 1ns / 1ps

module tb_f_function;

    reg  [31:0] R_in;
    reg  [47:0] round_key;
    wire [31:0] f_out;

    // Instantiate the f_function module
    f_function uut (
        .R_in(R_in),
        .round_key(round_key),
        .f_out(f_out)
    );

    // Test vectors
    reg [31:0] R_vec [0:9];
    reg [47:0] K_vec [0:9];
    reg [31:0] expected_out [0:9];

    integer i;

    initial begin
        // Initialize test vectors
        R_vec[0] = 32'hDFB5FE6D; K_vec[0] = 48'h41930546E942; expected_out[0] = 32'hD198714F;
        R_vec[1] = 32'hCBC83781; K_vec[1] = 48'h42B97B7BD049; expected_out[1] = 32'hFB06A82D;
        R_vec[2] = 32'hE11D7D69; K_vec[2] = 48'hB3C5EA2D1302; expected_out[2] = 32'hE818663E;
        R_vec[3] = 32'h36796115; K_vec[3] = 48'h1FA810982547; expected_out[3] = 32'h1FD9D69F;
        R_vec[4] = 32'hB49A86FC; K_vec[4] = 48'h6DDDF3B690D2; expected_out[4] = 32'hB8FFA41A;
        R_vec[5] = 32'hAAEAFCE9; K_vec[5] = 48'h1B1064F3B537; expected_out[5] = 32'hC1906276;
        R_vec[6] = 32'hD0C3593F; K_vec[6] = 48'h8B22B573F739; expected_out[6] = 32'h3501B522;
        R_vec[7] = 32'hE4671F1F; K_vec[7] = 48'h3AB4EF1A434E; expected_out[7] = 32'h8DFEAC29;
        R_vec[8] = 32'h89D0194D; K_vec[8] = 48'h53C38C158831; expected_out[8] = 32'hF8D01024;
        R_vec[9] = 32'h9ED0095F; K_vec[9] = 48'h5B5D33FEE25A; expected_out[9] = 32'hD9F630B0;

        // Run tests
        for (i = 0; i < 10; i = i + 1) begin
            R_in = R_vec[i];
            round_key = K_vec[i];
            #10; // wait for combinational logic to settle

            if (f_out === expected_out[i]) begin
                $display("Test %2d PASS: R=%h K=%h -> f_out=%h",
                    i+1, R_in, round_key, f_out);
            end else begin
                $display("Test %2d FAIL: R=%h K=%h -> f_out=%h (expected %h)",
                    i+1, R_in, round_key, f_out, expected_out[i]);
            end
        end

        $finish;
    end

endmodule
 