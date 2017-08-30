module MiniRegisterFile(BusA, BusB, BusW, RW, RegWr, Clk);
    output [31:0] BusA;
    output [31:0] BusB;
    input [31:0] BusW;
    input RW;
    input RegWr;
    input Clk;
    reg [31:0] registers [1:0];
     
    assign #2 BusA = registers[0];
    assign #2 BusB = registers[1];
     
    always @ (negedge Clk) begin
        if(RegWr)
            registers[RW] <= #3 BusW;
    end
endmodule
