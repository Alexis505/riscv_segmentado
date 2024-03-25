module datapath (input logic clk,
		 input logic reset,
		 input logic [1:0] resultsrc_D,
		 input logic [2:0] alucontrol_D,
		 input logic alusrc_D,
		 input logic [1:0] immsrc_D,
		 input logic regwrite_D,
		 input logic memwrite_D,
		 input logic jump_D,
		 input logic branch_D,
		 input logic [31:0] instr_D,
		 input logic [31:0] readdata_M,
		 output logic [31:0] pc_F,
		 output logic [31:0] aluresult_M,
		 output logic [31:0] writedata_M,
		 output logic stall_D,
		 output logic flush_D,
		 input logic [31:0] pcplus4_F,
	 	 input logic pcsrc_E,
	 	 output logic zero_E,
	 	 output logic branch_E,
	 	 output logic jump_E,
	 	 input logic [31:0] pc_D,
		 input logic [31:0] pcplus4_D,
	 	 output logic [31:0] memwrite_M);


//la forma de escribir un codigo complejo como esto es ir por partes asi como
//esta en el esquematico 
logic [31:0] pc_next;
logic [31:0] pc_plus4;
logic [31:0] pc_target;
logic [31:0] result;


//logica que se genera en decode stage
//el wire  immext_D es la extension de los bits 31:7 a un vector de 32 bits
logic [31:0] immext_D;

//agregamos senales para atender el procesador segmentado
//logic para hacer stall y flush a los regfiles y forwarding
logic stall_F; //stall fetch
logic flush_E; //flush execution regfile
logic [1:0] forwardA_E;
logic [1:0] forwardB_E;

//logic que sale del regfile read_data_{1,2}
logic [31:0] rd1_D;
logic [31:0] rd2_D;

//logic para wires que salen de id_ex_regfile
logic regwrite_E;
logic [1:0] resultsrc_E;
logic memwrite_E;
logic [2:0] alucontrol_E;
logic alusrc_E;
logic [31:0] rd1_E;
logic [31:0] rd2_E;
logic [31:0] pc_E;
logic [31:0] rs1_E;
logic [31:0] rs2_E;
logic [31:0] Rd_E;
logic [31:0] immext_E;
logic [31:0] pcplus4_E;

//wires para alu
logic [31:0] srcA_E;
logic [31:0] srcB_E;
logic [31:0] writedata_E;
//logica que se genera en ex stage
logic [31:0] aluresult_E;
logic [31:0] pctarget_E;

//logic para wires que salen de ex_mem_regfile
logic regwrite_M;
logic [1:0] resultsrc_M;
logic [4:0] Rd_M;
logic [31:0] pcplus4_M;

//logic para wires que salen de mem_wb_regfile
logic regwrite_W;
logic [1:0] resultsrc_W;
logic [31:0] aluresult_W;
logic [31:0] readdata_W;
logic [4:0] Rd_W;
logic [31:0] pcplus4_W;
//esta senal sale de un multiplexor que recibe aluresult readdata y pcplus4;
logic [31:0] result_W;

mux2 #(32) pc_mux(pcplus4_F, pctarget_E, pcsrc_E, pc_next);
flop #(32) flop_pc(clk,reset,stall_F,pc_next,pc_F);

//logica para el archivo de registros
//recordar que en vez de instr[11:7] usamos Rd_W en el segmentado
regfile regfile_instance(clk,regwrite_W,instr_D[19:15],instr_D[24:20],Rd_W,result_W,rd1_D,rd2_D);
extend ext_inst(instr_D[31:7], immsrc_D, immext_D);

//instanciamos hazard unit
hazard_unit hazard_instance (instr_D[19:15], instr_D[24:20], Rd_E, resultsrc_E, pcsrc_E, stall_F, stall_D, flush_D, flush_E);

//instanciamos id_exe_regfile
id_ex_regfile id_ex_inst(clk,flush_E, regwrite_D, resultsrc_D, memwrite_D, jump_D, branch_D, alucontrol_D, alusrc_D, immsrc_D, rd1_D, rd2_D, pc_D, instr_D[19:15], instr_D[24:20], instr_D[11:7], immext_D, pcplus4_D, regwrite_E, resultsrc_E, memwrite_E, jump_E, branch_E, alucontrol_E,alusrc_E, rd1_E, rd2_E, pc_E, rs1_E, rs2_E, Rd_E, immext_E, pcplus4_E);

//logica de calculo de branch
adder pcadd_branch(pc_E, immext_E, pctarget_E);
//logica de alu 
mux3 #(32) srcA_mux(rd1_E, result_W, aluresult_M, forwardA_E, srcA_E);
mux3 #(32) srcb_mux(rd2_E, result_W, aluresult_M, forwardB_E, writedata_E);
mux2 #(32) srcB_mux(writedata_E, immext_E, alusrc_E,srcB_E);
alu        alu_inst(srcA_E, srcB_E, alucontrol_E,aluresult_E,zero_E);

forwarding_unit forwarding_inst(rs1_E, rs2_E, aluresult_M, regwrite_M, Rd_M, regwrite_W, Rd_W, forwardA_E, forwardB_E);

//instanciar regfile ex_mem_regfile
ex_mem_regfile ex_mem_instance(clk, regwrite_E, resultsrc_E, memwrite_E, aluresult_E, writedata_E, Rd_E, pcplus4_E, regwrite_M, resultsrc_M, memwrite_M, aluresult_M, writedata_M, Rd_M, pcplus4_M);

//instanciar regfile mem_wb_regfile
mem_wb_regfile mem_wb_inst(clk, regwrite_M, resultsrc_M, aluresult_M,readdata_M, Rd_M, pcplus4_M, regwrite_W, resultsrc_W, aluresult_W, readdata_W, Rd_W, pcplus4_W);

//mux3a1 para result_W
mux3 #(32) result_mux(aluresult_W,readdata_W,pcplus4_W,resultsrc_W, result_W);


endmodule






