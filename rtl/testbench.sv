module testbench();

    logic clk;
    logic reset;
    logic mem_write;
    logic [31:0] write_data;
    logic [31:0] data_adr;

    //instanciamos el dispositivo a ser probado
    top dut(clk, reset, write_data, data_adr, mem_write);

    //initialize test
    initial
        begin
	    reset <= 1; #22; reset <= 0;
	end

    //generar reloj para hacer secuencia de pruebas
    always
	begin
	    clk <= 1; #5; clk <= 0; #5;
	end

    //revisar resultados
    always@(negedge clk)
	begin
	    if(mem_write) begin
		if(data_adr === 100 & write_data === 25) begin
		$display("La simulacion tuvo exito :)");
		$stop;
		end
	    else if (data_adr !== 96) begin
		$display("La simulacion fallo, revisa el codigo :(");
		$stop;
	    end
	end
       end
endmodule	
