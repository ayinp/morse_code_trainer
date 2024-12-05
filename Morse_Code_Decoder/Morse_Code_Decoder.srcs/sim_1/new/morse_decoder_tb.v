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

    reg [1:0] morse_one, morse_two, morse_three, morse_four, morse_five, morse_six;
    reg letter_done;
    reg is_space; 
    wire [7:0] ascii_char;

    // Instantiate the morse_decoder module
    morse_decoder uut (
        .morse_one(morse_one),
        .morse_two(morse_two),
        .morse_three(morse_three),
        .morse_four(morse_four),
        .morse_five(morse_five),
        .morse_six(morse_six),
        .letter_done(letter_done),
        .is_space(is_space),
        .ascii_char(ascii_char)
    );

    initial begin
        // Initialize inputs
        morse_one = 2'b00; morse_two = 2'b00; morse_three = 2'b00;
        morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00;
        is_space = 0; letter_done = 1;
    
        // Wait for global reset
        #10;
    
        // Letters A-Z
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b00; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10;
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b10; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b00; morse_three = 2'b00; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b00; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b10; morse_five = 2'b00; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b00; morse_six = 2'b00; #10;
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b00; morse_six = 2'b00; #10; 
    
        // Number Test Cases (0-9)
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b10; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b10; morse_six = 2'b00; #10;
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b10; morse_six = 2'b00; #10;
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b10; morse_five = 2'b10; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b10; morse_six = 2'b00; #10; 
        morse_one = 2'b01; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b01; morse_six = 2'b00; #10;
        morse_one = 2'b10; morse_two = 2'b01; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b01; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b01; morse_four = 2'b01; morse_five = 2'b01; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b01; morse_five = 2'b01; morse_six = 2'b00; #10; 
        morse_one = 2'b10; morse_two = 2'b10; morse_three = 2'b10; morse_four = 2'b10; morse_five = 2'b01; morse_six = 2'b00; #10; 
    
        // Finish simulation
        $finish;
    end

endmodule

