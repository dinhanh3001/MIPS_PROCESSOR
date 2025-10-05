`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:02:18 PM
// Design Name: 
// Module Name: SIGN_EXTEND
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


module SIGN_EXTEND(sign_in, sign_out); 
    input [15:0] sign_in; 
	 output [31:0] sign_out; 
assign sign_out = {{16{sign_in[15]}},sign_in}; 
endmodule 
