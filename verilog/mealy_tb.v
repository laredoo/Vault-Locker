`timescale 1ns/100ps

module fsm_teste;

   reg [1:0] x_t;
   reg clk_t;
   reg rst_t;
   wire y_t;

   cofre teste(.x(x_t), .clk(clk_t), .rst(rst_t), .y(y_t));

   initial begin
      // armazenando registro
      $dumpfile ("dump.vcd");
      $dumpvars;
         x_t = 2'b00;
         clk_t = 0;
         rst_t = 0;
     
     	 #10
     	 rst_t = 1;
     
         #30
         x_t = 2'b01;
         // estado e1
     
     	 #10
         x_t = 2'b00;

         #30
         x_t = 2'b11;
         // estado e2
     
     	 #10
     	 x_t = 2'b00;

         #30
         x_t = 2'b01;
         // estado e3
     
     	 #10
     	 x_t = 2'b00;

         #30
         x_t = 2'b01;
         // estado e4
     
     	 #10
     	 x_t = 2'b00;

         #30
         x_t = 2'b10;
         // estado e5 e abre a porta
     
     	 #10
     	 x_t = 2'b00;

         #200
         $stop;
   end

   always #5 clk_t = ~clk_t;

endmodule