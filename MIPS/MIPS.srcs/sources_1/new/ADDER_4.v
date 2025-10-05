`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:57:54 PM
// Design Name: 
// Module Name: ADDER_4
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


module ADDER_4(pc_in, adder_result); 
     input [31:0] pc_in; 
	  output  [31:0] adder_result; 
	 
	 assign adder_result = pc_in + 4; 
endmodule 
