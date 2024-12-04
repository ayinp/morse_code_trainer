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
    reg clock;                 // 100 MHz clock
    reg reset;                 // Reset signal
    reg button;                // Button signal (active high)
    wire [1:0] morse_one;      // Morse code output
    wire [1:0] morse_two;      // Morse code output
    wire [1:0] morse_three;    // Morse code output
    wire [1:0] morse_four;     // Morse code output
    wire [1:0] morse_five;     // Morse code output
    wire [1:0] morse_six;      // Morse code output
    wire is_space;             // Space indicator
    wire letter_done;          // Letter done indicator
    
    // Instantiate the button_to_morse module
    button_to_morse uut (
        .clock(clock),
        .reset(reset),
        .button(button),
        .morse_one(morse_one),
        .morse_two(morse_two),
        .morse_three(morse_three),
        .morse_four(morse_four),
        .morse_five(morse_five),
        .morse_six(morse_six),
        .is_space(is_space),
        .letter_done(letter_done)
    );

    // Create a slower clock, for example, 10 Hz (100 ms period)
    always begin
        #50 clock = ~clock;  // 10 Hz clock period
    end

    initial begin
        // Initialize signals
        clock = 0;
        reset = 0;
        button = 0;

        // Apply reset
        #100 reset = 1;
        #100 reset = 0;

        // Simulate a short button press (dot: 0.5 seconds)
        #100 button = 1;   // Button pressed
        #50 button = 0;    // Button released (0.5 seconds = dot)

        // Wait for some time
        #100;

        // Simulate a long button press (dash: 1.5 seconds)
        #100 button = 1;   // Button pressed
        #150 button = 0;   // Button released (1.5 seconds = dash)

        // End simulation
        #100 $finish;
    end
endmodule


