# MIPS_PROCESSOR-
MIPS microprocessor with 8 basic instructions ADD, SUB, AND, OR, SLT, LW, SW, BEQ
# DATAPATHS: 
<img width="668" height="488" alt="image" src="https://github.com/user-attachments/assets/d7d3ebd3-6b01-4f5d-95cd-5d493196aa27" />


<img width="755" height="884" alt="image" src="https://github.com/user-attachments/assets/d1f2667c-675d-45e2-9ec2-fdc26e736fdb" />

# DESIGN CONVENTIONS:
- COMBINATIONAL CIRCUIT: ALU/ADD/MUX
- SEQUENTIAL CIRCUIT: instruction/data memories and registers
- Control signal
- Data signal
# OVERVIEW OF INSTRUCTIONS TO CONSIDER:
- Memory reference instruction group (lw and sw): lw $s1, 20($s2)
Fetch instruction → Read a register → Use ALU → Access memory to read/write data → Write
data to register
- Logic and arithmetic instruction group (add, sub, AND, OR, and slt): add $t0, $s1, $s2
Fetch instruction → Read two registers → Use ALU → Write data to register
- Branch instruction group (beq): beq $s1, $s2, Exit (PC = Exit: or PC = PC + 4)
Fetch instruction → Read two registers → Use ALU → Go to next instruction address based on
compare result
# MIPS COMMAND EXECUTION PROCESS (5 STEPS)
<img width="1035" height="415" alt="image" src="https://github.com/user-attachments/assets/326e4e5b-e9e3-47aa-910f-2a9df867f211" />

