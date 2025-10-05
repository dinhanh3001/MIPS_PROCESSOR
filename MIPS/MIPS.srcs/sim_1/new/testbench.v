`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:05:50 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench; 

    reg clk, reset;
	 
    initial begin
	     reset = 1'b0; 
        clk = 0;
        forever #5 clk = ~clk; // Xung nh?p 10ns
    end
    MIPS mips_inst(.clk(clk));
    initial begin
        #100 ; $stop; 
    end

endmodule 
