`timescale 1ns / 1ps

module MappingTable( input logic[3:0] in, input logic clk, output logic[3:0] out );


  
always@(posedge clk) begin

	case (in)
		
		4'b00_00: out <= 4'b11_11;
		4'b00_01: out <= 4'b00_00;
		4'b00_10: out <= 4'b00_01;
		4'b00_11: out <= 4'b00_10;

		4'b01_00: out <= 4'b00_11;
		4'b01_01: out <= 4'b01_00;
		4'b01_10: out <= 4'b01_01;
		4'b01_11: out <= 4'b01_10;

		4'b10_00: out <= 4'b01_11;
		4'b10_01: out <= 4'b10_00;
		4'b10_10: out <= 4'b10_01;
		4'b10_11: out <= 4'b10_10;

		4'b11_00: out <= 4'b10_11;
		4'b11_01: out <= 4'b11_00;
		4'b11_10: out <= 4'b11_01;
		4'b11_11: out <= 4'b11_10;
		default;
endcase
end

endmodule
