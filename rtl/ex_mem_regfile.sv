module ex_mem_regfile (input logic clk,
		       input logic regwrite_E,
		       input logic [1:0] result_src_E,
		       input logic memwrite_E,
		       input logic [31:0] aluresult_E,
		       input logic [31:0] writeData_E,
		       input logic [4:0]  Rd_E,
		       input logic [31:0] pcplus4_E,
		       output logic regwrite_M,
		       output logic [1:0] result_src_M,
		       output logic memwrite_M,
		       output logic [31:0] aluresult_M,
		       output logic [31:0] writeData_M,
		       output logic [4:0] Rd_M,
		       output logic [31:0] pcplus4_M);


    always_ff @(posedge clk)
	begin
		regwrite_M <= regwrite_E;
		result_src_M <= result_src_E;
		memwrite_M  <= memwrite_E;
		aluresult_M <= aluresult_E;
		writeData_M <= writeData_E;
		Rd_M	    <= Rd_E;
		pcplus4_M   <= pcplus4_E;
	end

endmodule	  
