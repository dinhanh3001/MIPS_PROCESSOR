`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 03:56:46 PM
// Design Name: 
// Module Name: DATA_MEMORY
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

module DATA_MEMORY (addr, write_data, mem_write, mem_read, clk, read_data);
    input  [31:0] addr; 
    input  [31:0] write_data;
    input         mem_write, mem_read; 
    input         clk;
    output reg [31:0] read_data; 


    reg [31:0] ram[0:31];  // 32 words, m?i word 32-bit
     integer i; 
	 initial begin
    for (i = 0; i < 32; i = i + 1) begin
        ram[i] = 32'b0;
    end
    end
    // Ghi d? li?u vào RAM t?i c?nh lên c?a xung nh?p
    always @(posedge clk) begin
        if (mem_write)
            ram[addr[4:0]] <= write_data;
    end

    // ??c d? li?u (combinational)
    always @(*) begin
        if (mem_read)
            read_data = ram[addr[4:0]];
        else
            read_data = 32'bz;  // ho?c 32'b0 n?u không dùng bus 3 tr?ng thái
    end

endmodule
