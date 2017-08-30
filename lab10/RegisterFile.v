`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [31:0] BusA; //Outputs of data read
    output [31:0] BusB; 
    input [31:0] BusW; //Writing data
    input [4:0] RW, RA, RB; //Read address A, B and Write
    input RegWr, Clk;
    
    reg [31:0] registers[31:0]; //32x32 register
     
    assign #2 BusA = (RA == 0) ? 0 : registers[RA]; //data from registers to specific bus
    assign #2 BusB = (RB == 0) ? 0 : registers[RB];
     
    always @ (negedge Clk) begin //based on negative clock edge
        if(RegWr)
            registers[RW] <= #3 BusW;
    end
endmodule
