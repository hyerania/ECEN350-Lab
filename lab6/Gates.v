module Gates(in,out);
input [0:1] in;
output [0:2] out;

and and0(out[0],in[0],in[1]);
or or0(out[1],in[0],in[1]);
xor xor0(out[2],in[0],in[1]);

endmodule
