`timescale 1ns / 1ps  // Time scale directive

module tb_flip_flop;

    // Inputs
    reg sys_clk;
    reg sys_rst;
    reg key_in;

    // Outputs
    wire led_out;

    // Instantiate the Unit Under Test (UUT)
    flip_flop uut (
        .sys_clk(sys_clk),
        .sys_rst(sys_rst),
        .key_in(key_in),
        .led_out(led_out)
    );

    // Clock generation: 50 MHz clock (20 ns period)
    initial begin
        sys_clk = 0;
        forever #10 sys_clk = ~sys_clk;  // Toggle clock every 10 ns -> 50 MHz clock
    end

    // Test sequence
    initial begin
        // Apply reset
        sys_rst = 1'b0;  // Assert reset (active-low)
        key_in = 1'b0;   // Initialize key_in
        #100;            // Wait for 100 ns
        
        sys_rst = 1'b1;  // De-assert reset
        #50;             // Wait for 50 ns
        
        // Apply some key_in values
        key_in = 1'b1;   // Set key_in high
        #50;             // Wait for 50 ns
        
        key_in = 1'b0;   // Set key_in low
        #50;             // Wait for 50 ns
        
        key_in = 1'b1;   // Set key_in high
        #50;             // Wait for 50 ns
        
        // Assert reset again to check reset functionality
        sys_rst = 1'b0;  // Assert reset
        #50;             // Wait for 50 ns
        
        sys_rst = 1'b1;  // De-assert reset
        key_in = 1'b0;   // Set key_in low
        #50;             // Wait for 50 ns

        $stop;           // Stop the simulation
    end

endmodule