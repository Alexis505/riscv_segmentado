module id_ex_regfile (input logic clk,
		      input logic flush_E,
		      input logic regwrite_D,
		      input logic [1:0] result_src_D,
		      input logic memwrite_D,
		      input logic jump_D,
		      input logic branch_D,
		      input logic [2:0] alucontrol_D,
		      input logic alusrc_D,
		      input logic [1:0] immsrc_D,
		      input logic [31:0] rd1_D,
		      input logic [31:0] rd2_D,
		      input logic [31:0] pc_D,
		      input logic [4:0] rs1_D,
		      input logic [4:0] rs2_D,
		      input logic [4:0] Rd_D,
		      input logic [31:0] immext_D,
		      input logic [31:0] pcplus4_D,
		      output logic regwrite_E,
		      output logic [1:0] result_src_E,
		      output logic memwrite_E,
		      output logic jump_E,
		      output logic branch_E,
		      output logic [2:0] alucontrol_E,
		      output logic alusrc_E,
	              output logic [31:0] rd1_E,
		      output logic [31:0] rd2_E,
		      output logic [31:0] pc_E,
		      output logic [4:0]  rs1_E,
		      output logic [4:0]  rs2_E,
		      //Rd_* is for register destiny. not confuse with read data
		      output logic [4:0]  Rd_E, 
		      output logic [31:0] immext_E,
		      output logic [31:0] pcplus4_E);

	
    always_ff @(posedge clk)
	if(flush_E) begin
		regwrite_E   <= 0;
		result_src_E <= 2'b0;
		memwrite_E   <= 0;
		jump_E       <= 0;
		branch_E     <= 0;
		alucontrol_E <= 3'b000;
		alusrc_E     <= 0;
		rd1_E	     <= 32'b0;
		rd2_E	     <= 32'b0;
		pc_E 	     <= 32'b0;
		rs1_E	     <= 32'b0;
		rs2_E	     <= 32'b0;
	        Rd_E	     <= 32'b0;
		immext_E     <= 32'b0;
		pcplus4_E    <= 32'b0;
		end
	else begin
		regwrite_E   <= regwrite_D;
		result_src_E <= result_src_D;
		memwrite_E   <= memwrite_D;
		jump_E 	     <= jump_D;
		branch_E     <= branch_D;
		alucontrol_E <= alucontrol_D;
		alusrc_E     <= alusrc_D;
		rd1_E	     <= rd1_D;
		rd2_E	     <= rd2_D;
		pc_E	     <= pc_D;	
		rs1_E	     <= rs1_D;
		rs2_E	     <= rs2_D;	
		Rd_E	     <= Rd_D;
		immext_E     <= immext_D;
		pcplus4_E    <= pcplus4_D;
	     end

endmodule
		







		      
