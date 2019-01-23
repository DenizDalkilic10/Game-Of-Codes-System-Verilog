`timescale 1ns / 1ps

module gameController(
               input clk, //100Mhz on Basys3

                //7-segment signals
                output a, b, c, d, e, f, g, dp,
                output [3:0] an,

                //matrix  4x4 keypad
                output [3:0] keyb_row,
                output [3:0] phases,
                input  [3:0] keyb_col,

                input reset
                //input start                             
    );
logic [3:0] key_value;
logic key_valid;
logic go;

logic [3:0] lfsrOutput;
logic [3:0] newKey_value;
logic [3:0] randomNumber;

logic [3:0] in0 = 4'h0;
logic [3:0] in1 = 4'h0;
logic [3:0] in2 = 4'h0;
logic [3:0] in3 = randomNumber;



always@ (posedge clk) begin

if (reset == 1'b1) begin 
in0 <= 4'd0;
end

if (key_valid == 1'b1) begin
      
            go <= 1;
            randomNumber <= lfsrOutput;
            
                if ( newKey_value == randomNumber ) begin
			        if ( in0 < 4'd9 )
			        in0 <= in0 + 4'd1;
			    end
                else begin
			        if ( in0 > 4'd0 )
			        in0 <= in0 - 4'd1;
			    end  
		      
end//if
else go <= 0;

end


keypad4X4 keypad4X4_inst0( 
.clk(clk),
.keyb_row(keyb_row), // just connect them to FPGA pins, row scanner
.keyb_col(keyb_col), // just connect them to FPGA pins, column scanner
.key_value(key_value), //user's output code for detected pressed key: row[1:0]_col[1:0]
.key_valid(key_valid)  // user's output valid: if the key is pressed long enough (more than 20~40 ms), key_valid becomes '1' for just one clock cycle.
);            

SevSeg_4digit SevSeg_4digit_inst0(
.clk(clk),
.in3(in3), .in2(in2), .in1(in1), .in0(in0), //user inputs for each digit (hexadecimal)
.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp), // just connect them to FPGA pins (individual LEDs).
.an(an)   // just connect them to FPGA pins (enable vector for 4 digits active low)
);

steppermotor_wrapper motor( clk, randomNumber[3:2], randomNumber[1:0], phases, go );

MappingTable mappingTable( key_value, clk, newKey_value );
LFSR lfsr( reset, clk, lfsrOutput );


endmodule
