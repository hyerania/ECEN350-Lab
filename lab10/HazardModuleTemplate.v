`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24 04/24/2015 
// Design Name: 
// Module Name:    HazardDummyModule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Hazard(PCWrite, IFWrite, Bubble, Branch, ALUZero4, Jump, rw, rs, rt, Reset_L, CLK);
	input			Branch;
	input			ALUZero4;
	input			Jump;
	input	[4:0]	rw;
	input	[4:0]	rs;
	input	[4:0]	rt;
	input			Reset_L;
	input			CLK;
	output reg		PCWrite;
	output reg		IFWrite;
	output reg		Bubble;
	
	/*state definition for FSM*/
				parameter NoHazard_state = 3'b000,
				/*Define a name for each of the states so it is easier to 					debug and follow*/ 
				 
	
	/*internal signals*/
	wire cmp1, ...;
	
	/*internal state*/
	reg [2:0] FSM_state, FSM_nxt_state;
	reg [4:0] rw1, ... ; //rw history registers
	
	/*create compare logic*/
	assign  cmp1 = (((rs==rw1)||(rt==rw1))&&(rw1!= 0)) ? 1:0;
	/* cmp1 finds the dependancy btween current instruction and theonebefore make 	cmpx if needed/*


	/*keep track of rw*/
	always @(negedge CLK) begin
		if(Reset_L ==  0) begin
			rw1 <=  0;
			...
		end
		else begin
			rw1 <= Bubble?0:rw;//insert bubble if needed
			...
		end
	end
	
		
	/*FSM state register*/
	always @(negedge CLK) begin
		if(Reset_L == 0) 
			FSM_state <= 0;
		else
			FSM_state <= FSM_nxt_state;
	end
	
	/*FSM next state and output logic*/
	always @(*) begin //combinatory logic
		case(FSM_state)
			NoHazard_state: begin 
				if(Jump== 1'b1) begin //prioritize jump
					//uncondition return to no hazard state
					/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
				end
				else if(cmp1== 1'b1) begin //3-delay data hazard
					//uncondition return to no hazard state
					/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
				end
				...
				/* Complite the "NoHazard_state" state as needed*/
			end
			Bubble0_state: begin
			//uncondition return to no hazard state
			/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
			end
			
			....
			/* Complitr the states as needed*/
			
			default: begin
				FSM_nxt_state <= #2 NoHazard_state;
				PCWrite <= #2 1'bx;
				IFWrite <= #2 1'bx;
				Bubble  <= #2 1'bx;
			end
		endcase
	end
endmodule
