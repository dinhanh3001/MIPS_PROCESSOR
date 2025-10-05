module testbench; 

    reg clk, reset;
	 
    initial begin
	     reset = 1'b0; 
        clk = 0;
        forever #5 clk = ~clk; // Xung nhịp 10ns
    end
    MIPS mips_inst(.clk(clk));
    initial begin
        #100 ; $stop; 
    end

endmodule 