`timescale 1ns/1ps

//Define operations
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
//ori = 4'b0001, addi = 4'b0010,

module ALU(BusW, Zero, BusA, BusB, ALUCtrl);
    
    //Ports are 32-bits
    parameter n = 32;
    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl; //4-bits wide to support 16 different functions
    output  Zero;				// Zero=1 if BusW=0. Zero=0 if BusW=!0  
    reg     [n-1:0] BusW;
    
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
			`AND: begin
				BusW <= #20 BusA & BusB; //And operation through the operaind &
			end
			`OR: begin
				BusW <= #20 BusA | BusB;
        	end
			`ADD: begin	
				BusW  <= #20 $signed(BusA) + $signed(BusB); //Assumes signed for add in MIPS
			end
			`SLL: begin
				BusW  <= #20 BusA << BusB; //Shift left
			end
			`SRL: begin
				BusW  <= #20 BusA >> BusB; //Shift right
			end
			`SUB: begin
				BusW  <= #20 $signed(BusA) - $signed(BusB); //Assumes signed for sub in MIPS
			end
			`SLT: begin
				BusW <= #20 ( {~BusA[31],BusA[30:0]} < {~BusB[31],BusB[30:0]} ) ? 1 : 0; //Compare values of BusA and BusB to know if true (1) less than or false (0) not less than
			end
			`ADDU: begin
				BusW <= #20 BusA + BusB; //Unsigned
			end
			`SUBU: begin
				BusW  <= #20 BusA - BusB; //Unsigned
			end
			`XOR: begin
				BusW  <= #20 BusA ^ BusB;
			end
			`SLTU: begin
				BusW  <= #20 ( BusA < BusB ) ? 1 : 0; //Unsigned
			end
			`NOR: begin
				BusW  <= #20 ~(BusA | BusB);
			end
			`SRA: begin
				BusW  <= #20 $signed(BusA) >>> BusB;
			end
			`LUI: begin
				BusW  <= #20 { BusB[15:0], 16'b0 }; //Lower bits filled with 0's
			end
        endcase
    end
	assign #1 Zero = ( BusW ) ? 0 : 1;
endmodule
