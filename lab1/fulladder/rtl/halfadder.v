`timescale 1ns/1ns
module halfadder
(
input wire in1,
input wire in2,

output wire cout,
output wire sum
);
assign  {cout, sum} = in1 + in2;
endmodule