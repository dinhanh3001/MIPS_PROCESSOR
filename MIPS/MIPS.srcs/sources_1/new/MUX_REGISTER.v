`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:59:38 PM
// Design Name: 
// Module Name: MUX_REGISTER
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

module MUX_REGISTER(a,b,out,regdst); 
      input [4:0] a, b; 
		input regdst; 
		output [4:0] out; 
assign out = (regdst ==1'b0) ? a : b; 
endmodule 

