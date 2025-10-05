`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:54:11 PM
// Design Name: 
// Module Name: IMEM
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


module IMEM (addr, instruction);
    input [31:0] addr;
    output [31:0] instruction;
    reg [31:0] I_Mem [31:0];
	       integer i;
    initial begin
  
        for (i = 0; i < 32; i = i + 1) begin
            I_Mem[i] = 32'b0; // Kh?i t?o t?t c? v? 0 (nop)
        end
	  I_Mem[0]  = 32'b00000001010010110100100000100000; // add $t1, $t2, $t3
	  I_Mem[4]  = 32'b00000001100101000101000000100010; // sub $t2, $t4, $s4
	  I_Mem[8]  = 32'b00000001010010110100100000100100; // and $t1, $t2, $t3
	  I_Mem[12] = 32'b00000010010100111000100000100101; // or $s1, $s2, $s3
	  I_Mem[16] = 32'b00000010001100111001000000101010; // slt $s2, $s1, $t1
	  I_Mem[20] = 32'b10101110100101010000000000000000; // sw $s5, 0($s4)
	  I_Mem[24] = 32'b10001110100010100000000000000000; // lw $t2, 0($s4)
	  I_Mem[28] = 32'b00010000000000000000000000000000; // beq $zero, $zero, 0
    end
    assign instruction = I_Mem[addr[5:0]];
endmodule
