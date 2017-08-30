`timescale 1ns / 1ps

module DataMemory(ReadData, Address, WriteData, MemoryRead, MemoryWrite, Clock);
//inputs
input[31:0] Address, WriteData;
input MemoryRead, MemoryWrite, Clock;

//output
output [31:0] ReadData;

//Internal nets
reg[31:0] DataMem[63:0]; //Data Memory size of 64 words, 32 bits each
reg[31:0] ReadData;

//Read and write have 20ns delay each
//Read to Memory
always@(posedge Clock) begin
	if(MemoryRead == 1 && MemoryWrite == 0) //Both signals cannot be active at same time
		ReadData <= #20 DataMem[Address>>2];
end

//Write to Memory
always@(negedge Clock) begin
	if(MemoryRead == 0 && MemoryWrite == 1) //Both signals cannot be active at same time
		DataMem[Address>>2] <= #20 WriteData;
end



endmodule
