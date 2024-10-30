module simple_fsm
(
input wire sys_clk,
input wire sys_rst_n,
input wire coin,

output wire cola
);

parameter IDLE = 3'b001;//no coins inserted
parameter ONE = 3'b010;//1 coin inserted
parameter TWO = 3'b100;//2 coins inserted and a cola will come out

reg[2:0] st_next;//next state    3-bit-wide
reg[2:0] st_cur;//current state

always@(posedge sys_clk or negedge sys_rst_n)
begin
     if(!sys_rst_n)
	     begin
		     st_cur<=IDLE;
		  end
	  else
	     begin
		     st_cur<=st_next;
		  end
end


always@(*)
begin
    case(st_cur)
	    IDLE: if(coin==1'b1)
		       st_next=ONE;
				 else
				 st_next=IDLE;
		 ONE:if(coin==1'b1)
		       st_next=TWO;
				else
				 st_next=ONE;
		 TWO:if(coin==1'b1)
		       st_next=IDLE;
				else
				 st_next=TWO;
		 default: 
		       st_next=IDLE;				 
	 endcase
end


reg cola_r;
always@(posedge sys_clk or negedge sys_rst_n)
begin
   if(!sys_rst_n)
	   cola_r <= 1'b0;
	else if ((st_cur==TWO)&&(coin==1'b1))
	   cola_r <= 1'b1;
	else
      cola_r <= 1'b0;
end

assign cola = cola_r; 



endmodule

