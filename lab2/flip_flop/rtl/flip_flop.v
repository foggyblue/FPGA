module flip_flop
(
input wire sys_clk,
input wire sys_rst,
input wire key_in,
output reg led_out
);

always@(posedge sys_clk)
if(sys_rst==1'b0)
led_out<=1'b0;
else
led_out<=key_in;

endmodule