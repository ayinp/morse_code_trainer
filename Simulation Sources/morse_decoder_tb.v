`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 04:16:56 PM
// Design Name: 
// Module Name: morse_decoder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module morse_decoder_tb(
    );
    
    reg [1:0] morse_one, morse_two, morse_three, morse_four, morse_five;  // Morse Outputs
    reg letter_done;  // Detect when letter is done
    wire [7:0] ascii_char;  // 8-bit ASCII code

    // Instantiate the morse_decoder module
    morse_decoder md1(morse_one, morse_two, morse_three, morse_four, morse_five, letter_done, reset, ascii_char);

    initial begin
        // Initialize inputs
        morse_one = 2'b00; morse_two = 2'b00; morse_three = 2'b00;
        morse_four = 2'b00; morse_five = 2'b00;
        letter_done = 1;
    
        #10;
    
        // Letters A-Z
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b00; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00;  #10;
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b10; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b00; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b00;  #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b00; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b10; morse_five = 2'b00;  #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b00;  #10;
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b00;  #10; 
    
        // Number Test Cases (0-9)
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b10;  #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b10;  #10;
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b10;  #10;
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b10; morse_five = 2'b10;  #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b10;  #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b01;  #10;
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b01;  #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b01;  #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b01;  #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b01;  #10; 
    
        // Finish simulation
        $finish;
    end

endmodule

