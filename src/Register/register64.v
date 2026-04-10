module register64 (
    input  wire        clk,
    input  wire        rst,
    input  wire [63:0] d,
    output reg  [63:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 64'b0;
        else
            q <= d;
    end

endmodule
