`timescale 1ns / 1ps
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SLL 4'b0011
`define SRL 4'b0100
`define SUB 4'b0110
`define SLT 4'b0111
`define ADDU 4'b1000
`define SUBU 4'b1001
`define XOR 4'b1010
`define SLTU 4'b1011
`define NOR 4'b1100
`define SRA 4'b1101
`define LUI 4'b1110

module ALU(BusW, Zero, BusA, BusB, ALUCtrl);
    
    parameter n = 32;

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
	 wire [31:0] BusA_cmp,BusB_cmp;
	 
    reg     [n-1:0] BusW;
    
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
         `AND: begin
            BusW <= #20 BusA & BusB;
         end

        endcase
    end
	assign #1 Zero = (BusW==32'b0) ? 1: 0;
endmodule