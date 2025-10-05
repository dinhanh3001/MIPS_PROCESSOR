`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:58:31 PM
// Design Name: 
// Module Name: SHIFTER
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

module SHIFTER(in, out); 
    input [31:0] in; 
	 output [31:0] out; 
	 
assign out = in << 2; 
endmodule 
