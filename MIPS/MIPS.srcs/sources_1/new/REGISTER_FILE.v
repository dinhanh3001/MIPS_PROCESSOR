`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:55:33 PM
// Design Name: 
// Module Name: REGISTER_FILE
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


module REGISTER_FILE(read_1, read_2, regwrite, read_data1, read_data2, write_addr, clk, write_data);
    input [4:0] read_1, read_2, write_addr;
    input clk, regwrite;
    input [31:0] write_data;
    output [31:0] read_data1, read_data2;
    reg [31:0] register [31:0];
	 integer i;
    initial begin
        
        register[0] = 0; 
	register[1] = 2; 
	register[2] = 4; 
        register[3] = 8; 
	register[4] = 16; 
	register[5] = 10;
        register[6] = 11; 
	register[7] = 12; 
	register[8] = 13;
        register[9] = 14; 
	register[10] = 15; 
	register[11] = 8;
        register[12] = 9; 
	register[13] = 18; 
	register[14] = 19;
        register[15] = 20; 
	register[16] = 21; 
	register[17] = 22; 
        register[18] = 29; 
	register[19] = 30; 
	register[20] = 32;
        register[21] = 33; 
	register[22] = 34; 
	register[23] = 40;
        register[24] = 50; 
	register[25] = 45; 
	register[26] = 34;
        register[27] = 39; 
	register[28] = 59; 
	register[29] = 37;
	register[30] = 100; 
	register[31] = 20;
    end
	 
    always @(posedge clk)
    begin
        if (regwrite == 1'b1 && write_addr != 5'b0) // Ng?n ghi vào $zero
            register[write_addr] <= write_data;
    end
    assign read_data1 = register[read_1];
    assign read_data2 = register[read_2];
endmodule
 
