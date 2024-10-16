`timescale 1ns/1ns

module comparator1bit (
    input wire a,
    input wire b,
    output reg a_lt_b,
    output reg a_gt_b,
    output reg a_eq_b
);

always @(*) begin
    // Default all outputs to zero
    a_lt_b = 1;
    a_gt_b = 1;
    a_eq_b = 1;

    // Set only the appropriate output high
    if (a < b)
        a_lt_b = 0;
    else if (a > b)
        a_gt_b = 0;
    else
        a_eq_b = 0;
end

endmodule