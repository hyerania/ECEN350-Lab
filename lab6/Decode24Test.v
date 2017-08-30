`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:06:33 03/02/2009
// Design Name:   Decode24
// Module Name:   E:/350/Lab6/Decode24/Decode24Test.v
// Project Name:  Decode24
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Decode24
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 15
module Decode24Test_v;

	task passTest;
		input [3:0] actualOut, expectedOut; //4-bit output results in order to verify result
		input [`STRLEN*8:0] testType;
		inout [3:0] passed;
	
		/*Verification of actual output to expected output, else displays the error*/
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [3:0] passed;
		input [3:0] numTests; //Only 4 different test cases

		//Based on passed tests, display if all tests have passed or if they have failed.
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	// Inputs
	reg [1:0] in;
	reg [3:0] passed;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	Decode24 uut (
		.in(in), 
		.out(out)
		);

	initial begin
		// Initialize Inputs
		in = 0;
		passed = 0;

		// Add stimulus here
		#90; in = 0; #10; passTest(out, 1, "Input 0", passed); //Output in decimal value, actual output in binary
		#90; in = 1; #10; passTest(out, 2, "Input 1", passed);
		#90; in = 2; #10; passTest(out, 4, "Input 2", passed);
		#90; in = 3; #10; passTest(out, 8, "Input 3", passed);
		#90; //Extra time in order to see final result

		allPassed(passed, 4);

	end
      
endmodule

