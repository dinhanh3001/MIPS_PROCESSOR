`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:01:33 PM
// Design Name: 
// Module Name: MUX_ALU
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

module MUX_ALU(a,b, out,alusrc); 
   input [31:0] a,b; 
	output [31:0] out; 
	input alusrc; 
assign out = (alusrc==1'b0) ? a :b; 
endmodule 
