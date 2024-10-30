`timescale 1ns/1ps

module simple_fsm_tb;

    // Inputs to the FSM
    reg sys_clk;
    reg sys_rst_n;
    reg coin;

    // Output from the FSM
    wire cola;

    // Instantiate the FSM
    simple_fsm uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .coin(coin),
        .cola(cola)
    );

    // Clock generation
    always #5 sys_clk = ~sys_clk;  // Clock period = 10ns (100MHz)

    initial begin
        // Initialize inputs
        sys_clk = 0;
        sys_rst_n = 0;
        coin = 0;

        // Apply reset (reset is active low, so we assert it by setting it to 0)
        $display("Applying reset...");
        #10 sys_rst_n = 1;  // Deassert reset after 10 time units (FSM starts operating)
        $display("Reset deasserted, FSM should be in IDLE state.");

        // Insert the first coin (FSM should transition to ONE state)
        #10;
        $display("Inserting first coin...");
        coin = 1;
        #10;
        coin = 0;  // Remove the coin signal
        $display("FSM should now be in ONE state.");

        // Insert the second coin (FSM should transition to TWO state, and cola should be dispensed)
        #20;
        $display("Inserting second coin...");
        coin = 1;
        #10;
        coin = 0;  // Remove the coin signal
        $display("FSM should now be in TWO state, and cola should be dispensed.");

        // Wait to see if cola is dispensed
        #20;
        if (cola == 1'b1)
            $display("Cola dispensed correctly.");
        else
            $display("Error: Cola not dispensed.");

        // Insert another coin after cola is dispensed (FSM should return to IDLE state)
        #10;
        $display("Inserting another coin to reset FSM...");
        coin = 1;
        #10;
        coin = 0;  // Remove the coin signal
        $display("FSM should return to IDLE state.");

        // Wait to observe final state
        #20;

        // Finish simulation
        $stop;
    end

endmodule