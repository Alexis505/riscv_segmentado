module maindec (input [6:0] op_code,
		output logic [1:0] result_src,
		output logic mem_write,
		output logic branch,
		output logic alu_src,
		output logic reg_write,
		output logic jump,
		output logic [1:0] imm_src, 
		output logic [1:0]alu_op);

logic [10:0] controls;

assign {reg_write, imm_src, alu_src, mem_write, result_src, branch, alu_op, jump} = controls;

always_comb
	case(op_code)
	//reg_write-imm_src-alu_src-mem_write-result_src-branch-alu_op-jump
	    7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // lw
	    7'b0100011: controls = 11'b0_01_1_1_00_0_00_0; // sw
	    7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0; // R–type
	    7'b1100011: controls = 11'b0_10_0_0_00_1_01_0; // beq
	    7'b0010011: controls = 11'b1_00_1_0_00_0_10_0; // I–type ALU
	    7'b1101111: controls = 11'b1_11_0_0_10_0_00_1; // jal
	    7'b0000000: controls = 11'b0_00_0_0_00_0_00_0; // nops
	    default:    controls = 11'bx_xx_x_x_xx_x_xx_x; // ???
	endcase

endmodule
