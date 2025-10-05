`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:56:10 PM
// Design Name: 
// Module Name: ALU
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

 module ALU(alu_control, a, b, alu_result, zero);
    input [3:0] alu_control;
    input [31:0] a, b;
    output reg [31:0] alu_result;
    output reg zero;
    always @(*)
    begin
        case (alu_control)
            4'b0000: begin
                alu_result = a & b;
                zero = 1'b0;
            end
            4'b0001: begin
                alu_result = a | b;
                zero = 1'b0;
            end
            4'b0010: begin
                alu_result = a + b;
                zero = 1'b0;
            end
            4'b0110: begin
                alu_result = a - b;
                zero = (alu_result == 32'b0) ? 1'b1 : 1'b0;
            end
            4'b0111: begin
                if (a < b) alu_result = 32'b1;
                else alu_result = 32'b0;
                zero = 1'b0;
            end
            4'b1100: begin
                alu_result = ~(a | b);
                zero = 1'b0;
            end
            default: begin
                alu_result = 32'b0;
                zero = 1'b0;
            end
        endcase
    end
endmodule

