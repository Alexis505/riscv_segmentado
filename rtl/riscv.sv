module riscv (input logic clk,
	      input logic reset,
	      input logic [31:0] instr_F,
	      input logic [31:0] readdata_M,
	      output logic memwrite_M,
	      output logic [31:0] pc_F, 
	      //la senal alu_result es salida cuando esta establece
	      //la direccion en memoria de un dato data_address
	      output logic [31:0] aluresult_M,
	      output logic [31:0] writedata_M);

//la senal de pc o program counter va a la memoria de instrucciones
// las senales de data_adr y write_data van hacia la memoria de datos
//el controlador debe recibir solo como entrada la instrucciones para 
//decodificarla
logic regwrite_D;
logic [1:0] immsrc_D;
logic alusrc_D;
logic [2:0] alucontrol_D;
logic [1:0] resultsrc_D;
logic [1:0] pcsrc_D; //no aparece en el libro en modulo principal
logic [31:0] pcplus4_F;
logic [31:0] pcplus4_D;
logic stall_D;
logic flush_D;
logic [31:0] instr_D;
logic [31:0] pc_D;
logic memwrite_D;
logic jump_D;
logic branch_D;
logic pcsrc_E;
logic zero_E;
logic branch_E;
logic jump_E;

adder adder_pc(pc_F,32'b100,pcplus4_F);

if_id_regfile if_id_inst(clk, stall_D, flush_D, instr_F, pc_F, pcplus4_F, instr_D, pc_D, pcplus4_D);

controller controller_1 (instr_D[6:0], instr_D[14:12], instr_D[30], regwrite_D, resultsrc_D, memwrite_D, jump_D, branch_D, alucontrol_D, alusrc_D, immsrc_D, pcsrc_E, zero_E, branch_E, jump_E);

datapath dp(clk, reset, resultsrc_D, alucontrol_D, alusrc_D, immsrc_D, regwrite_D, memwrite_D, jump_D, branch_D, instr_D, readdata_M, pc_F, aluresult_M, writedata_M, stall_D, flush_D, pcplus4_F, pcsrc_E, zero_E, branch_E, jump_E, pc_D, pcplus4_D, memwrite_M);

endmodule

