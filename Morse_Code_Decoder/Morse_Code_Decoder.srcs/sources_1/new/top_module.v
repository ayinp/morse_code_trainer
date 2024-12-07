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
    input clock,                    // System clock
    input reset,                    // Reset signal
    input button,                   // Button input (active high)
    input delete,
    output reg led_timer,
    output [2:0] morse_index,
    output [7:0] ascii_char // ASCII character output
);

    wire [1:0] morse_one, morse_two, morse_three, morse_four, morse_five, morse_six;
    wire letter_done;
    wire is_space;
    wire is_delete;
    wire button_clean;
    
    wire clk_2Hz;
    
    clock_divider c1(
        .clock(clock),
        .reset(reset),
        .clk_out(clk_2Hz)        
    );

    // Simple LED toggle (not synthesizable as is, consider replacing with counter)
    always @(posedge clk_2Hz) begin
        if (reset) begin
            led_timer <= 0;
        end else begin
            led_timer <= ~led_timer;
        end
    end
    
    debouncer d1(
        .clock(clock),
        .button(button),
        .clean(button_clean)
    );

    // Instantiate the button to morse module
    button_to_morse bm1(
        .clock(clk_2Hz), 
        .reset(reset), 
        .button(button_clean), 
        .delete(delete), 
        .morse_one(morse_one), 
        .morse_two(morse_two), 
        .morse_three(morse_three), 
        .morse_four(morse_four), 
        .morse_five(morse_five), 
        .morse_six(morse_six), 
        .letter_done(letter_done), 
        .is_space(is_space), 
        .is_delete(is_delete),
        .morse_index(morse_index)
    );

    // Instantiate the morse decoder module
    morse_decoder m2(
        .morse_one(morse_one), 
        .morse_two(morse_two), 
        .morse_three(morse_three), 
        .morse_four(morse_four), 
        .morse_five(morse_five), 
        .morse_six(morse_six), 
        .letter_done(letter_done), 
        .is_space(is_space), 
        .is_delete(is_delete), 
        .ascii_char(ascii_char)
    );

endmodule
