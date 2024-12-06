`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 02:42:54 PM
// Design Name: 
// Module Name: button_to_ascii_tb
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


module button_to_ascii_tb(

    );
    
    reg clock;                 // 10 Hz clock
    reg reset;                 // Reset signal
    reg button;                // Button signal (active high)
    wire [1:0] morse_one;      // Morse code output
    wire [1:0] morse_two;      // Morse code output
    wire [1:0] morse_three;    // Morse code output
    wire [1:0] morse_four;     // Morse code output
    wire [1:0] morse_five;     // Morse code output
    wire [1:0] morse_six;      // Morse code output
    wire letter_done;          // Letter done indicator
    wire is_space;
    wire [2:0] morse_index;
    wire [9:0] counter;
    wire [9:0] inactivity_counter;
    wire [7:0] ascii_char;
    
    // Instantiate the button_to_morse module
    button_to_morse b1(clock, reset, button, morse_one, morse_two, morse_three, morse_four, morse_five, morse_six, letter_done, is_space, morse_index, counter, inactivity_counter);
    morse_decoder m1(morse_one, morse_two, morse_three, morse_four, morse_five, morse_six, letter_done, is_space, ascii_char);

    // Create a slower clock, for example, 10 Hz (100 ms period)
    always begin
        #10 clock = ~clock;  // 10 Hz clock period
    end

   initial begin
    // Initialize signals
    clock = 0;
    reset = 0;
    button = 0;

    // Apply reset
    #20 reset = 1;
    #20 reset = 0;
    
    // Letter A
    #20 button = 1;   // Button pressed
    #20 button = 0;  // Button released (1.5 seconds = dash)
    #20 button = 1;
    #60 button = 0;
    
    //Letter T
    #150 button = 1;   // Button pressed
    #60 button = 0;  // Button released (1.5 seconds = dash)
    
    //Letter E
    #80 button = 1;   // Button pressed
    #20 button = 0;  // Button released (1.5 seconds = dash)
    
    //Letter S
    #80 button = 1;
    #20 button = 0;
    #20 button = 1;
    #20 button = 0;
    #20 button = 1;
    #20 button = 0;
    
    //Letter T
    #80 button = 1;
    #60 button = 0;
    

    // Wait for some time
    #100;

    // End simulation
    #100 $finish;
    end
    
endmodule
