module dmem (input logic clk, write_enable,
	     input logic  [31:0] a, write_data,
	     output logic [31:0] read_data);

	logic [31:0] RAM[63:0];

	assign read_data = RAM[a[31:2]]; //word aligned

	always_ff @(posedge clk)
	    if (write_enable) RAM[a[31:2]] <= write_data;

endmodule


