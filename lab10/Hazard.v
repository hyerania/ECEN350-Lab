`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:22:52 04/11/2008 
// Design Name: 
// Module Name:    Hazard 
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

//FSM Hazard States Defined
`define NoHazard_state 3'b000
`define Bubble0 3'b001
`define Bubble1 3'b010
`define Branch0 3'b011
`define Branch1 3'b100
`define Branch2 3'b101
`define Jump0 	3'b110

module Hazard(PCWrite, IFWrite, Bubble, Branch, ALUZero4, Jump, rw, rs, rt, Reset_L, CLK);
	input			Branch;
	input			ALUZero4;
	input			Jump;
	input	[4:0]	rw;
	input	[4:0]	rs;
	input	[4:0]	rt;
	input			Reset_L;
	input			CLK;
	output		reg PCWrite;
	output		reg IFWrite;
	output		reg Bubble;
				 
	
	/*internal signals*/
	wire cmp1, cmp2, cmp3; //Compares rs and rt to previous stage, used to check dependencies
	
	/*internal state*/
	reg [2:0] FSM_state, FSM_nxt_state; //State machine
	reg [4:0] rw1, rw2, rw3; //rw history registers, hold previous values
	
	/*create compare logic*/
	/* cmp1, cmp2, cmp3 finds the dependancy btween current instruction and the one before make cmpx if needed*/
	assign cmp1 = (((rs==rw1)||(rt==rw1))&&(rw1!= 0)) ? 1:0; // 3 cycles of bubbles
	assign cmp2 = (((rs==rw2)||(rt==rw2))&&(rw2!= 0)) ? 1:0; // 2 cycles of bubbles
	assign cmp3 = (((rs==rw3)||(rt==rw3))&&(rw3!= 0)) ? 1:0; // 1 cycle of bubbles

	/*keep track of rw*/
	always @(negedge CLK) begin
		if(Reset_L ==  0) begin //Reset is inverted bit, if high value push previosuly written to registers
			rw1 <=  0;
			rw2 <=  0;
			rw3 <=  0;
		end
		else begin
			rw1 <= Bubble?0:rw;//insert bubble if needed; moving next value of rw into pipeline
			rw2 <= rw1;
			rw3 <= rw2;
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
			`NoHazard_state: begin 
				if(Jump == 1'b1) begin //prioritize jump
					//uncondition return to no hazard state
					/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
					FSM_nxt_state <= #2 `Jump0; //If jump, go to jump
					PCWrite <= #2 1;
					IFWrite <= #2 0;
					Bubble <= #2 1'bX;
				end
				
				else if(cmp1== 1'b1) begin //3-delay data hazard
					//uncondition return to no hazard state
					/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
					FSM_nxt_state <= #2 `Bubble0;
					PCWrite <= #2 0;
					IFWrite <= #2 0;
					Bubble <= #2 1;
				end
				
				else if (cmp2 == 1'b1) begin //2-delay data hazard
					FSM_nxt_state <= #2 `Bubble1;
					PCWrite <= #2 0;
					IFWrite <= #2 0;
					Bubble <= #2 1;
				end

				else if (cmp3 == 1'b1) begin //1-delay data hazard
					FSM_nxt_state <= #2 `NoHazard_state;
					PCWrite <= #2 0;
					IFWrite <= #2 0;
					Bubble <= #2 1;
				end

				else if(Branch) begin //If branch, go to branch
					FSM_nxt_state <= #2 `Branch0;
					PCWrite <= #2 0;
					IFWrite <= #2 0;
					Bubble <= #2 0;
				end
				/* Complite the "NoHazard_state" state as needed*/
				else begin 
					FSM_nxt_state <= #2 `NoHazard_state; //Default stage if no hazards
					PCWrite <= #2 1;
					IFWrite <= #2 1;
					Bubble <= #2 0;
				end
			end

			`Bubble0: begin
			//uncondition return to no hazard state
			/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
				FSM_nxt_state <=#2 `Bubble1; //Go to second bubble stage
				PCWrite <= #2 0;
				IFWrite <= #2 0;
				Bubble <= #2 1;
			end
			
			`Bubble1: begin
				FSM_nxt_state <=#2 `NoHazard_state; //Go to third bubble stage, which is back to n hazard
				PCWrite <= #2 0;
				IFWrite <= #2 0;
				Bubble <= #2 1;
			end

			`Branch0: begin
				FSM_nxt_state <=#2 `Branch1; //Go to 2nd branch hazard control
				PCWrite <= #2 0;
				IFWrite <= #2 0;
				Bubble <= #2 1;
			end

			`Branch1: begin
				if (ALUZero4) begin //Considers taken and not taken
					FSM_nxt_state <=#2 `Branch2; //Go to 2nd branch harzard control
					PCWrite <= #2 1; 
					IFWrite <= #2 0;
					Bubble <= #2 1;
				end

				else begin
					FSM_nxt_state <= #2 `NoHazard_state;
					PCWrite <= #2 1;
					IFWrite <= #2 1;
					Bubble <= #2 1;
				end
			end

			`Branch2: begin
				FSM_nxt_state <=#2 `NoHazard_state; //Last branch hazard control
				PCWrite <= #2 1;
				IFWrite <= #2 1;
				Bubble <= #2 1;
			end

			`Jump0: begin
				FSM_nxt_state <=#2 `NoHazard_state; //Goes to jump hazard control and then returns to no hazard state
				PCWrite <= #2 1;
				IFWrite <= #2 1;
				Bubble <= #2 1;
			end

			default: begin
				FSM_nxt_state <= #2 `NoHazard_state; //default case, returning to no hazard stage
				PCWrite <= #2 1'bX;
				IFWrite <= #2 1'bX;
				Bubble  <= #2 1'bx;
			end
		endcase
	end

endmodule
