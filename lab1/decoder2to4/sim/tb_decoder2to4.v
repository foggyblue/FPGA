module tb_decoder2to4;

// Inputs
reg [1:0] in;
reg enable;

// Outputs
wire [3:0] out;

// Instantiate the Unit Under Test (UUT)
decoder2to4 uut (
    .in(in),
    .enable(enable),
    .out(out)
);

initial begin
    // Initialize Inputs
    in = 2'b00;
    enable = 1'b0;

    // Monitor changes
    $monitor("Time: %0d, Enable: %b, Input: %b, Output: %b", $time, enable, in, out);

    // Test sequence
    #10 enable = 1'b1; in = 2'b00;
    #10 in = 2'b01;
    #10 in = 2'b10;
    #10 in = 2'b11;
    #10 enable = 1'b0; in = 2'b00;
    #10 enable = 1'b1; in = 2'b00;
    #10 enable = 1'b0; in = 2'b11;
    #10 enable = 1'b1; in = 2'b10;

    // Finish simulation
    #10 $stop;
end

endmodule