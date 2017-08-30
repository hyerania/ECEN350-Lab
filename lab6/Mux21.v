`timescale 1 ns/1 ps
`define STRLEN 15
/*This module describes a 1-bit wide multiplexor *
*using structural constructs and gate-level primitives*
* built into Verilog.*/

module Mux21(out, in, sel); //define module name and interface
	input [1:0] in; //declare inputs
	input sel; 
	output out; //declare output of type wire
	
	/*declare internal nets*/
	wire andA; //output of and0 gate
	wire andB; //output of and1 gate
	
	/*instantiate gate-level modules*/
	and (andA, in[0], ~sel); //Use ~ for negation
	and (andB, in[1], sel);
	or (out, andA, andB);
	
endmodule //designate end of module
