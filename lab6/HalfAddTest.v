`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:12:10 03/02/2009
// Design Name:   HalfAdd
// Module Name:   E:/350/Lab6/FullAdd/HalfAddTest.v
// Project Name:  HalfAdd
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HalfAdd
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Revised from FullAdd to Half Adder
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 15
module HalfAddTest_v;

   task passTest;
      input [1:0] actualOut, expectedOut; //Verify actual output with expected output
      input [`STRLEN*8:0] testType;
      inout [3:0]         passed; //Modify to only accept 4 outputs due to 4 test cases
      
      /*Verification of actual output to expected output, else displays the error*/
      if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
      else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
   endtask
   
   task allPassed;
      input [3:0] passed; //Modified for only 4 tests
      input [3:0] numTests; //Modifed for only 4 tests
      
      if(passed == numTests) $display ("All tests passed");
      else $display("Some tests failed");
   endtask

   // Inputs
   reg            A;
   reg            B;
   reg [3:0]      passed;

   // Outputs
   wire           Cout;
   wire           Sum;

   // Instantiate the Device Under Test (DUT)
   HalfAdd dut (
		.Cout(Cout), 
		.Sum(Sum), 
		.A(A), 
		.B(B)
	        );

   initial begin
      // Initialize Inputs
      A = 0;
      B = 0;
      passed = 0;

      // Add stimulus here
      #90; A=0;B=0; #10; passTest({Cout, Sum}, 0, "0+0", passed);
      #90; A=0;B=1; #10; passTest({Cout, Sum}, 1, "0+1", passed);
      #90; A=1;B=0; #10; passTest({Cout, Sum}, 1, "1+0", passed);
      #90; A=1;B=1; #10; passTest({Cout, Sum}, 2, "1+1", passed);
      #90; //Extra time to make sure to see the final result
      allPassed(passed, 4);

   end
   
endmodule

