`timescale 1ns / 1ps
`define STRLEN 32
module MyRegisterFileTest_v;


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
		
		if(passed == numTests) $display ("All tests passed"); //Show if all test cases have passed
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
		//Test code with indicated values for BusA and BusB
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
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd10, 32'hA, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd11, 32'hB, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd12, 32'hC, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd13, 32'hD, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd14, 32'hE, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd15, 32'hF, 1'b1};#5; Clk = 0; #5; Clk = 1;
		
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd1, 5'd0, 32'h0, 1'b0};
		#2;
		passTest(BusA, 32'h0, "Initial Value Check 1", passed);
		passTest(BusB, 32'h1, "Initial Value Check 2", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h0, "Value Updated 1", passed);
		passTest(BusB, 32'h1, "Value Stayed Same 1", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd2, 5'd3, 5'd1, 32'h1000, 1'b0};
		#2;
		passTest(BusA, 32'h2, "Initial Value Check 3", passed);
		passTest(BusB, 32'h3, "Initial Value Check 4", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h2, "Value Not Updated 2", passed);
		passTest(BusB, 32'h3, "Value Stayed Same 2", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd4, 5'd5, 5'd0, 32'h1000, 1'b0};
		#2;
		passTest(BusA, 32'h4, "Initial Value Check 5", passed);
		passTest(BusB, 32'h5, "Initial Value Check 6", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h4, "Value Not Updated 3", passed);
		passTest(BusB, 32'h5, "Value Stayed Same 3", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd6, 5'd7, 5'd10, 32'h1010, 1'b1};
		#2;
		passTest(BusA, 32'h6, "Initial Value Check 7", passed);
		passTest(BusB, 32'h7, "Initial Value Check 8", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h6, "Value Not Updated 4", passed);
		passTest(BusB, 32'h7, "Value Stayed Same 4", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd8, 5'd9, 5'd11, 32'h00103000, 1'b1};
		#2;
		passTest(BusA, 32'h8, "Initial Value Check 9", passed);
		passTest(BusB, 32'h9, "Initial Value Check 10", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h8, "Value Not Updated 5", passed);
		passTest(BusB, 32'h9, "Value Stayed Same 5", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd10, 5'd11, 5'd12, 32'h0, 1'b0};
		#2;
		passTest(BusA, 32'h1010, "Initial Value Check 11", passed);
		passTest(BusB, 32'h103000, "Initial Value Check 12", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h1010, "Value Not Updated 6", passed);
		passTest(BusB, 32'h103000, "Value Stayed Same 6", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd12, 5'd13, 5'd13, 32'hABCD, 1'b1};
		#2;
		passTest(BusA, 32'hC, "Initial Value Check 13", passed);
		passTest(BusB, 32'hD, "Initial Value Check 14", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'hC, "Value Not Updated 7", passed);
		passTest(BusB, 32'hD, "Value Stayed Same 7", passed);

		{RA, RB, RW, BusW, RegWr} = {5'd14, 5'd15, 5'd14, 32'h09080009, 1'b0};
		#2;
		passTest(BusA, 32'hE, "Initial Value Check 15", passed);
		passTest(BusB, 32'hF, "Initial Value Check 16", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'hE, "Value Not Updated 8", passed);
		passTest(BusB, 32'hF, "Value Stayed Same 8", passed);

		allPassed(passed, 38); //The various test cases based on the table presented with specifications
	end
      
endmodule

