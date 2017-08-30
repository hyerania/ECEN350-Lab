module GatesTest( );
reg [0:1] in;
wire [0:2] out;

Gates DUT (.in(in), .out(out));

initial
begin
  #0       in =0;
  #10      in=2'b01;
  #10      in=2'b10;
  #10      in=2'b11;
  #10      in=0;
  $finish;
end
endmodule
