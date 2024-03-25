module regfile (input logic clk,
		input logic write_enable,
		//aN = address_number
		input logic  [4:0] a1, a2, a3,
		input logic  [31:0] write_data,
		output logic [31:0] rd1, rd2);

    logic [31:0] rf[31:0];  //arreglo de 32 renglones de 32 bits cada uno

    //archivo de registros de 3 puertos
    //Se leen dos puertos de manera combinatorio (a1/rd1 a2/rd2)
    //en flanco positivo de reloj se escribe el tercer puerto (a3/write_data/write_enable)
    //escribimos en flanco negativo. Asi podemos escribir y leer en un ciclo
    always_ff @(negedge clk)
	if (write_enable) rf[a3] = write_data;

    assign rd1 = (a1 != 0) ? rf[a1] : 0;
    assign rd2 = (a2 != 0) ? rf[a2] : 0;

endmodule
