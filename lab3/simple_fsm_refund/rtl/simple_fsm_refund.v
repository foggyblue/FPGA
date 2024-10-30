module simple_fsm_refund
(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire coin,
    input wire refund_request,  // New input: refund request

    output wire cola,
    output wire refund          // New output: refund signal
);

parameter IDLE = 3'b001;
parameter ONE = 3'b010;
parameter TWO = 3'b100;

reg [2:0] st_next;
reg [2:0] st_cur;

// Sequential logic: state transition
always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (!sys_rst_n)
        st_cur <= IDLE;
    else
        st_cur <= st_next;
end

// Combinational logic: next state logic
always @(*)
begin
    case (st_cur)
        IDLE:
            if (coin == 1'b1)
                st_next = ONE;
            else
                st_next = IDLE;

        ONE:
            if (coin == 1'b1)
                st_next = TWO;
            else if (refund_request == 1'b1)  // New condition: refund request
                st_next = IDLE;
            else
                st_next = ONE;

        TWO:
            if (coin == 1'b1)
                st_next = IDLE;
            else
                st_next = TWO;

        default:
            st_next = IDLE;
    endcase
end

// Output logic: cola dispensing
reg cola_r;
always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (!sys_rst_n)
        cola_r <= 1'b0;
    else if ((st_cur == TWO) && (coin == 1'b1))
        cola_r <= 1'b1;
    else
        cola_r <= 1'b0;
end

// Output logic: refund signal
reg refund_r;
always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (!sys_rst_n)
        refund_r <= 1'b0;
    else if ((st_cur == ONE) && (refund_request == 1'b1))  // Refund condition
        refund_r <= 1'b1;
    else
        refund_r <= 1'b0;
end

// Assign output signals
assign cola = cola_r;
assign refund = refund_r;

endmodule