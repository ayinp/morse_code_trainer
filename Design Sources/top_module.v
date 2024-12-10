`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 04:16:00 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clock,                            // System clock
    input reset,                            // Reset signal
    input button,                           // Button input (active high)
    input one_sec_unit,                     // Switch input for 1.0s time unit
    input half_sec_unit,                    // Switch input for 0.5s time unit
    input quarter_sec_unit,                 // Switch input for 0.25s time unit
    output reg [1:0] led_timer,             // Unit timer
    output [2:0] morse_index,               // Track when symbol is done
    output [6:0] seg_out,                   // Which segments are on for a character on the display
    output [7:0] current_display,           // Which of the 8 displays are on
    output [7:0] current_display_check      // Check the displays that should be in use
);

    wire [1:0] morse_one, morse_two, morse_three, morse_four, morse_five;
    wire letter_done;  //Detect when letter is done
    wire button_clean;  //Clean button signal
    wire clk_out; // Slow clock

    wire [7:0] ascii_char;

    // Instantiate the clock divider module
    clock_div c1(clock, one_sec_unit, half_sec_unit, quarter_sec_unit, reset, clk_out);

    // LED toggle to control unit timer
    initial begin
        led_timer[0] <= 0;
        led_timer[1] <= 1;
    end

    always @(posedge clk_out) begin
        if (reset) begin
            led_timer[0] <= 0;
            led_timer[1] <= 1;
        end else begin
            led_timer[0] <= ~led_timer[0]; 
            led_timer[1] <= ~led_timer[1];
        end
    end
    
     // Instantiate the debouncer module
    debouncer d1(clock, button, button_clean);

    // Instantiate the button to morse module
    button_to_morse bm1(clk_out, reset, button_clean, morse_one, morse_two, morse_three, morse_four, morse_five, letter_done, morse_index);

    // Instantiate the morse decoder module
    morse_decoder m2(morse_one, morse_two, morse_three, morse_four, morse_five, letter_done, reset, ascii_char);
 
    // Instantiate the seven segmentdisplay module
    seven_seg_disp s1(ascii_char, clock, letter_done, reset, seg_out, current_display, current_display_check);
    

endmodule
