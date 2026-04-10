module des_top (
    input  wire        clk,
    input  wire        rst,
    input  wire [63:0] data_in,
    input  wire [63:0] key_in,
    output wire [63:0] data_out
);

    // ============================
    // Wires for interconnections
    // ============================

    wire [63:0] data_reg_out;
    wire [63:0] key_reg_out;
    
    wire [47:0] round_key0;
    wire [47:0] round_key1;
    wire [47:0] round_key2;
    wire [47:0] round_key3;
    wire [47:0] round_key4;
    wire [47:0] round_key5;
    wire [47:0] round_key6;
    wire [47:0] round_key7;
    wire [47:0] round_key8;
    wire [47:0] round_key9;
    wire [47:0] round_key10;
    wire [47:0] round_key11;
    wire [47:0] round_key12;
    wire [47:0] round_key13;
    wire [47:0] round_key14;
    wire [47:0] round_key15;

    wire [63:0] feistel_out;

    // ============================
    // Input Registers
    // ============================

    // Data input register
    register64 data_input_reg (
        .clk(clk),
        .rst(rst),
        .d(data_in),
        .q(data_reg_out)
    );

    // Key input register
    register64 key_input_reg (
        .clk(clk),
        .rst(rst),
        .d(key_in),
        .q(key_reg_out)
    );

    // ============================
    // Key Schedule
    // ============================

key_schedule ks (
    .key_in(key_reg_out),
    .round_key0(round_key0),
    .round_key1(round_key1),
    .round_key2(round_key2),
    .round_key3(round_key3),
    .round_key4(round_key4),
    .round_key5(round_key5),
    .round_key6(round_key6),
    .round_key7(round_key7),
    .round_key8(round_key8),
    .round_key9(round_key9),
    .round_key10(round_key10),
    .round_key11(round_key11),
    .round_key12(round_key12),
    .round_key13(round_key13),
    .round_key14(round_key14),
    .round_key15(round_key15)
);

    // ============================
    // Feistel Block
    // ============================

    feistel fe (
        .data_in(data_reg_out),
        .round_key_0(round_key0),
        .round_key_1(round_key1),
        .round_key_2(round_key2),
        .round_key_3(round_key3),
        .round_key_4(round_key4),
        .round_key_5(round_key5),
        .round_key_6(round_key6),
        .round_key_7(round_key7),
        .round_key_8(round_key8),
        .round_key_9(round_key9),
        .round_key_10(round_key10),
        .round_key_11(round_key11),
        .round_key_12(round_key12),
        .round_key_13(round_key13),
        .round_key_14(round_key14),
        .round_key_15(round_key15),
        .data_out(feistel_out)
    );

    // ============================
    // Output Register
    // ============================

    register64 data_output_reg (
        .clk(clk),
        .rst(rst),
        .d(feistel_out),
        .q(data_out)
    );

endmodule