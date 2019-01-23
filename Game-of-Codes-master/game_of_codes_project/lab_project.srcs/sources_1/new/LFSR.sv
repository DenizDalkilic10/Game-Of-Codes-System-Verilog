`timescale 1ns / 1ps

module LFSR( input start, clk, output logic [3:0] randomNumber );

logic [15:0] register;

logic changedBit;

assign changedBit = register[1] ^ register[0];
assign randomNumber = {changedBit, register[15:1]};
always@(posedge clk) begin
        if (start)
             register <= 15'b101011100110111;   // lfsr must be non-zero to work
        else
             register <= {changedBit, register[15:1]};
end

endmodule
