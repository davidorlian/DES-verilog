module des_top_wrapper (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] data_bus,
    input  wire [1:0]  selector,
    input  wire        load,
    input  wire        start,
    input  wire        result_sel,
    output wire [31:0] result_out,
    output wire        ready
);

    // Internal key and data assembly
    reg [63:0] key_reg;
    reg [63:0] data_reg;

    // Registered inputs to DES
    reg [63:0] key_internal;
    reg [63:0] data_internal;

    // Registered output
    reg [63:0] result_reg;
    reg        ready_reg;

    // Internal signals
    wire [63:0] des_result;
    reg  [1:0]  count_delay;


    // Input loading logic
    always @(posedge clk) begin
        if (rst) begin
            key_reg  <= 64'b0;
            data_reg <= 64'b0;
        end else if (load) begin
            case (selector)
                2'b00: key_reg[31:0]   <= data_bus;     // key low
                2'b01: key_reg[63:32]  <= data_bus;     // key high
                2'b10: data_reg[31:0]  <= data_bus;     // data low
                2'b11: data_reg[63:32] <= data_bus;     // data high
            endcase
        end
    end

    // Control and output logic
    always @(posedge clk) begin
        if (rst) begin
            key_internal  <= 64'b0;
            data_internal <= 64'b0;
            result_reg    <= 64'b0;
            ready_reg     <= 1'b0;
            count_delay   <= 2'b0;
        end else begin
            if (start) begin
                key_internal  <= key_reg;
                data_internal <= data_reg;
                ready_reg     <= 1'b0;  // clear ready until result captured
                count_delay   <= 2'b01;
            end 

            if (count_delay > 2'b00 && count_delay < 2'b11) begin
                count_delay <= count_delay + 1'b1;
            end
            
            if (count_delay == 2'b11) begin
                result_reg  <= des_result;
                ready_reg   <= 1'b1;
                count_delay <= 2'b0;
            end
        end
    end

    assign result_out = (result_sel == 1'b0) ? result_reg[63:32] : result_reg[31:0];
    assign ready      = ready_reg;

    // Instantiate the core DES module
    des_top des_core (
        .clk(clk),
        .rst(rst),
        .data_in(data_internal),
        .key_in(key_internal),
        .data_out(des_result)
    );

endmodule
