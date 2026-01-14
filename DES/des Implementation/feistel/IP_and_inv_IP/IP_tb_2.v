`timescale 1ns / 1ps

module IP_tb_2;

    reg  [63:0] data_in;
    wire [63:0] ip_out;
    wire [63:0] ip_inv_out;

    integer i;

    // Instantiate the IP and IP⁻¹ modules
    IP ip (
        .data_in(data_in),
        .data_out(ip_out)
    );

    inv_IP ip_inv (
        .data_in(ip_out),
        .data_out(ip_inv_out)
    );

    initial begin
        // Starting pattern
        data_in = 64'h0123456789abcdef;

        // Monitor the changes to input, IP output, and IP^-1 output
        $monitor("At time %0t | Rotation: %2d |  Input: %016h | After IP: %016h | After IP^-1: %016h", 
                 $time, i, data_in, ip_out, ip_inv_out);

        // Perform 64 rotations
        for (i = 0; i < 16; i = i + 1) begin
            #1; // Small delay for better simulation viewing

            // Circular left shift by 4 bits
            data_in = {data_in[59:0], data_in[63:60]};
        end

    end

endmodule
