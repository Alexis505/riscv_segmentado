module aludec (input logic op_code_5,
	       input logic [2:0] funct_3,
	       input logic funct_7b5,
	       input logic [1:0] alu_op,
	       output logic [2:0] alu_control);

logic RtypeSub;
assign RtypeSub = funct_7b5 & op_code_5; //true for r-tpye subtract
//en base a alu_op decidimos que hacer primero
    always_comb
	case(alu_op)
	    2'b00: alu_control = 3'b000; //adicion
	    2'b01:  alu_control = 3'b001; //substraction
	    default: case(funct_3) //R-type or I-type instr
		        3'b000: if(RtypeSub)
				    alu_control = 3'b001; //sub
				else
				    alu_control = 3'b000; //add
			3'b010: 
				    alu_control = 3'b101; //slt, slti
			3'b110:     alu_control = 3'b011; //or ori
			3'b111:     alu_control = 3'b010; //and, andi
			default:    alu_control = 3'bxxx; //??
		     endcase
         endcase
endmodule
     
