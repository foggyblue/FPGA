module running_light(
    input wire sys_clk,       // 50 MHz system clock
    input wire sys_rst_n,     // active-low reset signal
    output reg [3:0] leds     // 4-bit output to control the LEDs (led3, led2, led1, led0)
);

    reg [24:0] cnt;           // 25-bit counter to count up to 25,000,000 cycles (0.5 seconds)
    reg [1:0] led_index;      // 2-bit register to keep track of the current LED
    
    parameter MAX_COUNT = 25000000;  // Number of clock cycles for 0.5 seconds at 50 MHz

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            // Reset: Turn on led0 (initial state) and reset counter
            cnt <= 0;
            led_index <= 0;
            leds <= 4'b1110;  // Only led0 is ON
        end else begin
            if (cnt == MAX_COUNT - 1) begin
                // After 0.5 seconds, move to the next LED
                cnt <= 0;  // Reset counter

                // Cycle through the LEDs
                led_index <= led_index + 1;

                case (led_index)
                    2'b00: leds <= 4'b1101;  // Turn on led1
                    2'b01: leds <= 4'b1011;  // Turn on led2
                    2'b10: leds <= 4'b0111;  // Turn on led3
                    2'b11: leds <= 4'b1110;  // Turn on led0 (wrap around)
                    default: leds <= 4'b1110;  // Default to led0
                endcase
            end else begin
                // Increment the counter every clock cycle
                cnt <= cnt + 1;
            end
        end
    end

endmodule