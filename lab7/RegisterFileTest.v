`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:13:28 03/03/2009
// Design Name:   RegisterFile
// Module Name:   E:/350/Lab7/RegisterFile/RegisterFileTest.v
// Project Name:  RegisterFile
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module RegisterFileTest_v;


	task passTest;
		input [31:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed"); //Examines if all tests have passed
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [31:0] BusW;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW;
	reg RegWr;
	reg Clk;
	reg [7:0] passed;

	// Outputs
	wire [31:0] BusA;
	wire [31:0] BusB;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.BusA(BusA), 
		.BusB(BusB), 
		.BusW(BusW), 
		.RA(RA), 
		.RB(RB), 
		.RW(RW), 
		.RegWr(RegWr), 
		.Clk(Clk)
	);

	initial begin
		// Initialize Inputs
		BusW = 0;
		RA = 0;
		RB = 0;
		RW = 0;
		RegWr = 0;
		Clk = 1;
		passed = 0;
		
		#10;

		// Add stimulus here
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 32'h0, 1'b0};
		passTest(BusA, 32'h0, "Initial $0 Check 1", passed);
		passTest(BusB, 32'h0, "Initial $0 Check 2", passed);
		#5; Clk = 0; #5; Clk = 1;
		
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 32'h12345678, 1'b1};
		passTest(BusA, 32'h0, "Initial $0 Check 3", passed);
		passTest(BusB, 32'h0, "Initial $0 Check 4", passed);
		#5; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h0, "$0 Stays 0 Check 1", passed);
		passTest(BusB, 32'h0, "$0 Stays 0 Check 2", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 32'h0, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd1, 32'h1, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd2, 32'h2, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd3, 32'h3, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd4, 32'h4, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd5, 32'h5, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd6, 32'h6, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd7, 32'h7, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd8, 32'h8, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd9, 32'h9, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd10, 32'h10, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd11, 32'h11, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd12, 32'h12, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd13, 32'h13, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd14, 32'h14, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd15, 32'h15, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd16, 32'h16, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd17, 32'h17, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd18, 32'h18, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd19, 32'h19, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd20, 32'h20, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd21, 32'h21, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd22, 32'h22, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd23, 32'h23, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd24, 32'h24, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd25, 32'h25, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd26, 32'h26, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd27, 32'h27, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd28, 32'h28, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd29, 32'h29, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd30, 32'h30, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd31, 32'h31, 1'b1};#5; Clk = 0; #5; Clk = 1;

		{RA, RB, RW, BusW, RegWr} = {5'd1, 5'd2, 5'd1, 32'h12345678, 1'b1};
		#2;
		passTest(BusA, 32'h1, "Initial Value Check 1", passed);
		passTest(BusB, 32'h2, "Initial Value Check 2", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h1, "Value Updated 1", passed);
		passTest(BusB, 32'h2, "Value Stayed Same 1", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd3, 5'd4, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h3, "Initial Value Check 3", passed);
		passTest(BusB, 32'h4, "Initial Value Check 4", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h3, "Value Not Updated 2", passed);
		passTest(BusB, 32'h4, "Value Stayed Same 2", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd5, 5'd6, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h5, "Initial Value Check 5", passed);
		passTest(BusB, 32'h6, "Initial Value Check 6", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h5, "Value Not Updated 3", passed);
		passTest(BusB, 32'h6, "Value Stayed Same 3", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd7, 5'd8, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h7, "Initial Value Check 7", passed);
		passTest(BusB, 32'h8, "Initial Value Check 8", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h7, "Value Not Updated 4", passed);
		passTest(BusB, 32'h8, "Value Stayed Same 4", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd9, 5'd10, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h9, "Initial Value Check 9", passed);
		passTest(BusB, 32'h10, "Initial Value Check 10", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h9, "Value Not Updated 5", passed);
		passTest(BusB, 32'h10, "Value Stayed Same 5", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd11, 5'd12, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h11, "Initial Value Check 11", passed);
		passTest(BusB, 32'h12, "Initial Value Check 12", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h11, "Value Not Updated 6", passed);
		passTest(BusB, 32'h12, "Value Stayed Same 6", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd13, 5'd14, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h13, "Initial Value Check 13", passed);
		passTest(BusB, 32'h14, "Initial Value Check 14", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h13, "Value Not Updated 7", passed);
		passTest(BusB, 32'h14, "Value Stayed Same 7", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd15, 5'd16, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h15, "Initial Value Check 15", passed);
		passTest(BusB, 32'h16, "Initial Value Check 16", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h15, "Value Not Updated 8", passed);
		passTest(BusB, 32'h16, "Value Stayed Same 8", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd17, 5'd18, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h17, "Initial Value Check 17", passed);
		passTest(BusB, 32'h18, "Initial Value Check 18", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h17, "Value Not Updated 9", passed);
		passTest(BusB, 32'h18, "Value Stayed Same 9", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd19, 5'd20, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h19, "Initial Value Check 19", passed);
		passTest(BusB, 32'h20, "Initial Value Check 20", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h19, "Value Not Updated 10", passed);
		passTest(BusB, 32'h20, "Value Stayed Same 10", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd21, 5'd22, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h21, "Initial Value Check 21", passed);
		passTest(BusB, 32'h22, "Initial Value Check 22", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h21, "Value Not Updated 11", passed);
		passTest(BusB, 32'h22, "Value Stayed Same 11", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd23, 5'd24, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h23, "Initial Value Check 23", passed);
		passTest(BusB, 32'h24, "Initial Value Check 24", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h23, "Value Not Updated 12", passed);
		passTest(BusB, 32'h24, "Value Stayed Same 12", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd25, 5'd26, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h25, "Initial Value Check 25", passed);
		passTest(BusB, 32'h26, "Initial Value Check 26", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h25, "Value Not Updated 13", passed);
		passTest(BusB, 32'h26, "Value Stayed Same 13", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd27, 5'd28, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h27, "Initial Value Check 27", passed);
		passTest(BusB, 32'h28, "Initial Value Check 28", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h27, "Value Not Updated 14", passed);
		passTest(BusB, 32'h28, "Value Stayed Same 14", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd29, 5'd30, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h29, "Initial Value Check 29", passed);
		passTest(BusB, 32'h30, "Initial Value Check 30", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h29, "Value Not Updated 15", passed);
		passTest(BusB, 32'h30, "Value Stayed Same 15", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd31, 5'd32, 5'd3, 32'h12345678, 1'b0};
		#2;
		passTest(BusA, 32'h31, "Initial Value Check 31", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h31, "Value Not Updated 16", passed);

		allPassed(passed, 68);
	end
      
endmodule

