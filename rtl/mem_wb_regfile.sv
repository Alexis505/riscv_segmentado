module mem_wb_regfile (input logic clk,
		       input logic regwrite_M,
		       input logic [1:0] result_src_M,
		       input logic [31:0] aluresult_M,
		       input logic [31:0] readData_M,
		       input logic [4:0] Rd_M,
		       input logic [31:0] pcplus4_M,
		       output logic regwrite_W,
		       output logic [1:0] result_src_W,
		       output logic [31:0] aluresult_W,
		       output logic [31:0] readData_W,
		       output logic [4:0] Rd_W,
		       output logic [31:0] pcplus4_W);


    always_ff @(posedge clk)
	begin
		regwrite_W   <= regwrite_M;
		result_src_W <= result_src_M;
		aluresult_W  <= aluresult_M;
		readData_W   <= readData_M;
		Rd_W         <= Rd_M;
		pcplus4_W    <= pcplus4_M;
	end

endmodule  
