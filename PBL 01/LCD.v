module lcd(
	
	input [31:0] dataa, // dados para ação
	input [31:0] datab, // sados escrever LCD
	input clk,
	input clk_en,
          
	output reg enable,
	output reg [9:0] dataout // saída o LCD, dados
);
	
	
	reg    write = 1'b0;
	always @(posedge clk)
		 if(clk_en) begin
			 enable    <= 1'b0;
			 write <= 1'b1; 
		 end else if(write) begin
			 enable    <= 1'b1;
			 dataout[9:0] <= dataa[9:0];
			 write <= 1'b0;
		 end
endmodule 