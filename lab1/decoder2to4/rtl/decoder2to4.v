module decoder2to4 (
    input wire [1:0] in,    // 2-bit input
    input wire enable,      // Enable input
    output reg [3:0] out    // 4-bit output
);

always @(*) begin
    if (enable) begin
        case (in)
            2'b00: out = 4'b0001;
            2'b01: out = 4'b0010;
            2'b10: out = 4'b0100;
            2'b11: out = 4'b1000;
            default: out = 4'b0000; // Default case for safety
        endcase
    end else begin
        out = 4'b0000; // Output is zero when not enabled
    end
end

endmodule