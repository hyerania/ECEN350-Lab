`timescale 1ns/1ps

module ALUControl (ALUCtrl, ALUop, FuncCode);

//Inputs
input [3:0] ALUop;
input [5:0] FuncCode;

//Output
output [3:0] ALUCtrl;

//Internal nets
reg [3:0] ALUCtrl;

always@(ALUop or FuncCode) begin
	//If operation is an R-type
	if(ALUop == 4'b1111) begin
		case(FuncCode)
		//FuncCode based on Green Sheet of MIPS
		6'b000000: ALUCtrl <= #2 4'b0011; //SLL based on FuncCode
		6'b000010: ALUCtrl <= #2 4'b0100; //SRL
		6'b100000: ALUCtrl <= #2 4'b0010; //ADD
		6'b100010: ALUCtrl <= #2 4'b0110; //SUB
		6'b100100: ALUCtrl <= #2 4'b0000; //AND
		6'b100101: ALUCtrl <= #2 4'b0001; //OR
		6'b101010: ALUCtrl <= #2 4'b0111; //SLT
		6'b000011: ALUCtrl <= #2 4'b1101; //SRA
		6'b100001: ALUCtrl <= #2 4'b1000; //ADDU
		6'b100011: ALUCtrl <= #2 4'b1001; //SUBU
		6'b100111: ALUCtrl <= #2 4'b1100; //NOR
		6'b101011: ALUCtrl <= #2 4'b1011; //SLTU
		6'b100110: ALUCtrl <= #2 4'b1010; //XOR
		endcase
	end
	//If operation is not an R-type, FuncCode does not matter
	else
		ALUCtrl <= #2 ALUop;
	end

endmodule