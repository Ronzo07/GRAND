module tb_HardGrand;

    // Define parameters
    parameter WIDTH = 8;

    // Inputs
    reg [0:7] cHat;
    
    // Outputs
    wire [0:7] c;
  	integer i;
  	integer counter;

    // Instantiate the module to be tested
    HardGrand dut (
        .cHat(cHat),
        .c(c)
    );

    // Initialize cHat values
    initial begin
      counter = 0;
      cHat = 8'b0100_0000;
      #10000
      $display("Origial c: 00000000, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0000_0000) counter = counter + 1;
      
      cHat = 8'b0100_0100;
      #10000
      $display("Origial c: 0000_0000, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0000_0000) counter = counter + 1;
      
      cHat = 8'b01010111;
      #10000
      $display("Origial c: 0001_0111, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0001_0111) counter = counter + 1;
      
      cHat = 8'b01010111;
      #10000
      $display("Origial c: 0001_0111, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0001_0111) counter = counter + 1;
      
      cHat = 8'b00010111;
      #10000
      $display("Origial c: 0001_0111, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0001_0111) counter = counter + 1;
      
      cHat = 8'b01010111;
      #10000
      $display("Origial c: 0001_0111, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0001_0111) counter = counter + 1;
            
      cHat = 8'b1010_0100;
      #10000
      $display("Origial c: 1010_0101, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b1010_0101) counter = counter + 1;
      

      cHat = 8'b00100011;
      #10000
      $display("Origial c: 00101011, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b00101011) counter = counter + 1;


      cHat = 8'b10000111; 
      #10000
      $display("Origial c: 11000011, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b11000011) counter = counter + 1;

      cHat = 8'b00001101; 
      #10000
      $display("Origial c: 01001101, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b01001101)#1 counter = counter + 1;

      cHat = 8'b00001001;
      #10000
      $display("Origial c: 01001101, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b01001101) counter = counter + 1;

      
      $display("Number of success %d out of 11", counter);

        
        $finish;
    end
endmodule
