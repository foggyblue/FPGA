`timescale 1ns / 1ps  // Time scale directive

module tb_running_light;

    // Inputs
    reg sys_clk;
    reg sys_rst_n;

    // Outputs
    wire [3:0] leds;

    // Instantiate the Unit Under Test (UUT)
    running_light uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .leds(leds)
    );

    // Clock generation for 50 MHz
    initial begin
        sys_clk = 0;  // Initialize clock
        forever #10 sys_clk = ~sys_clk;  // Toggle every 10 ns -> 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize reset
        sys_rst_n = 0;  // Assert reset (active-low)
        #100;           // Hold reset for 100 ns

        sys_rst_n = 1;  // De-assert reset
        #100000000;     // Run for 100 ms to observe multiple LED transitions

        // Assert reset again to check reset behavior
        sys_rst_n = 0;
        #50;
        sys_rst_n = 1;
        #50000000;      // Run for another 50 ms to observe LED behavior after reset

        $stop;          // Stop the simulation
    end

endmodule