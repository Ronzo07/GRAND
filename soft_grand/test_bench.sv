module tb_SoftGrand;

    // Define parameters
    parameter WIDTH = 8;

    // Inputs
  	reg [0:7] cHat;
    reg [8:0] k_0, k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8;

    // Outputs
  	reg [0:7] c;
  	integer counter;


    // Instantiate the module to be tested
    SoftGrand dut (
        .cHat(cHat),
        .c(c),
        .k_0(k_0),
        .k_1(k_1),
        .k_2(k_2),
        .k_3(k_3),
        .k_4(k_4),
        .k_5(k_5),
        .k_6(k_6),
        .k_7(k_7)
    );

    // Initialize cHat values
    initial begin
      	#10000
		#10000
        // Initialize k values for BitPermutation module
        k_0 = 8; k_1 = 1; k_2 = 5; k_3 = 6;
      	k_4 = 3; k_5 = 2; k_6 = 4; k_7 = 7;

       
      counter = 0;
       cHat = 8'b0100_0000;
      #100000
      $display("Origial c: 00000000, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0000_0000) counter = counter + 1;
      
      cHat = 8'b0100_0100;
      #100000
      $display("Origial c: 0000_0000, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0000_0000) counter = counter + 1;
      
      cHat = 8'b01010111;
      #100000
      $display("Origial c: 0001_0111, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0001_0111) counter = counter + 1;
      
      cHat = 8'b01010111;
      #100000
      $display("Origial c: 0001_0111, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0001_0111) counter = counter + 1;
      
      cHat = 8'b00010111;
      #100000
      $display("Origial c: 0001_0111, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0001_0111) counter = counter + 1;
      
      cHat = 8'b01010111;
      #100000
      $display("Origial c: 0001_0111, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b0001_0111) counter = counter + 1;
            
      cHat = 8'b1010_0100;
      #100000
      $display("Origial c: 1010_0101, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b1010_0101) counter = counter + 1;
      

      cHat = 8'b00100011;
      #100000
      $display("Origial c: 00101011, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b00101011) counter = counter + 1;


      cHat = 8'b10000111; 
      #100000
      $display("Origial c: 11000011, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b11000011) counter = counter + 1;

      cHat = 8'b00001101; 
      #10000
      $display("Origial c: 01001101, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b01001101)#1 counter = counter + 1;

      cHat = 8'b00001001;
      #100000
      $display("Origial c: 01001101, cHat: %b, output c: %b", cHat, c);
      if (c === 8'b01001101) counter = counter + 1;

      
      $display("Number of success %d out of 11 trial!", counter);

        
        $finish;
    end
endmodule