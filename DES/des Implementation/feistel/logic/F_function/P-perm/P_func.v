module p_function (
    input  wire [31:0] in,
    output wire [31:0] out
);

    assign out = {
        in[32 - 16], in[32 - 7],  in[32 - 20], in[32 - 21],
        in[32 - 29], in[32 - 12], in[32 - 28], in[32 - 17],
        in[32 - 1],  in[32 - 15], in[32 - 23], in[32 - 26],
        in[32 - 5],  in[32 - 18], in[32 - 31], in[32 - 10],
        in[32 - 2],  in[32 - 8],  in[32 - 24], in[32 - 14],
        in[32 - 32], in[32 - 27], in[32 - 3],  in[32 - 9],
        in[32 - 19], in[32 - 13], in[32 - 30], in[32 - 6],
        in[32 - 22], in[32 - 11], in[32 - 4],  in[32 - 25]
    };

endmodule
