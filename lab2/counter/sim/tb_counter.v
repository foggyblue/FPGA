`timescale 1ns / 1ps  // Time scale directive

module tb_counter;

    // Inputs
    reg sys_clk;
    reg sys_rst_n;

    // Outputs
    wire led_out;

    // Instantiate the Unit Under Test (UUT)
    counter uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .led_out(led_out)
    );

    // Clock generation for 50 MHz
    initial begin
        sys_clk = 0;
        forever #10 sys_clk = ~sys_clk;  // Toggle clock every 10 ns -> 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        sys_rst_n = 0;  // Assert reset (active-low)
        #100;           // Wait for 100 ns

        sys_rst_n = 1;  // De-assert reset
        #100000000;     // Run for 100 ms to observe multiple LED toggles

        // Assert reset again to check reset behavior
        sys_rst_n = 0;
        #50;
        sys_rst_n = 1;
        #50000000;      // Run for another 50 ms to observe the LED behavior after reset

        $stop;          // Stop the simulation
    end

endmodule