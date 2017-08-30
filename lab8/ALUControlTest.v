`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:24:12 03/27/2009
// Design Name:   ALUControl
// Module Name:   E:/350/Lab9/ALUControl/ALUControlTest.v
// Project Name:  ALUControl
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALUControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

//Defines all the ALUCtrl for operations
`define AND		4'b0000
`define OR		4'b0001
`define ADD 	4'b0010
`define SLL 	4'b0011
`define SRL 	4'b0100
`define MULA	4'b0101
`define SUB 	4'b0110
`define SLT 	4'b0111
`define ADDU	4'b1000
`define SUBU	4'b1001
`define XOR		4'b1010
`define SLTU	4'b1011
`define NOR		4'b1100
`define SRA		4'b1101
`define LUI		4'b1110

//Defines all FuncCodes for operations
`define SLLFunc  6'b000000
`define SRLFunc  6'b000010
`define SRAFunc  6'b000011
`define ADDFunc  6'b100000
`define ADDUFunc 6'b100001
`define SUBFunc  6'b100010
`define SUBUFunc 6'b100011
`define ANDFunc  6'b100100
`define ORFunc   6'b100101
`define XORFunc  6'b100110
`define NORFunc  6'b100111
`define SLTFunc  6'b101010
`define SLTUFunc 6'b101011
`define MULAFunc 6'b111000

`define STRLEN 32
module ALUControlTest_v;


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
		
		if(passed == numTests) $display ("All tests passed"); //Displays if all tests have passed
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

		{ALUop, FuncCode} = {4'b1111, `SLLFunc};
		#10
		passTest(ALUCtrl, `SLL, "SLL Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `SRLFunc};
		#10
		passTest(ALUCtrl, `SRL, "SRL Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `SRAFunc};
		#10
		passTest(ALUCtrl, `SRA, "SRA Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `ADDFunc};
		#10
		passTest(ALUCtrl, `ADD, "ADD Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `ADDUFunc};
		#10
		passTest(ALUCtrl, `ADDU, "ADDU Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `SUBFunc};
		#10
		passTest(ALUCtrl, `SUB, "SUB Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `SUBUFunc};
		#10
		passTest(ALUCtrl, `SUBU, "SUBU Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `ANDFunc};
		#10
		passTest(ALUCtrl, `AND, "AND Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `ORFunc};
		#10
		passTest(ALUCtrl, `OR, "OR Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `XORFunc};
		#10
		passTest(ALUCtrl, `XOR, "XOR Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `NORFunc};
		#10
		passTest(ALUCtrl, `NOR, "NOR Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `SLTFunc};
		#10
		passTest(ALUCtrl, `SLT, "SLT Instruction", passed);
		
		{ALUop, FuncCode} = {4'b1111, `SLTUFunc};
		#10
		passTest(ALUCtrl, `SLTU, "SLTU Instruction", passed);
		
		{ALUop, FuncCode} = {`AND, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `AND, "ANDI Instruction", passed);
		
		{ALUop, FuncCode} = {`OR, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `OR, "ORI Instruction", passed);
		
		{ALUop, FuncCode} = {`ADD, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `ADD, "ADDI Instruction", passed);
				
		{ALUop, FuncCode} = {`SUB, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `SUB, "SUBI Instruction", passed);
		
		{ALUop, FuncCode} = {`SLT, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `SLT, "SLTI Instruction", passed);
		
		{ALUop, FuncCode} = {`ADDU, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `ADDU, "ADDIU Instruction", passed);
		
		{ALUop, FuncCode} = {`SUBU, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `SUBU, "SUBIU Instruction", passed);
		
		{ALUop, FuncCode} = {`XOR, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `XOR, "XORI Instruction", passed);
		
		{ALUop, FuncCode} = {`SLTU, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `SLTU, "SLTU Instruction", passed);
		
		{ALUop, FuncCode} = {`NOR, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `NOR, "NORI Instruction", passed);
		
		{ALUop, FuncCode} = {`LUI, 6'bXXXXXX};
		#10
		passTest(ALUCtrl, `LUI, "LUI Instruction", passed);
		
		allPassed(passed, 24);
	end
      
endmodule

