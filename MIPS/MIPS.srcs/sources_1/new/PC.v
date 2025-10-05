`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:52:27 PM
// Design Name: 
// Module Name: PC
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



module PC(pc_in, pc_out, clk, reset);
    input [31:0] pc_in;
    input clk, reset;
    output reg [31:0] pc_out;
    initial begin
        pc_out = 32'b0; // Kh?i t?o PC v? 0
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            pc_out <= 32'b0;
        else
            pc_out <= pc_in;
    end
endmodule
