`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:04:42 PM
// Design Name: 
// Module Name: MIPS
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
module MIPS(clk, reset);
   input clk, reset; 
   
	wire [31:0] pc_out_wire,instruction_wire,read_data1_wire, read_data2_wire, sign_out_wire, out_mux_alu, out_shifter, adder_result_wire,
	result_branch_wire, out_mux_branch, alu_result_wire, read_data_wire, out_mux_data_mem;  
	
	wire [4:0] mux_register_out; 
	
	wire regdst_wire, branch_wire,memread_wire,memtoreg_wire,  memwrite_wire, alusrc_wire, regwrite_wire, zero_wire, out_branch_wire;
	wire [1:0] alu_op_wire; 
	
	wire [3:0] alu_control_wire; 
	// pc 
	PC program_counter(.pc_in(out_mux_branch), .pc_out(pc_out_wire),.clk(clk), .reset(reset)); // xong 
	// pc + 4
	
	ADDER_4 pc_4(.pc_in(pc_out_wire), .adder_result(adder_result_wire)); 
	
	// khoi instruction memory 
	
	IMEM instruction_memmory(.addr(pc_out_wire), .instruction(instruction_wire));// xong 
	
	// khoi chon truoc register file 
	MUX_REGISTER mux(.a(instruction_wire[20:16]),.b(instruction_wire[15:11]),.out(mux_register_out),.regdst(regdst_wire)); // xong 
	
	// khoi register file 
	
	REGISTER_FILE reg_file(.read_1(instruction_wire[25:21]), .read_2(instruction_wire[20:16]),.regwrite(regwrite_wire), 
	.read_data1(read_data1_wire), .read_data2(read_data2_wire), .write_addr(mux_register_out), .clk(clk), .write_data(out_mux_data_mem)); // xong 
	
	// khoi sign_extend 
	
	SIGN_EXTEND sign(.sign_in(instruction_wire[15:0]), .sign_out(sign_out_wire));//xong       
	
	// khoi alu control 
	 ALU_CONTROL alu(.funct(instruction_wire[5:0]), .alu_op(alu_op_wire), .alu_control( alu_control_wire));// xong 
	
	// khoi control unit 
	CONTROL_UNIT khoi_control(.opcode(instruction_wire[31:26]), .regdst(regdst_wire), .branch(branch_wire),.memread(memread_wire),
	.memtoreg(memtoreg_wire), .alu_op(alu_op_wire), .memwrite(memwrite_wire), .alusrc(alusrc_wire), .regwrite(regwrite_wire));// xong 
	
	// khoi ALU 
	ALU khoi_alu(.alu_control( alu_control_wire), .a(read_data1_wire),.b(out_mux_alu),.alu_result(alu_result_wire), .zero(zero_wire));//chua 
	
	// mux alu 
	MUX_ALU khoi_mux_alu(.a(read_data2_wire),.b(sign_out_wire), .out(out_mux_alu),.alusrc(alusrc_wire));// xong  
	
	// khoi and_branch 
	 AND_BRANCH khoi_and(.a(branch_wire),.b(zero_wire), .out(out_branch_wire)); // xong 
	 
	 // mux branch 
	 MUX_BRANCH khoi_mux_branch(.a(adder_result_wire),.b(result_branch_wire),.out(out_mux_branch),.select(out_branch_wire));  // xong 
	 
	 
	 // shifter 
	 SHIFTER dich_2(.in(sign_out_wire), .out(out_shifter)); // xong 
	 
	 // khoi cong sau shifter 
	 
	ADDER_BRANCH add_branch(.a(adder_result_wire),.b(out_shifter),.result(result_branch_wire));// xong 
	
	// khoi data memory 
	DATA_MEMORY ram(.addr(alu_result_wire), .write_data(read_data2_wire), .mem_write(memwrite_wire), 
	.mem_read(memread_wire), .clk(clk), .read_data(read_data_wire));// xong 
	// mux sau data memmory 
	 MUX_DATA_MEM mux_data(.a(alu_result_wire),.b(read_data_wire),.out(out_mux_data_mem),.memtoreg(memtoreg_wire)); // xong 
	 
endmodule 
