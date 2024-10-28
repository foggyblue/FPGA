`timescale 1ns / 1ps

module tb_latch2;

    // Declare inputs as reg and output as wire
    reg in1;
    reg in2;
    reg in3;
    wire [7:0] out;
    
    // Instantiate the module under test (MUT)
    avoid_latch2 uut (
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .out(out)
    );
    
    // Procedure to apply test vectors
    initial begin
        // Initialize inputs
        in1 = 0; in2 = 0; in3 = 0;
        #10;   // Wait for 10 time units
        $display("Test 1: in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);
        
        in1 = 0; in2 = 0; in3 = 1;
        #10;
        $display("Test 2: in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);
        
        in1 = 0; in2 = 1; in3 = 0;
        #10;
        $display("Test 3: in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);
        
        in1 = 0; in2 = 1; in3 = 1;
        #10;
        $display("Test 4: in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);
        
        in1 = 1; in2 = 0; in3 = 0;
        #10;
        $display("Test 5: in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);
        
        in1 = 1; in2 = 0; in3 = 1;
        #10;
        $display("Test 6: in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);
        
        in1 = 1; in2 = 1; in3 = 0;
        #10;
        $display("Test 7: in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);
        
        in1 = 1; in2 = 1; in3 = 1;
        #10;
        $display("Test 8: in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);

        // Test default case
        in1 = 1'bx; in2 = 1'bx; in3 = 1'bx;
        #10;
        $display("Test 9 (default case): in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);

        // End the simulation
        $stop;
    end
    
endmodule