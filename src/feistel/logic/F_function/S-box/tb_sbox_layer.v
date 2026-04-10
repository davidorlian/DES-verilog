`timescale 1ns/1ps

module tb_sbox_layer;

    reg  [47:0] in;
    wire [31:0] out;

    // Instantiate the module under test
    sbox_layer uut (
        .in(in),
        .out(out)
    );

    // Test vector and expected result
    reg [31:0] expected;

    initial begin
        $display("---- Testing sbox_layer ----");

        // Example test vector (input of 48 bits)
        in = 48'h1B02EFFC7072;
        expected = 32'hEFA72B36;  // Example expected output (you can update this)

        #1;
        if (out === expected) begin
            $display("Test 1 Passed: Output = %h", out);
        end else begin
            $display("Test 1 Failed");
            $display("Expected: %h", expected);
            $display("Got     : %h", out);
        end

        $finish;
    end

endmodule
