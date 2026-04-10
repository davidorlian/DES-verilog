module key_round_step (
    input      [55:0] in_key,         // 56-bit input from PC1
    input      [1:0]  shift_amount,   // shift amount: 1 or 2
    output reg [55:0] shifted_key     // 56-bit output after shift
);

    reg [27:0] C_in, D_in;
    reg [27:0] C_shifted, D_shifted;

    always @(*) begin
        // Split the input into two 28-bit halves
        C_in = in_key[55:28];
        D_in = in_key[27:0];

        // Shift based on shift amount
        case (shift_amount)
            2'd1: begin
                C_shifted = {C_in[26:0], C_in[27]};
                D_shifted = {D_in[26:0], D_in[27]};
            end
            2'd2: begin
                C_shifted = {C_in[25:0], C_in[27:26]};
                D_shifted = {D_in[25:0], D_in[27:26]};
            end
            default: begin
                C_shifted = C_in;
                D_shifted = D_in;
            end
        endcase
        
        // Combine shifted halves into 56-bit output
        shifted_key = {C_shifted, D_shifted};
    end

endmodule
