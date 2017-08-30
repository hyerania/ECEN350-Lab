`timescale 1ns/1ps

module NextPClogic(NextPC, CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump);

//Inputs
input [31:0] CurrentPC, SignExtImm32;
input [25:0] JumpField;
input Branch, ALUZero, Jump;

//Outputs
output [31:0] NextPC;

//Internal Nets
reg[31:0] NextPC;
wire [31:0] PC_4;

//Updating PC with next instruction.
assign #1 PC_4 = CurrentPC + 32'h4;

always@(*) begin
if (Jump == 1)
	NextPC <= #2 {PC_4[31:28], JumpField, 2'b00}; //Adding the 4 bits of the PC + 4, the 26 bits of the jump field and shifting by 2 by adding 0 bits at the end
else if (Branch == 1 && ALUZero == 1) //Only if both opeartions are 1 shall branch take place
	NextPC <= #2 PC_4 + (SignExtImm32 << 2); //The next instruction will be the sign extension shifted by 4 bits added to the value of PC + 4.
else
	NextPC <= #2 PC_4; //If neither of these operations are selected, then go to the next instruction.
end

endmodule