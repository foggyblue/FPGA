`timescale 1ns/1ns

module tb_comparator1bit;

// Inputs
reg a;
reg b;

// Outputs
wire a_lt_b;
wire a_gt_b;
wire a_eq_b;

// Instantiate the Unit Under Test (UUT)
comparator1bit uut (
    .a(a),
    .b(b),
    .a_lt_b(a_lt_b),
    .a_gt_b(a_gt_b),
    .a_eq_b(a_eq_b)
);

initial begin
    // Initialize Inputs
    a = 0;
    b = 0;

    // Monitor changes
    $monitor("Time: %0d, a: %b, b: %b, a_lt_b: %b, a_gt_b: %b, a_eq_b: %b", $time, a, b, a_lt_b, a_gt_b, a_eq_b);

    // Test cases
    #10 a = 0; b = 0;
    #10 a = 0; b = 1;
    #10 a = 1; b = 0;
    #10 a = 1; b = 1;

    // Finish simulation
    #10 $stop;
end

endmodule