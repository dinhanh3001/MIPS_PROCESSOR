`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:03:15 PM
// Design Name: 
// Module Name: ALU_CONTROL
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

module ALU_CONTROL(funct, alu_op, alu_control);
    input  [5:0] funct;
    input  [1:0] alu_op;
    output reg [3:0] alu_control;

    always @(*) begin
        casex ({alu_op, funct})  // 
            8'b00xxxxxx: alu_control = 4'b0010; // LW/SW -> add
            8'b01xxxxxx: alu_control = 4'b0110; // beq -> sub
            8'b10_100000: alu_control = 4'b0010; // R-type add
            8'b10_100010: alu_control = 4'b0110; // R-type sub
            8'b10_100100: alu_control = 4'b0000; // R-type and
            8'b10_100101: alu_control = 4'b0001; // R-type or
            8'b10_101010: alu_control = 4'b0111; // R-type slt
            default: alu_control = 4'b0000; // invalid
        endcase
    end
endmodule
