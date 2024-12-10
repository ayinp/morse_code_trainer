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
    wire letter_done;          // Letter done indicator
    wire [2:0] morse_index;
    //wire [31:0] inactivity_counter;
    //wire [31:0] counter;
    wire [7:0] ascii_char;
    
    // Instantiate the button_to_morse module
    button_to_morse b1(clock, reset, button, morse_one, morse_two, morse_three, morse_four, morse_five, letter_done, morse_index);
    morse_decoder m1(morse_one, morse_two, morse_three, morse_four, morse_five, letter_done, reset, ascii_char);

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
    
    //Letter T
    #30 button = 1;  
    #60 button = 0;
    
    //Letter E
    #80 button = 1;  
    #20 button = 0;  
    
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
    #200;

    // End simulation
    #200 $finish;
    end
    
endmodule
