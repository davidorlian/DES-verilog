`timescale 1ns / 1ps

module tb_des_top_wrapper;

    reg clk;
    reg rst;
    reg [31:0] data_bus;
    reg [1:0]  selector;
    reg        load;
    reg        start;
    reg        result_sel;
    wire [31:0] result_out;
    wire        ready;

    des_top_wrapper uut (
        .clk(clk),
        .rst(rst),
        .data_bus(data_bus),
        .selector(selector),
        .load(load),
        .start(start),
        .result_sel(result_sel),
        .result_out(result_out),
        .ready(ready)
    );

    always #5 clk = ~clk;

    reg [63:0] key       = 64'h133457799bbcdff1;
    reg [63:0] plaintext = 64'h0123456789abcdef;
    reg [63:0] expected  = 64'h85e813540f0ab405;
    reg [63:0] got;

    // Monitor output value over time
    always @(uut.des_core.data_in) begin
        $display("[%0t] d data_in changed to : %h", $time, uut.des_core.data_in);
    end

    always @(uut.des_core.key_in) begin
        $display("[%0t] d key_in changed to : %h", $time, uut.des_core.key_in);
    end

    always @(uut.des_core.data_out) begin
        $display("[%0t] q data_out changed to : %h", $time, uut.des_core.data_out);
    end    

    always @(start) begin
        $display("[%0t] start changed to : %h", $time, start);
    end   

    always @(ready) begin
        $display("[%0t] ready changed to : %h", $time, ready);
    end   

    always @(load) begin
        $display("[%0t] load changed to : %h", $time, load);
    end   

    initial begin
        $display("---- DES Wrapper Test ----");
        clk = 0;
        rst = 1;
        load = 0;
        start = 0;
        result_sel = 0;
        data_bus = 0;

        #20; rst = 0;

        // Load key (low → high)
        @(posedge clk); data_bus = key[31:0];  selector = 2'b00; load = 1;
        @(posedge clk); data_bus = key[63:32]; selector = 2'b01;

        // Load data (low → high)
        @(posedge clk); data_bus = plaintext[31:0];  selector = 2'b10;
        @(posedge clk); data_bus = plaintext[63:32]; selector = 2'b11;

        @(posedge clk); load = 0; start = 1;

        // Trigger encryption
        @(posedge clk); start = 0;

        // Wait for result
        wait (ready == 1);

        @(posedge clk); result_sel = 0;
        @(posedge clk); got[63:32] = result_out;

        result_sel = 1;
        @(posedge clk); got[31:0] = result_out;

        // Display result
        $display("");
        $display("KEY       : %h", key);
        $display("PLAINTEXT : %h", plaintext);
        $display("EXPECTED  : %h", expected);
        $display("GOT       : %h", got);

        if (got === expected)
            $display("PASS");
        else
            $display("FAIL");

        $finish;
    end

endmodule
