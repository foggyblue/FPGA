module  counter
(
    input wire sys_clk,       // 50 MHz system clock
    input wire sys_rst_n,     // active-low reset signal
    output reg led_out        // output to control the LED
);

    reg [24:0] cnt;           // 25-bit counter (to count up to 25,000,000)
    parameter MAX_COUNT = 25000000;  // Number of cycles for 0.5 seconds at 50 MHz

    // Main process block
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            // Reset the counter and turn LED on
            cnt <= 0;
            led_out <= 1;    // LED starts in the ON state
        end else begin
            if (cnt == MAX_COUNT - 1) begin
                // Toggle the LED once every 0.5 seconds
                led_out <= ~led_out;
                cnt <= 0;    // Reset counter after reaching 0.5 seconds
            end else begin
                cnt <= cnt + 1;    // Increment the counter
            end
        end
    end
endmodule