- Instruction fetch phase: uses PC register to fetch instruction from memory and then increments by 4 to get the address of the next instruction. (This stage requires PC module, INSTRUCTION MEMORY, 4 adder (32 bit)
- Instruction decoding stage: Get the data content in the instruction field (read opcode to determine the instruction type and length of each field in the machine code). This stage requires designing the MUX, REGISTER FILE, SIGN-EXTEND blocks.
- Calculation stage (ALU)
after determining the instruction type and the value taken from the corresponding register will be put into the calculation block.
Arithmetic instructions (eg: add, sub), Logic (eg: and, or): ALU calculates the final result
Instructions working with memory (eg: lw, sw): ALU is used to calculate the memory address
Jump/branch instructions (eg: bne, beq): ALU performs comparison of values ​​on the register and calculates the destination address
the ALU control block is designed based on 6 bits of the opcode field and 2 bits are generated from the CONTROL block (will be mentioned later)
<img width="433" height="471" alt="image" src="https://github.com/user-attachments/assets/65b2e34b-81ef-4aa5-a6c9-124e826bca58" />

- Memory access phase:
Only Load and Store instructions need to perform operations in this phase:
Use the memory address calculated in the ALU phase
Read data out or write data into the data memory
All other instructions will be free in this phase
<img width="1033" height="443" alt="image" src="https://github.com/user-attachments/assets/d5de3cce-565a-4dcd-a6cf-87522179c9ee" />

- Result storage phase:
Instructions that write the results of operations to registers:
Examples: arithmetic, logic, shifts, load, set-less-than
Need destination register index and calculation result
Instructions that do not write results such as: store, branch, jump:
No result writing
➔These instructions will be free in this phase
<img width="1019" height="479" alt="image" src="https://github.com/user-attachments/assets/f1d56582-e331-4055-81cc-b8423a65d45d" />

# Control block with the following signals:
<img width="655" height="389" alt="image" src="https://github.com/user-attachments/assets/9f98fe89-ddaa-4d5b-96f1-c0fda94df18b" />

RegDst is used to select the destination register for the write operation:
- RegDst = 0: Bits 16:20 are selected (rt - for loadword instructions)
- RegDst = 1: Bits 11:15 are selected (rd - for the remaining instructions such as add, sub, and, or, slt)
- The sw and beq instructions do not use this value
<img width="579" height="398" alt="image" src="https://github.com/user-attachments/assets/4bb500d0-df9b-4298-855d-08ffed4eb14f" />

RegWrite is used to allow writing operations to the register block:
- RegWrite = 0: The register block has only read function (for sw and beq instructions)
- RegWrite = 1: The register block can perform read and write functions. The register to be written is the register whose index is entered from the “Write register” port and the data to be written to this register is taken from the “Write data” port (for the remaining instructions)

<img width="627" height="392" alt="image" src="https://github.com/user-attachments/assets/52f2fbe9-d6fa-45f1-add3-418a1deb1064" />

ALUSrc is used to select the second input for the ALU block:
- ALUSrc = 0: The second input for the ALU comes from “Read data 2” of the “Registers” block (for the add, sub, and, or, slt, beq instructions)
- ALUSrc = 1: The second input for the ALU comes from the output of the “Signextend” block (for the remaining instructions such as lw and sw)

<img width="587" height="387" alt="image" src="https://github.com/user-attachments/assets/56b7ce1e-e037-4a25-ada8-f936a1b3963b" />

Branch is used to combine (AND) with the Zero value of the ALU to select the value to be loaded into the PC register:
- Branch = 0: The value of the PC comes from the Add block (4) PC = PC + 4 (for the instructions add, sub, and, or, slt, lw, sw)
- Branch = 1: Depends on the value of the Zero of the ALU block (for the beq instruction).
If Zero = 0: The value of the PC comes from the Add block (4) PC = PC + 4
If Zero = 1: The value of the PC comes from the Add block (Shift left 2) PC = PC + 4 + Lable
<img width="602" height="412" alt="image" src="https://github.com/user-attachments/assets/f8e6debb-fcb6-4c64-8ead-d607e9d2404f" />

MemRead is used to allow reading operations from the Data memory block:
- MemRead = 1: The “Data memory” block performs the function of reading data. The data address to be read is entered from the “Address” port and the read content is
output to the “Read data” port (for the lw command)
- MemRead = 0: The “Data memory” block does not perform the function of reading data (for the remaining commands)

<img width="618" height="402" alt="image" src="https://github.com/user-attachments/assets/2011a1b5-3a7e-4241-add1-db44d07330f1" />

MemWrite is used to allow writing operations to the Data memory block:
- MemWrite = 1: The “Data memory” block performs the function of writing data. The data address to be written is entered from the “Address” port and the content to be written is taken from the “Write data” port (for sw command)
- MemWrite = 0: The “Data memory” block does not perform the function of writing data (for the remaining commands)
<img width="615" height="428" alt="image" src="https://github.com/user-attachments/assets/cdcfc4ac-fc5f-47f6-9e3f-6ae01e09d1f6" />

MemtoReg is used to select the value to be input into the Write data port of the Registers block:
- MemtoReg = 0: The value to be input into the “Write data” port comes from the ALU (for the add, sub, and, or, slt instructions)
- MemtoReg = 1: The value to be input into the “Write data” port comes from the “Data memory” block (for the lw instruction)- The sw and beq instructions do not use this value
# CHECK THE DESIGN OPERATION.
- To test the processor operation, we initialize the machine code into the INSTRUCTION MEMMORY block and initialize the data in the REGISTER_FILE block.
  
  <img width="926" height="473" alt="image" src="https://github.com/user-attachments/assets/62f4c52d-f0d9-42b2-b99e-93ee1f4e4fab" />

  <img width="860" height="474" alt="image" src="https://github.com/user-attachments/assets/72d52395-520c-424d-bd43-141e537efdb2" />
- simulation results using testbench.

<img width="1900" height="849" alt="image" src="https://github.com/user-attachments/assets/c3d95068-8865-4034-ac67-b9541b36650e" />

- To check if the command is executed correctly or not, we just need to check the REGISTER FILE block for R format commands and check the DATA_MEMORY block for LW, SW commands;

for jump commands, we check the PC register.
For example: the first command is ADD t1, t2, t3; Register t2 is register[10] and t3 is register[11] which has been initialized to the value of 15 and 8, which adds up to 17 (as shown in the picture)







