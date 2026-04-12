`timescale 1ns / 1ps

module tb_register64;

    // Inputs
    reg clk;
    reg rst;
    reg [63:0] d;

    // Output
    wire [63:0] q;

    // Instantiate the Unit Under Test (UUT)
    register64 uut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );

    // Clock generation: 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize
        rst = 1;
        d = 64'h0;
        #12; // Wait during reset

        // Release reset
        rst = 0;
        d = 64'hDEADBEEFDEADBEEF;
        #10; // Wait 1 clock cycle

        // Apply new value
        d = 64'h0123456789ABCDEF;
        #10; // Wait 1 clock cycle

        // Apply another value
        d = 64'hFFFFFFFFFFFFFFFF;
        #10; // Wait 1 clock cycle

        // Assert reset again
        rst = 1;
        #10;

        // Release reset and check loading after reset
        rst = 0;
        d = 64'hAAAAAAAAAAAAAAAA;
        #10;

        // Finish simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%0t | rst=%b | d=%h | q=%h", $time, rst, d, q);
    end

endmodule
