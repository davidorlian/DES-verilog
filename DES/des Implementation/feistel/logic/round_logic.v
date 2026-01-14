module round_logic (
    input  wire [63:0] round_in,     // {L_in, R_in}
    input  wire [47:0] round_key,    // round key for this round
    output wire [63:0] round_out     // {L_out, R_out}
);

    wire [31:0] L_in, R_in, L_out, R_out;
    wire [31:0] f_out;

    assign L_in = round_in[63:32];
    assign R_in = round_in[31:0];

    // f-function
    f_function f_func_inst (
        .R_in(R_in),
        .round_key(round_key),
        .f_out(f_out)
    );

    assign L_out = R_in;
    assign R_out = L_in ^ f_out;

    assign round_out = {L_out, R_out};

endmodule
