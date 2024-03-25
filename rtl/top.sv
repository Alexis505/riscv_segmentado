module top (input logic  clk, reset,
	    output logic  [31:0] writedata_M, 
	    output logic  [31:0] data_adr,
	    output logic memwrite_M);


logic [31:0] pc_F, instr_F, readdata_M;

//instanciamos processor and memories
//data_adr = aluresult_M en el modulo principal de riscv
riscv rv_segmentado(clk, reset, instr_F, readdata_M, memwrite_M, pc_F,data_adr, writedata_M);

imem imem_inst(pc_F,instr_F);

dmem dmem_inst (clk, memwrite_M, data_adr, writedata_M, readdata_M);

endmodule



