`timescale 1ns / 1ps

module testBench_LFSR(

    );
    
    // Inputs
     logic clk;
     logic reset;
     
     // Outputs
     logic [3:0] random;
     
     // Instantiate the Unit Under Test (UUT)
     LFSR dut (reset, clk, random);
           
     initial begin
      clk = 0;
      reset = 1;
      #15;
      reset = 0;
      #200;
      end
      
      always
      begin
          #5;
          clk = ~ clk;
      end
      
    
endmodule
