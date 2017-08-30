`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:43:49 03/10/2009
// Design Name:   SingleCycleProc
// Module Name:   E:/350/Lab10/SingleCycleProc/SingleCycleProcTest.v
// Project Name:  SingleCycleProc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SingleCycleProc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
`define HalfClockPeriod 60
`define ClockPeriod `HalfClockPeriod * 2
module SingleCycleProcTest_v;

	task passTest;
		input [31:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: 0x%x should be 0x%x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed"); //Check if all test cases passed
		else $display("Some tests failed: %d of %d passed", passed, numTests);
	endtask

	// Inputs
	reg CLK;
	reg Reset_L;
	reg [31:0] startPC;
	reg [7:0] passed;

	// Outputs
	wire [31:0] dMemOut;

	// Instantiate the Unit Under Test (UUT)
	SingleCycleProc uut (
		.CLK(CLK), 
		.Reset_L(Reset_L), 
		.startPC(startPC), 
		.dMemOut(dMemOut)
	);

	initial begin
		// Initialize Inputs
		Reset_L = 1;
		startPC = 0;
		passed = 0;
		
		// Wait for global reset
		#(1 * `ClockPeriod);

		// Program 1
		#1
		Reset_L = 0; startPC = 0;
		#(1 * `ClockPeriod);
		Reset_L = 1;
		#(33 * `ClockPeriod);
		passTest(dMemOut, 120, "Results of Program 1", passed);
		
		// Program 2
		#(1 * `ClockPeriod)
		Reset_L = 0; startPC = 32'h60;
		#(1 * `ClockPeriod);
		Reset_L = 1;
		#(11 * `ClockPeriod);
		passTest(dMemOut, 2, "Results of Program 2", passed);
		
		// Program 3
		#(1 * `ClockPeriod)
		Reset_L = 0; startPC = 32'hA0;
		#(1 * `ClockPeriod);
		Reset_L = 1;
		#(26 * `ClockPeriod);
		passTest(dMemOut, 32'hfeedbeef, "Result 1 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 32'hfeedb48f, "Result 2 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 32'hfeeeb48f, "Result 3 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 32'h0000b4a0, "Result 4 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 32'hddb7dde0, "Result 5 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 32'h07f76df7, "Result 6 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 32'hfff76df7, "Result 7 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 1, "Result 8 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 0, "Result 9 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 0, "Result 10 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 1, "Result 11 of Program 3", passed);
		#(1 * `ClockPeriod);
		passTest(dMemOut, 32'hfeed4b4f, "Result 12 of Program 3", passed);
		
		// Done
		allPassed(passed, 14);
		$stop;
	end
   
   initial begin
      CLK = 0;
   end
   
   // The following is correct if clock starts at LOW level at StartTime //
   always begin
      #`HalfClockPeriod CLK = ~CLK;
      #`HalfClockPeriod CLK = ~CLK;
   end
      
endmodule

