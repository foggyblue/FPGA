`timescale 1ns/1ps

module simple_fsm_refund_tb;

    // Inputs to the FSM
    reg sys_clk;
    reg sys_rst_n;
    reg coin;
    reg refund_request;

    // Outputs from the FSM
    wire cola;
    wire refund;

    // Instantiate the FSM
    simple_fsm_refund uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .coin(coin),
        .refund_request(refund_request),
        .cola(cola),
        .refund(refund)
    );

    // Clock generation
    always #5 sys_clk = ~sys_clk;  // Clock period = 10ns (100MHz)

    initial begin
        // Initialize inputs
        sys_clk = 0;
        sys_rst_n = 0;
        coin = 0;
        refund_request = 0;

        // Apply reset (reset is active low, so we assert it by setting it to 0)
        $display("Applying reset...");
        #10 sys_rst_n = 1;  // Deassert reset after 10 time units
        $display("Reset deasserted, FSM should be in IDLE state.");

        // Insert the first coin (FSM should transition to ONE state)
        #10;
        $display("Inserting first coin...");
        coin = 1;
        #10;
        coin = 0;  // Remove the coin signal
        $display("FSM should now be in ONE state.");

        // Request a refund (FSM should return to IDLE state and refund should be asserted)
        #20;
        $display("Requesting refund...");
        refund_request = 1;
        #10;
        refund_request = 0;
        $display("FSM should return to IDLE state, refund should be asserted.");

        // Wait to see if refund is asserted
        #20;
        if (refund == 1'b1)
            $display("Refund issued correctly.");
        else
            $display("Error: Refund not issued.");

        // Insert the first coin again (FSM should transition to ONE state)
        #10;
        $display("Inserting first coin again...");
        coin = 1;
        #10;
        coin = 0;  // Remove the coin signal
        $display("FSM should now be in ONE state.");

        // Insert the second coin (FSM should transition to TWO state and cola should be dispensed)
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