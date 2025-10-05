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

// khoi pc 

module PC(pc_in, pc_out, clk, reset);
    input [31:0] pc_in;
    input clk, reset;
    output reg [31:0] pc_out;
    initial begin
        pc_out = 32'b0; // Khởi tạo PC về 0
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            pc_out <= 32'b0;
        else
            pc_out <= pc_in;
    end
endmodule

module IMEM (addr, instruction);
    input [31:0] addr;
    output [31:0] instruction;
    reg [31:0] I_Mem [31:0];
	       integer i;
    initial begin
  
        for (i = 0; i < 32; i = i + 1) begin
            I_Mem[i] = 32'b0; // Khởi tạo tất cả về 0 (nop)
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
// khoi register file 
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
        if (regwrite == 1'b1 && write_addr != 5'b0) // Ngăn ghi vào $zero
            register[write_addr] <= write_data;
    end
    assign read_data1 = register[read_1];
    assign read_data2 = register[read_2];
endmodule
 
 // khoi alu 
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
// data memory 
module DATA_MEMORY (addr, write_data, mem_write, mem_read, clk, read_data);
    input  [31:0] addr; 
    input  [31:0] write_data;
    input         mem_write, mem_read; 
    input         clk;
    output reg [31:0] read_data; 


    reg [31:0] ram[0:31];  // 32 words, mỗi word 32-bit
     integer i; 
	 initial begin
    for (i = 0; i < 32; i = i + 1) begin
        ram[i] = 32'b0;
    end
    end
    // Ghi dữ liệu vào RAM tại cạnh lên của xung nhịp
    always @(posedge clk) begin
        if (mem_write)
            ram[addr[4:0]] <= write_data;
    end

    // Đọc dữ liệu (combinational)
    always @(*) begin
        if (mem_read)
            read_data = ram[addr[4:0]];
        else
            read_data = 32'bz;  // hoặc 32'b0 nếu không dùng bus 3 trạng thái
    end

endmodule

		 
// addder 4 
module ADDER_4(pc_in, adder_result); 
     input [31:0] pc_in; 
	  output  [31:0] adder_result; 
	 
	 assign adder_result = pc_in + 4; 
endmodule 


// shifter 2 
module SHIFTER(in, out); 
    input [31:0] in; 
	 output [31:0] out; 
	 
assign out = in << 2; 
endmodule 

// adder branch 

module ADDER_BRANCH(a,b,result); 
   input [31:0] a,b; 
	output [31:0] result ; 
	
assign result = a +b; 
endmodule 

// mux 
module MUX_REGISTER(a,b,out,regdst); 
      input [4:0] a, b; 
		input regdst; 
		output [4:0] out; 
assign out = (regdst ==1'b0) ? a : b; 
endmodule 


// mux data memory 
module MUX_DATA_MEM(a,b,out,memtoreg);
     input [31:0] a,b; 
	  output [31:0] out; 
	  input memtoreg; 
	  
assign out = (memtoreg ==1'b0) ? a: b; 
endmodule 

// mux branch 

module MUX_BRANCH(a,b,out,select);
     input [31:0] a,b; 
	  output [31:0] out; 
	  input select; 

assign out = (select ==1'b0) ? a: b; 
endmodule
// mux alu 
module MUX_ALU(a,b, out,alusrc); 
   input [31:0] a,b; 
	output [31:0] out; 
	input alusrc; 
assign out = (alusrc==1'b0) ? a :b; 
endmodule 

// sign- extend 
module SIGN_EXTEND(sign_in, sign_out); 
    input [15:0] sign_in; 
	 output [31:0] sign_out; 
assign sign_out = {{16{sign_in[15]}},sign_in}; 
endmodule 
// and _branch 
module AND_BRANCH(a,b, out); 
   input a,b; 
	output out; 
assign out = a&b; 
endmodule 



// ALU CONTROL 
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


// control unit 
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
            regdst   = 0;    // don’t care
            alusrc   = 1;
            memtoreg = 0;    // don’t care
            regwrite = 0;
            memread  = 0;
            memwrite = 1;
            branch   = 0;
            alu_op   = 2'b00;
        end
        6'b000100: begin // BEQ
            regdst   = 0;    // don’t care
            alusrc   = 0;
            memtoreg = 0;    // don’t care
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
