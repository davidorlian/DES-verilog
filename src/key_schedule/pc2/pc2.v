
module pc2 (
    input  [55:0] key_in,
    output [47:0] key_out
);
    assign key_out = {
        key_in[56 - 14], key_in[56 - 17], key_in[56 - 11], key_in[56 - 24], key_in[56 - 1],  key_in[56 - 5],
        key_in[56 - 3],  key_in[56 - 28], key_in[56 - 15], key_in[56 - 6],  key_in[56 - 21], key_in[56 - 10],
        key_in[56 - 23], key_in[56 - 19], key_in[56 - 12], key_in[56 - 4],  key_in[56 - 26], key_in[56 - 8],
        key_in[56 - 16], key_in[56 - 7],  key_in[56 - 27], key_in[56 - 20], key_in[56 - 13], key_in[56 - 2],
        key_in[56 - 41], key_in[56 - 52], key_in[56 - 31], key_in[56 - 37], key_in[56 - 47], key_in[56 - 55],
        key_in[56 - 30], key_in[56 - 40], key_in[56 - 51], key_in[56 - 45], key_in[56 - 33], key_in[56 - 48],
        key_in[56 - 44], key_in[56 - 49], key_in[56 - 39], key_in[56 - 56], key_in[56 - 34], key_in[56 - 53],
        key_in[56 - 46], key_in[56 - 42], key_in[56 - 50], key_in[56 - 36], key_in[56 - 29], key_in[56 - 32]
    };
endmodule
