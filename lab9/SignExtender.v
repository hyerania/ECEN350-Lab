`timescale 1ns / 1ps //Based on the test file

module SignExtender (BusImm, Imm16 , Ctrl ) ;
output [ 31 : 0 ] BusImm; //32-bit output
input [ 15 : 0 ] Imm16 ; //16-bit input
input Ctrl ;

wire extBit ;
assign #1 extBit = ( Ctrl ? 1'b0 : Imm16[15] ) ; //Error in lab, need the first bit to know sign
assign BusImm = {{16{extBit}} , Imm16}; //Extend the 16-bit with the appropriate value based on extBit

endmodule