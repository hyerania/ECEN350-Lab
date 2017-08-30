`timescale 1ns/1ps
/*This module describes a 2:4 decoder using behavioral constructs*
*in Verilog HDL.*/

/*module interface for the 2:4 decoder*/
module Decode24(in, out);
	input [1:0] in; //2-bit input of type wire
	output reg [3:0] out; //4-bit output of type reg

	always @(in) begin //Triggered when in changes
		case(in)
			2'b00:		out = 4'b0001; //4'b signifies a 4-bit binary value
			2'b01:		out = 4'b0010;
			2'b10:		out = 4'b0100;
			2'b11:		out = 4'b1000;
		endcase //desginates end of case statement
	end
		
endmodule //designate end of module

