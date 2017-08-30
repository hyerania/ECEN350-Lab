`timescale 1ns / 1ps

`define SLLFunc  6'b000000
`define SRLFunc  6'b000010
`define ADDFunc  6'b100000
`define SUBFunc  6'b100010
`define ANDFunc  6'b100100
`define ORFunc   6'b100101
`define SLTFunc  6'b101010

`define STRLEN 32
module ALUControl_MyTest_v;

task passTest;
		input [5:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed"); //Display if all the tests have passed
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [3:0] ALUop;
	reg [5:0] FuncCode;
	reg [7:0] passed;

	// Outputs
	wire [3:0] ALUCtrl;

	// Instantiate the Unit Under Test (UUT)
	ALUControl uut (
		.ALUCtrl(ALUCtrl), 
		.ALUop(ALUop), 
		.FuncCode(FuncCode)
	);

	initial begin
		// Initialize Inputs
		passed = 0;
		ALUop = 0;
		FuncCode = 0;

//1: Checks for OverWrite ADD
		{FuncCode, ALUop} = {6'bXXXXXX, 4'b0010}; #40; passTest(ALUCtrl, 4'b0010, "(OverWrite ADD)", passed);
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);

//2: Checks for OverWrite SUB
		{FuncCode, ALUop} = {6'bXXXXXX, 4'b0110}; #40; passTest(ALUCtrl, 4'b0110, "(OverWrite SUB)", passed);
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);

//3: Checks SLL
		{FuncCode, ALUop} = {`SLLFunc, 4'b1111}; #40; passTest(ALUCtrl, 4'b0011, "(SLL)", passed);
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);

//4: Checks SRL
		{FuncCode, ALUop} = {`SRLFunc, 4'b1111}; #40; passTest(ALUCtrl, 4'b0100, "(SRL)", passed);
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);
		
//5: Checks ADD
		{FuncCode, ALUop} = {`ADDFunc, 4'b1111}; #40; passTest(ALUCtrl, 4'b0010, "(ADD)", passed);	
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);
		
//6: Checks SUB
		{FuncCode, ALUop} = {`SUBFunc, 4'b1111}; #40; passTest(ALUCtrl, 4'b0110, "(SUB)", passed);
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);
		
//7: Checks AND
		{FuncCode, ALUop} = {`ANDFunc, 4'b1111}; #40; passTest(ALUCtrl, 4'b0000, "(AND)", passed);	
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);
		
//8: Checks OR
		{FuncCode, ALUop} = {`ORFunc, 4'b1111}; #40; passTest(ALUCtrl, 4'b0001, "(OR)", passed);		
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);
		
//9: Checks SLT
		{FuncCode, ALUop} = {`SLTFunc, 4'b1111}; #40; passTest(ALUCtrl, 4'b0111, "(SLT)", passed);	
		$display("ALUop == %b, FuncCode == %b, ALUCtrl == %b\n", ALUop, FuncCode, ALUCtrl);
		
		allPassed(passed, 9);

	end
      
endmodule


