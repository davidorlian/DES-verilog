module feistel (
    input  wire [63:0] data_in,
    input  wire [47:0] round_key_0,
    input  wire [47:0] round_key_1,
    input  wire [47:0] round_key_2,
    input  wire [47:0] round_key_3,
    input  wire [47:0] round_key_4,
    input  wire [47:0] round_key_5,
    input  wire [47:0] round_key_6,
    input  wire [47:0] round_key_7,
    input  wire [47:0] round_key_8,
    input  wire [47:0] round_key_9,
    input  wire [47:0] round_key_10,
    input  wire [47:0] round_key_11,
    input  wire [47:0] round_key_12,
    input  wire [47:0] round_key_13,
    input  wire [47:0] round_key_14,
    input  wire [47:0] round_key_15,
    output wire [63:0] data_out
);

    wire [63:0] ip_out;
    wire [63:0] round_data [0:16];
    wire [63:0] inv_ip_out;
    wire [47:0] round_keys [0:15];

    // Wrap the round keys into array
    assign round_keys[0]  = round_key_0;
    assign round_keys[1]  = round_key_1;
    assign round_keys[2]  = round_key_2;
    assign round_keys[3]  = round_key_3;
    assign round_keys[4]  = round_key_4;
    assign round_keys[5]  = round_key_5;
    assign round_keys[6]  = round_key_6;
    assign round_keys[7]  = round_key_7;
    assign round_keys[8]  = round_key_8;
    assign round_keys[9]  = round_key_9;
    assign round_keys[10] = round_key_10;
    assign round_keys[11] = round_key_11;
    assign round_keys[12] = round_key_12;
    assign round_keys[13] = round_key_13;
    assign round_keys[14] = round_key_14;
    assign round_keys[15] = round_key_15;

    // Initial Permutation (IP)
    IP ip_inst (
        .data_in(data_in),
        .data_out(ip_out)
    );

    // Initial input to rounds
    assign round_data[0] = ip_out;

    // 16 rounds
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : feistel_rounds
            round_logic round (
                .round_in(round_data[i]),
                .round_key(round_keys[i]),
                .round_out(round_data[i+1])
            );
        end
    endgenerate

    // Inverse IP
    inv_IP inv_ip_inst (
        .data_in({round_data[16][31:0], round_data[16][63:32]}),
        .data_out(inv_ip_out)
    );

    assign data_out = inv_ip_out;

endmodule
