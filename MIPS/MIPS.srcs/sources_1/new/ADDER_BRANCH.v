`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:59:04 PM
// Design Name: 
// Module Name: ADDER_BRANCH
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

module ADDER_BRANCH(a,b,result); 
   input [31:0] a,b; 
	output [31:0] result ; 
	
assign result = a +b; 
endmodule 

