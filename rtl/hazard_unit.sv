module hazard_unit  (input logic [4:0] rs1_D,
		     input logic [4:0] rs2_D,
		     input logic [4:0] Rd_E,
		     input logic [1:0] resultsrc_E,
		     input logic  pcsrc_E,
		     output logic stall_F,
		     output logic stall_D,
		     output logic flush_D,
		     output logic flush_E);

    always_comb
	if ((resultsrc_E == 2'b01) & ((rs1_D == Rd_E) | (rs2_D == Rd_E)))  begin
		stall_F = 1'b1;
		stall_D = 1'b1;
		flush_D = 1'b0;
		flush_E = 1'b1;
	end
	else if (pcsrc_E) begin
		stall_F = 1'b0;
		stall_D = 1'b0;
		flush_D = 1'b1;
		flush_E = 1'b1;
		end
	else begin
		stall_F = 1'b0;
		stall_D = 1'b0;
		flush_D = 1'b0;
		flush_E = 1'b0;
	     end


endmodule	    
		    
