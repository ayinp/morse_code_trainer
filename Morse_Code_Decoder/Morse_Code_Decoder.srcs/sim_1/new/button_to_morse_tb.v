`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 05:53:43 PM
// Design Name: 
// Module Name: button_to_morse_tb
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


module button_to_morse_tb;
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
    wire [2:0] morse_index;
    
    // Instantiate the button_to_morse module
    button_to_morse b1(clock, reset, button, morse_one, morse_two, morse_three, morse_four, morse_five, morse_six, letter_done, morse_index);

    // Create a slower clock, for example, 10 Hz (100 ms period)
    always begin
        #1 clock = ~clock;  // 10 Hz clock period
    end

   initial begin
    // Initialize signals
    clock = 0;
    reset = 0;
    button = 0;

    // Apply reset
    #20 reset = 1;
    #20 reset = 0;

    #20 button = 1;   // Button pressed
    #10 button = 0;  // Button released (1.5 seconds = dash)
    #30 button = 1;
    #10 button = 0;
    #30 button = 1;
    #30 button = 0;
    
    #90 button = 1;   // Button pressed
    #10 button = 0;  // Button released (1.5 seconds = dash)
    #30 button = 1;
    #30 button = 0;
    #30 button = 1;
    #30 button = 0;

    // Wait for some time
    #100;

    // End simulation
    #100 $finish;
end

endmodule



