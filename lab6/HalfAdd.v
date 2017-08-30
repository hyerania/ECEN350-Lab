module HalfAdd (Cout, Sum, A, B);
/*This module describes a Half Adder using structural logic*
*in Verilog HDL.*/

input A, B; //declare inputs
output Cout, Sum; //declare outputs

/*Internal Wires*/
wire W1, W2, W3;

/*Instantiate gate-level modules*/
nand (W1, A, B);
nand (W2, A, W1);
nand (W3, W1, B);
nand (Sum, W2, W3); //Sum is nand of results from internal W2 and W3
nand (Cout, W1, W1); //Cout is nand of W1 and W1 for optimal designing

endmodule //designate end of module
