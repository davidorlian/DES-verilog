`timescale 1ns / 1ps

module tb_ip_alt;

    reg  [63:0] data_in;
    wire [63:0] ip_out;
    wire [63:0] ip_inv_out;

    integer i;

    // Instantiate the IP and IP^-1 modules
    ip ip_inst (
        .data_in(data_in),
        .data_out(ip_out)
    );

    inv_ip inv_ip_inst (
        .data_in(ip_out),
        .data_out(ip_inv_out)
    );

    initial begin
        // Starting pattern
        data_in = 64'h0123456789abcdef;

        // Monitor the changes to input, IP output, and IP^-1 output
        $monitor("At time %0t | Rotation: %2d | Input: %016h | After IP: %016h | After IP^-1: %016h",
                 $time, i, data_in, ip_out, ip_inv_out);

        // Perform 16 rotations of 4 bits each
        for (i = 0; i < 16; i = i + 1) begin
            #1;

            // Circular left shift by 4 bits
            data_in = {data_in[59:0], data_in[63:60]};
        end
    end

endmodule