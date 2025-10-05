`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:00:14 PM
// Design Name: 
// Module Name: MUX_DATA_MEM
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


module MUX_DATA_MEM(a,b,out,memtoreg);
     input [31:0] a,b; 
	  output [31:0] out; 
	  input memtoreg; 
	  
assign out = (memtoreg ==1'b0) ? a: b; 
endmodule 
