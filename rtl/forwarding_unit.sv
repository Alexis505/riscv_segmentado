module forwarding_unit (input logic  [4:0] rs1_E,
			input logic  [4:0] rs2_E,
			input logic  [4:0] aluresult_M,
			input logic regwrite_M,
			input logic  [4:0] Rd_M,
			input logic regwrite_W,
			input logic  [4:0] Rd_W,
			output logic [1:0] forwardA_E,
			output logic [1:0] forwardB_E);

    always @(*)
	if ((rs1_E == Rd_M) & (regwrite_M) & (rs1_E != 0))
		forwardA_E = 2'b10;     //forward from memory stage
	else if ((rs1_E == Rd_W) & (regwrite_W) & (rs1_E != 0))
		forwardA_E = 2'b01;     //forward from wb stage
	else 	forwardA_E = 2'b00;     //no forward (use register file output)
    always @(*)
	if ((rs2_E == Rd_M) & (regwrite_M) & (rs2_E != 0))
		forwardB_E = 2'b10;    //forward from mem stage
	else if ((rs2_E == Rd_W) & (regwrite_W) & (rs2_E != 0))
		forwardB_E = 2'b01;   //forward from wb stage
	else 	forwardB_E = 2'b00;   //no forward. Use rf output

endmodule
