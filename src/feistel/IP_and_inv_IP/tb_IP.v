module tb_IP;

    // Testbench signals
    reg [63:0] data_in;
    wire [63:0] data_out;
    
    // Instantiate the IP module
    IP dut (
        .data_in(data_in),
        .data_out(data_out)
    );

    reg [63:0] in_vec [0:5];
    reg [63:0] exp_vec [0:5];

    integer i;
    
    // Test stimulus
    initial begin
        // Initialize test vectors
        in_vec[0] = 64'hB64A2D7E79E99C93; exp_vec[0] = 64'h3AD94DB4E13D7E8B;
        in_vec[1] = 64'h9D9DE5CA0C312260; exp_vec[1] = 64'h8C2317270FE41B48;
        in_vec[2] = 64'h4EDC01816A540E9A; exp_vec[2] = 64'h33A2630C8A10D3D1;
        in_vec[3] = 64'h246421BD6D100D39; exp_vec[3] = 64'h12A85BDC089FD800;
        in_vec[4] = 64'h030982C4A1B0D022; exp_vec[4] = 64'h486008137CB00285;
        in_vec[5] = 64'h0FBFD75D11964ED6; exp_vec[5] = 64'hCCBEEF1FA6024BE7;

        // Run tests
        for (i = 0; i < 6; i = i + 1) begin
            data_in = in_vec[i];
            #10; // Wait for combinational logic to settle

            if (data_out === exp_vec[i]) begin
                $display("Test %2d PASS: data_in=%h data_out=%h",
                    i+1, data_in, data_out);
            end else begin
                $display("Test %2d FAIL: data_in=%h data_out=%h (expected %h)",
                    i+1, data_in, data_out, exp_vec[i]);
            end
        end

        $finish;
    end


endmodule