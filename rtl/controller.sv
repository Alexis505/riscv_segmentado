module controller (input logic [6:0] op_code,
		   input logic [2:0] funct_3,
		   input logic funct_7,
		   output logic regwrite_D,
	           output logic [1:0] resultsrc_D,
		   output logic memwrite_D,
		   output logic jump_D,
		   output logic branch_D,
		   output logic [2:0] alucontrol_D,
		   output logic alusrc_D,
		   output logic [1:0] immsrc_D
	   	   output logic pcsrc_E,
		   input logic zero_E,
		   input logic branch_E,
	   	   input logic jump_E);

logic [1:0] alu_op;
//movemos jump como salida en el segmentado porque jump debe llegar a id_ex_regfile
//logic jump;

//zero no entra a main decoder porque se usa aqui mismo dentro de controller
maindec md(op_code, resultsrc_D, memwrite_D, branch_D, alusrc_D, regwrite_D, jump_D, immsrc_D, alu_op);

aludec ad(op_code[5], funct_3, funct_7, alu_op, alucontrol_D);

assign pcsrc_E = ((zero_E & branch_E) | jump_E);

endmodule





