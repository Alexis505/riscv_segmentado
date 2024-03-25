module if_id_regfile (input logic clk,
		      input logic stall_D,
		      input logic flush_D,
		      input logic  [31:0] instr_F,
		      input logic  [31:0] pc_F,
		      input logic  [31:0] pcplus4_F,
		      output logic [31:0] instr_D,
		      output logic [31:0] pc_D,
		      output logic [31:0] pcplus4_D);

    always_ff @(posedge clk)
	if(stall_D)
	begin
	    instr_D <= instr_D;
	    pc_D <= pc_D;
	    pcplus4_D <= pcplus4_D;
	end
	else if (flush_D)
	begin
	    instr_D <= 32'b0;
	    pc_D    <= 32'b0;
	    pcplus4_D <= 32'b0;
	end
	else
	begin
	    instr_D <= instr_F;
	    pc_D  <= pc_F;
	    pcplus4_D <= pcplus4_F;
	end

endmodule





