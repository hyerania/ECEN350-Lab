`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:16:03 03/10/2009 
// Design Name: 
// Module Name:    SingleCycleProc 
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
module SingleCycleProc(CLK, Reset_L, startPC, dMemOut);
   input CLK;
   input Reset_L;
   input [31:0]	startPC;
   output [31:0]	dMemOut;
	
	//PC Logic
	wire	[31:0]	nextPC;
	reg	[31:0]	currentPC;
	
	//Instruction Decode
	wire	[31:0]	currentInstruction;
	wire	[5:0]		opcode;
	wire	[4:0]		rs,rt,rd;
	wire	[15:0]	imm16;
	wire	[4:0]		shamt;
	wire	[5:0]		func;
	wire	[25:0]	jumpImmediate;
	
	assign {opcode, rs, rt, rd, shamt, func} = currentInstruction;
	assign imm16 = currentInstruction[15:0];
	assign jumpImmediate = currentInstruction[25:0];
	
	//Register wires
	wire	[31:0]	busA, busB, busW;
	wire	[4:0]		rw;
	
	//Control Logic Wires
	wire	RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend;
	wire	[3:0]		ALUOp;
	wire	[3:0]		ALUCtrl;
	wire	UseShiftField;
	
	//ALU Wires
	wire	[31:0]	ALUAIn, signExtImm32, ALUImmRegChoice, ALUBIn;
	wire	[31:0]	ALUResult;
	wire	ALUZero;
	
	//Data Memory Wires
	wire	[31:0]	dMemOut;

	//Instruction Memory
	InstructionMemory instrMem(currentInstruction, currentPC);	
	
	//PC Logic
	NextPClogic next(nextPC, currentPC, jumpImmediate, signExtImm32, Branch, ALUZero, Jump);
	always @ (negedge CLK, negedge Reset_L) begin
		if(~Reset_L)
			currentPC = startPC;
		else
			currentPC = nextPC;
	end
	
	//Control
	SingleCycleControl control(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend, ALUOp, opcode);
	
	//Register file
	/*create the RegDst mux*/
	assign #2 rw = (RegDst ? rd : rt); //RegDst will decide whether we write to rt or rd

	RegisterFile registers(busA, busB, busW, rs, rt, rw, RegWrite, CLK);
	
	//Sign Extender
	/*instantiate the sign extender*/
	SignExtender s_ext(signExtImm32, imm16, SignExtend);
	
	//ALU
	ALUControl ALUCont(ALUCtrl, ALUOp, func);
	assign #2 UseShiftField = ((ALUOp == 4'b1111) && ((func == 6'b000000) || (func == 6'b000010) || (func == 6'b000011)));
	assign #2 ALUImmRegChoice = ALUSrc ? signExtImm32 : busB;
	assign #2 ALUBIn = UseShiftField ? {27'b0, shamt} : ALUImmRegChoice;
	assign #2 ALUAIn = UseShiftField ? busB : busA;
	ALU mainALU(ALUResult, ALUZero, ALUAIn, ALUBIn, ALUCtrl); //Instantiate ALU
	 
	//Data Memory
	DataMemory data(dMemOut, ALUResult, busB, MemRead, MemWrite, CLK);
	/*create MemToReg mux */
	assign #2 busW = (MemToReg ? dMemOut: ALUResult); //MemToReg decides from the output of DataMemory or the ALUResult. 
	
endmodule