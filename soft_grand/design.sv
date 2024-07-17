// Check if a givin input register in in the table of the book page: 
// This module check if the given input is in the Table and setting result to 1 if present otherwise setting it to 0 
module CMC #(parameter WIDTH = 8)(
    input [WIDTH-1:0] input_reg,
    output reg result
);
    reg [WIDTH-1:0] Table [0:15];
    integer i;

    initial begin
      if (WIDTH == 8) begin
        Table[0] = 8'b00000000; 
        Table[1] = 8'b00010111; 
      	Table[2] = 8'b00101011; 
        Table[3] = 8'b00111100; 
      	Table[4] = 8'b01001101; 
        Table[5] = 8'b01011010;
      	Table[6] = 8'b01100110; 
        Table[7] = 8'b01110101;
        Table[8] = 8'b10001110; 
        Table[9] = 8'b10011001;
      	Table[10] = 8'b10100101; 
        Table[11] = 8'b10110010; 
      	Table[12] = 8'b11000011; 
        Table[13] = 8'b11010100; 
      	Table[14] = 8'b11101000; 
        Table[15] = 8'b11111111;
      end
      
      else if (WIDTH == 7) begin
        Table[0] = 7'b0000000;
        Table[1] = 7'b0001011;
        Table[2] = 7'b0010101;
        Table[3] = 7'b0011110;
        Table[4] = 7'b0100110;
        Table[5] = 7'b0101101;
        Table[6] = 7'b0110011;
        Table[7] = 7'b0111000;
        Table[8] = 7'b1000111;
        Table[9] = 7'b1001100;
        Table[10] = 7'b1010010;
        Table[11] = 7'b1011001;
        Table[12] = 7'b1100001;
        Table[13] = 7'b1101010;
        Table[14] = 7'b1110100;
        Table[15] = 7'b1111111;
      end
    end

    always @ (input_reg) begin
        result = 0;
      for (i = 0; i < 16 && result != 1; i = i + 1) begin
          if (input_reg === Table[i]) begin
                result = 1;
            end
        end
    end
endmodule


// Generate next error register based on the previous one
module NEP #(parameter WIDTH = 8)(
  input [0:WIDTH-1] s,      	// WIDTH-bit input s
  output reg [0:WIDTH-1] new_s  // WIDTH-bit output new_s
);

  integer last, last1next0, count1, i;
  reg [0:WIDTH-1] temp_s;

    // Combinatorial logic to generate new_s
    always @* begin
      last = -1;
      last1next0 = -1;
      count1 = 0;
      temp_s = s;

      // Count the number of '1's in the input
      for (i = 0; i < WIDTH; i = i + 1) begin
            if (s[i] == 1'b1) begin
                last = i;
                count1 = count1 + 1;
            end
        end

      // Find the index of the last '1' followed by '0'
      for (i = 0; i < WIDTH-1; i = i + 1) begin
            if (s[i] == 1'b1 && s[i+1] == 1'b0) begin
                last1next0 = i;
            end
        end

      if (last != WIDTH-1 && last != -1) begin
            // Swap last '1' one bit to the right
            temp_s[last] = 1'b0;
            temp_s[last+1] = 1'b1;
            new_s = temp_s;
        end
      
      else if (last1next0 < WIDTH-2 && last != -1 && last1next0 != -1 && last1next0 != last) begin
            // Swap last '1' and next '0' bits accordingly
            temp_s[last1next0] = 1'b0;
            temp_s[last1next0+1] = 1'b1;
        	count1 = 0; 
            for (i = last1next0 + 2; i < WIDTH; i = i + 1) begin
              if (s[i]== 1'b1) count1 = count1 + 1;
            end
        
            for (i = last1next0 + 2; i < WIDTH; i = i + 1) begin
              if (i - (last1next0 + 2) < count1) 
                temp_s[i] = 1'b1;
              else 
                temp_s[i] = 1'b0;
            end
            new_s = temp_s;
        end
      
        else begin
            // If all '1's are to the right, perform this operation
            for (i = 0; i < WIDTH; i = i + 1) begin
                if (i < count1 + 1)
                    temp_s[i] = 1'b1;
                else
                    temp_s[i] = 1'b0;
            end
            new_s = temp_s;
        end
    end

endmodule


module BitPermutation (
  	input [0:7] bin,
    input [8:0] k_0, k_1, k_2, k_3, k_4, k_5, k_6, k_7,
  	output reg [0:7] bout
);

  reg [0:8] k[8:0];

    integer i;

  always @(bin) begin
        #1k[0] = k_0;
       #1 k[1] = k_1;
       #1 k[2] = k_2;
       #1 k[3] = k_3;
       #1 k[4] = k_4;
        #1k[5] = k_5;
       #1 k[6] = k_6;
        #1k[7] = k_7;
 		#1	
        for (i = 0; i < 8; i = i + 1) begin
          	#1
            bout[i] = bin[k[i] - 1];         
        end
    end

endmodule


module SoftGrand #(parameter WIDTH = 8)( 
    input [0:WIDTH-1] cHat,
  	input [8:0] k_0, k_1, k_2, k_3, k_4, k_5, k_6, k_7,

    output reg [0:WIDTH-1] c,
    output reg[0:WIDTH-1] w_x
  
);
  
    reg [0:WIDTH-1] w = 8'b0000_0000;
    reg [0:WIDTH-1] new_w;
    reg [0:WIDTH-1] tmp = 8'b0000_1111;
    reg [0:WIDTH-1] bout;
    reg match;
  	integer counter = 0;
    integer i;

    NEP #(.WIDTH(WIDTH)) gen_w (
        .s(w),
        .new_s(new_w)
    );

    CMC #(.WIDTH(WIDTH)) comp_table (
        .input_reg(tmp),
        .result(match)
    );
  
    BitPermutation permutation(
        .bin(w),
        .k_0(k_0),
        .k_1(k_1),
        .k_2(k_2),
        .k_3(k_3),
        .k_4(k_4),
        .k_5(k_5),
        .k_6(k_6),
        .k_7(k_7),
      	.bout(bout)
      );
  

      always @* begin
        #10
        tmp = cHat; // Initialize tmp based on input cHat
        counter = 0;
        #10
        w = 8'b0000_0000;
        #10
        for (i = 0; i < (1 << WIDTH) && counter < 1; i = i + 1) 
          begin
            #100
            tmp = bout ^ cHat;
            #10
            if (match == 1) begin
              #10
              c = bout ^ cHat;                
              counter = counter + 1;
            end
            #10
            w = new_w;
          end
      end
endmodule