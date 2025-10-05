`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:00:53 PM
// Design Name: 
// Module Name: MUX_BRANCH
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


module MUX_BRANCH(a,b,out,select);
     input [31:0] a,b; 
	  output [31:0] out; 
	  input select; 

assign out = (select ==1'b0) ? a: b; 
endmodule