`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [32:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed"); //Testing if all cases passed
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [31:0] BusA;
	reg [31:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [31:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

		// Add stimulus here
		//Test vectors from prelab
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'h00000000, 4'd2}; #40; passTest({Zero, BusW}, 33'h100000000, "ADD 0,0", passed); 
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'hFFFFFFFF, 4'd2}; #40; passTest({Zero, BusW}, 33'h0FFFFFFFF, "ADD 0,-1", passed);
		{BusA, BusB, ALUCtrl} = {32'hFFFFFFFF, 32'h00000001, 4'd2}; #40; passTest({Zero, BusW}, 33'h100000000, "ADD -1,1", passed);
		{BusA, BusB, ALUCtrl} = {32'h000000FF, 32'h00000001, 4'd2}; #40; passTest({Zero, BusW}, 33'h000000100, "ADD FF,1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'h00000000, 4'd6}; #40; passTest({Zero, BusW}, 33'h100000000, "SUB 0,0", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000001, 32'hFFFFFFFF, 4'd6}; #40; passTest({Zero, BusW}, 33'h000000002, "SUB 1,-1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000001, 32'h00000001, 4'd6}; #40; passTest({Zero, BusW}, 33'h100000000, "SUB 1,1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'h00000000, 4'd7}; #40; passTest({Zero, BusW}, 33'h100000000, "SLT 0,0", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'h00000001, 4'd7}; #40; passTest({Zero, BusW}, 33'h000000001, "SLT 0,1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'hFFFFFFFF, 4'd7}; #40; passTest({Zero, BusW}, 33'h100000000, "SLT 0,-1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000001, 32'h00000000, 4'd7}; #40; passTest({Zero, BusW}, 33'h100000000, "SLT 1,0", passed);
		{BusA, BusB, ALUCtrl} = {32'hFFFFFFFF, 32'h00000000, 4'd7}; #40; passTest({Zero, BusW}, 33'h000000001, "SLT -1,0", passed);
		{BusA, BusB, ALUCtrl} = {32'hFFFFFFFF, 32'hFFFFFFFF, 4'd0}; #40; passTest({Zero, BusW}, 33'h0FFFFFFFF, "AND 0xFFFFFFFF,0xFFFFFFFF", passed);
		{BusA, BusB, ALUCtrl} = {32'hFFFFFFFF, 32'hCAFEBABE, 4'd0}; #40; passTest({Zero, BusW}, 33'h0CAFEBABE, "AND 0xFFFFFFFF,0xCAFEBABE", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'hFFFFFFFF, 4'd0}; #40; passTest({Zero, BusW}, 33'h100000000, "AND 0,0xFFFFFFFF", passed);
		{BusA, BusB, ALUCtrl} = {32'h12345678, 32'h87654321, 4'd0}; #40; passTest({Zero, BusW}, 33'h002244220, "AND 0x12345678,0x87654321", passed);
		{BusA, BusB, ALUCtrl} = {32'hF0F0F0F0, 32'h0000FFFF, 4'd1}; #40; passTest({Zero, BusW}, 33'h0F0F0FFFF, "OR 0xF0F0F0F0,0x0000FFFF", passed);
		{BusA, BusB, ALUCtrl} = {32'h12345678, 32'h87654321, 4'd1}; #40; passTest({Zero, BusW}, 33'h097755779, "OR 0x12345678,0x87654321", passed);
		{BusA, BusB, ALUCtrl} = {32'h12345678, 32'h2, 4'd3}; #40; passTest({Zero, BusW}, 33'h048D159E0, "SLL 0x12345678,2", passed);
		{BusA, BusB, ALUCtrl} = {32'h80000000, 32'h3, 4'd3}; #40; passTest({Zero, BusW}, 33'h100000000, "SLL 0x80000000,3", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000001, 32'h3, 4'd4}; #40; passTest({Zero, BusW}, 33'h100000000, "SRL 0x00000001,3", passed);
		{BusA, BusB, ALUCtrl} = {32'h00001234, 32'h6, 4'd4}; #40; passTest({Zero, BusW}, 33'h000000048, "SRL 0x00001234,6", passed);

		//Original test file from Github
		{BusA, BusB, ALUCtrl} = {32'hFFFF1234, 32'd6, 4'd4}; #40; passTest({Zero, BusW}, 33'h003FFFC48, "SRL 0xFFFF1234,6", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'h00000000, 4'd8}; #40; passTest({Zero, BusW}, 33'h100000000, "ADDU 0,0", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'hFFFFFFFF, 4'd8}; #40; passTest({Zero, BusW}, 33'h0FFFFFFFF, "ADDU 0,-1", passed);
		{BusA, BusB, ALUCtrl} = {32'hFFFFFFFF, 32'h00000000, 4'd8}; #40; passTest({Zero, BusW}, 33'h0FFFFFFFF, "ADDU -1,0", passed);
		{BusA, BusB, ALUCtrl} = {32'h000000FF, 32'h00000001, 4'd8}; #40; passTest({Zero, BusW}, 33'h000000100, "ADDU FF,1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'h00000000, 4'd8}; #40; passTest({Zero, BusW}, 33'h100000000, "SUBU 0,0", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000001, 32'hFFFFFFFF, 4'd9}; #40; passTest({Zero, BusW}, 33'h000000002, "SUBU 1,-1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000001, 32'h00000001, 4'd9}; #40; passTest({Zero, BusW}, 33'h100000000, "SUBU 1,1", passed);
		{BusA, BusB, ALUCtrl} = {32'hF0F0F0F0, 32'h0000FFFF, 4'd10}; #40; passTest({Zero, BusW}, 33'h0F0F00F0F, "XOR 0xF0F0F0F0,0x0000FFFF", passed);
		{BusA, BusB, ALUCtrl} = {32'h12345678, 32'h87654321, 4'd10}; #40; passTest({Zero, BusW}, 33'h095511559, "XOR 0x12345678,0x87654321", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'h00000000, 4'd11}; #40; passTest({Zero, BusW}, 33'h100000000, "SLTU 0,0", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'h00000001, 4'd11}; #40; passTest({Zero, BusW}, 33'h000000001, "SLTU 0,1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000000, 32'hFFFFFFFF, 4'd11}; #40; passTest({Zero, BusW}, 33'h000000001, "SLTU 0,-1", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000001, 32'h00000000, 4'd11}; #40; passTest({Zero, BusW}, 33'h100000000, "SLTU 1,0", passed);
		{BusA, BusB, ALUCtrl} = {32'hFFFFFFFF, 32'h00000000, 4'd11}; #40; passTest({Zero, BusW}, 33'h100000000, "SLTU -1,0", passed);
		{BusA, BusB, ALUCtrl} = {32'hF0F0F0F0, 32'h0000FFFF, 4'd12}; #40; passTest({Zero, BusW}, 33'h00F0F0000, "NOR 0xF0F0F0F0,0x0000FFFF", passed);
		{BusA, BusB, ALUCtrl} = {32'h12345678, 32'h87654321, 4'd12}; #40; passTest({Zero, BusW}, 33'h0688aa886, "NOR 0x12345678,0x87654321", passed);
		{BusA, BusB, ALUCtrl} = {32'h00000001, 32'd3, 4'd13}; #40; passTest({Zero, BusW}, 33'h100000000, "SRA 0x00000001,3", passed);
		{BusA, BusB, ALUCtrl} = {32'h00001234, 32'd6, 4'd13}; #40; passTest({Zero, BusW}, 33'h000000048, "SRA 0x00001234,6", passed);
		{BusA, BusB, ALUCtrl} = {32'hFFFF1234, 32'd6, 4'd13}; #40; passTest({Zero, BusW}, 33'h0FFFFFC48, "SRA 0xFFFF1234,6", passed);
		{BusA, BusB, ALUCtrl} = {32'h0, 32'h12345678, 4'd14}; #40; passTest({Zero, BusW}, 33'h056780000, "LUI 0x12345678", passed);
		{BusA, BusB, ALUCtrl} = {32'h0, 32'h00001234, 4'd14}; #40; passTest({Zero, BusW}, 33'h012340000, "LUI 0x00001234", passed);

		allPassed(passed, 44); //All test cases with prelab and given
	end
      
endmodule

