`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:03:43 PM
// Design Name: 
// Module Name: CONTROL_UNIT
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

module CONTROL_UNIT(opcode, regdst, branch,memread,memtoreg, alu_op, memwrite, alusrc, regwrite); 
    input [5:0] opcode; 
	 output reg [1:0] alu_op; 
	 output reg regdst, branch,memread,memtoreg, memwrite, alusrc, regwrite; 
	always @(*) begin
    case (opcode)
        6'b000000: begin // R-type
            regdst   = 1;
            alusrc   = 0;
            memtoreg = 0;
            regwrite = 1;
            memread  = 0;
            memwrite = 0;
            branch   = 0;
            alu_op   = 2'b10;
        end
        6'b100011: begin // LW
            regdst   = 0;
            alusrc   = 1;
            memtoreg = 1;
            regwrite = 1;
            memread  = 1;
            memwrite = 0;
            branch   = 0;
            alu_op   = 2'b00;
        end
        6'b101011: begin // SW
            regdst   = 0;    // don't care
            alusrc   = 1;
            memtoreg = 0;    // don't care
            regwrite = 0;
            memread  = 0;
            memwrite = 1;
            branch   = 0;
            alu_op   = 2'b00;
        end
        6'b000100: begin // BEQ
            regdst   = 0;    // don't care
            alusrc   = 0;
            memtoreg = 0;    // don't care
            regwrite = 0;
            memread  = 0;
            memwrite = 0;
            branch   = 1;
            alu_op   = 2'b01;
        end
        default: begin
            regdst   = 0;
            alusrc   = 0;
            memtoreg = 0;
            regwrite = 0;
            memread  = 0;
            memwrite = 0;
            branch   = 0;
            alu_op   = 2'b00;
        end
    endcase
end

endmodule 
