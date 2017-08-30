`timescale 1ns / 1ps

`define STRLEN 15
module SignExenderTest_v;

	task passTest;
			input [31:0] actualOut, expectedOut;
			input [`STRLEN*8:0] testType;
			inout [7:0] passed;
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask

	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed"); //Display if all tests have passed
		else $display("Some tests failed");
	endtask
	
	// Inputs
	reg [15:0] Imm16;
	reg Ctrl;
	reg [7:0] passed;
	
	// Outputs
	wire [31:0] BusImm;
	
	// Instantiate the Device Under Test
	SignExtender dut(
		.BusImm(BusImm), 
		.Imm16(Imm16), 
		.Ctrl(Ctrl)
	);
	
	initial begin
		// Initialize Inputs
		Imm16 = 16'b0000000000000000;
		Ctrl = 0;			// Test will consist of extremes, Imm16[15] either 0 or 1
		passed = 0;
		
	// Add stimulus here
	#90; Imm16=16'b1111111111111111;Ctrl=0; #10; passTest(BusImm, 32'b11111111111111111111111111111111, "0xffffffff", passed); // Sign is extended
	#90; Imm16=16'b0111111111111111;Ctrl=0; #10; passTest(BusImm, 32'b00000000000000000111111111111111, "0x00007fff", passed);
	#90; Imm16=11;Ctrl=0; #10; passTest(BusImm, 8'hB, "0x00000011", passed); //Testing cases besides 0
	#90; Imm16=16'b1010111111111001;Ctrl=0; #10; passTest(BusImm, 32'b11111111111111111010111111111001, "0xFFFFAFF9", passed);

	#90; Imm16=16'b1111111111111111;Ctrl=1; #10; passTest(BusImm, 32'b00000000000000001111111111111111, "0x0000FFFF", passed); // Zero is extended
	#90; Imm16=16'b0111111111111111;Ctrl=1; #10; passTest(BusImm, 32'b00000000000000000111111111111111, "0x00007FFF", passed);
	#90; Imm16=10;Ctrl=1; #10; passTest(BusImm, 8'hA, "0x00000010", passed); //Testing cases besides 0
	#90; Imm16=16'b1010111111111001;Ctrl=1; #10; passTest(BusImm, 32'b00000000000000001010111111111001, "0xFFFFAFF9", passed);
	
	allPassed(passed, 8); //6 different test cases provided
	
	end

	endmodule
	
