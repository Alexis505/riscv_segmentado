module flop #(parameter WIDTH = 8)(input logic clk, reset,
				   input logic stall_F, 
				   input logic [WIDTH-1:0] d,
				   output logic [WIDTH-1:0] q);

    always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else if (stall_F) q <= q;
	else	   q <= d;

endmodule
