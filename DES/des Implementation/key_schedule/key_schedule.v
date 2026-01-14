module key_schedule (
    input  wire [63:0] key_in,

    output wire [47:0] round_key0,
    output wire [47:0] round_key1,
    output wire [47:0] round_key2,
    output wire [47:0] round_key3,
    output wire [47:0] round_key4,
    output wire [47:0] round_key5,
    output wire [47:0] round_key6,
    output wire [47:0] round_key7,
    output wire [47:0] round_key8,
    output wire [47:0] round_key9,
    output wire [47:0] round_key10,
    output wire [47:0] round_key11,
    output wire [47:0] round_key12,
    output wire [47:0] round_key13,
    output wire [47:0] round_key14,
    output wire [47:0] round_key15
);

    wire [55:0] pc1_out;
    wire [55:0] shifted_keys [0:15];
    wire [27:0] C [0:16];
    wire [27:0] D [0:16];
    wire [47:0] round_keys [0:15];

    // PC-1 permutation
    pc1 pc1_inst (
        .key_in(key_in),
        .key_out(pc1_out)
    );

    // Initial C and D values
    assign C[0] = pc1_out[55:28];
    assign D[0] = pc1_out[27:0];

    // Shift schedule hardcoded
    function [1:0] get_shift_amount;
        input [3:0] i;
        begin
            case (i)
                0, 1, 8, 15: get_shift_amount = 1;
                default:    get_shift_amount = 2;
            endcase
        end
    endfunction

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : round_loop
            wire [55:0] combined_in;
            assign combined_in = {C[i], D[i]};

            key_round_step step (
                .in_key(combined_in),
                .shift_amount(get_shift_amount(i)),
                .shifted_key(shifted_keys[i])
            );

            assign C[i+1] = shifted_keys[i][55:28];
            assign D[i+1] = shifted_keys[i][27:0];

            pc2 pc2_inst (
                .key_in(shifted_keys[i]),
                .key_out(round_keys[i])
            );
        end
    endgenerate

    assign round_key0  = round_keys[0];
    assign round_key1  = round_keys[1];
    assign round_key2  = round_keys[2];
    assign round_key3  = round_keys[3];
    assign round_key4  = round_keys[4];
    assign round_key5  = round_keys[5];
    assign round_key6  = round_keys[6];
    assign round_key7  = round_keys[7];
    assign round_key8  = round_keys[8];
    assign round_key9  = round_keys[9];
    assign round_key10 = round_keys[10];
    assign round_key11 = round_keys[11];
    assign round_key12 = round_keys[12];
    assign round_key13 = round_keys[13];
    assign round_key14 = round_keys[14];
    assign round_key15 = round_keys[15];

endmodule
