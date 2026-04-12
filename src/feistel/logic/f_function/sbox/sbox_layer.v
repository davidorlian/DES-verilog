module sbox_layer (
    input  wire [47:0] in,
    output wire [31:0] out
);

    wire [3:0] s1_out, s2_out, s3_out, s4_out, s5_out, s6_out, s7_out, s8_out;

    sbox1 s1 (.in(in[47:42]), .out(s1_out));
    sbox2 s2 (.in(in[41:36]), .out(s2_out));
    sbox3 s3 (.in(in[35:30]), .out(s3_out));
    sbox4 s4 (.in(in[29:24]), .out(s4_out));
    sbox5 s5 (.in(in[23:18]), .out(s5_out));
    sbox6 s6 (.in(in[17:12]), .out(s6_out));
    sbox7 s7 (.in(in[11:6]),  .out(s7_out));
    sbox8 s8 (.in(in[5:0]),   .out(s8_out));

    assign out = {s1_out, s2_out, s3_out, s4_out, s5_out, s6_out, s7_out, s8_out};

endmodule
