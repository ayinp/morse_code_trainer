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
    //input [15:0]check,
    output reg led_timer,                   // Unit timer
    output [2:0] morse_index,               // Track when symbol is done
    output [6:0] seg_out,                   // Which segments are on for a character on the display
    output [7:0] current_display,           // Which of the 8 displays are on
    output [7:0] current_display_check      // Check the displays that should be in use
);

    wire [1:0] morse_one, morse_two, morse_three, morse_four, morse_five;
    wire letter_done;
    wire is_space;
    wire button_clean;
    wire clk_out;
    wire quarter_sec_unit;
    wire half_sec_unit;
    wire tenth_sec_unit;
    
    wire [7:0] ascii_char;

    // Instantiate the clock divider module
    clock_divider c1(clock, quarter_sec_unit, half_sec_unit, tenth_sec_unit, reset, clk_out);

    // LED toggle to control unit timer
    always @(posedge clk_out) begin
        if (reset) begin
            led_timer <= 0;
        end else begin
            led_timer <= ~led_timer;
        end
    end
    
     // Instantiate the debouncer module
    debouncer d1(clock, button, button_clean);

    // Instantiate the button to morse module
    button_to_morse bm1(clk_out, reset, button_clean, morse_one, morse_two, morse_three, morse_four, morse_five, letter_done, is_space, morse_index);

    // Instantiate the morse decoder module
    morse_decoder m2(morse_one, morse_two, morse_three, morse_four, morse_five, letter_done, is_space, ascii_char);
 
    // Instantiate the seven segmentdisplay module
    seven_seg_disp s1(ascii_char, clock, letter_done, reset, seg_out, current_display, current_display_check);


//always @(check) begin

//        case (check)
//            // Numbers
//            16'd0: seg = 7'b0000001; // 0
//            16'd1: seg = 7'b1001111; // 1
//            16'd2: seg = 7'b0010010; // 2
//            16'd3: seg = 7'b0000110; // 3
//            16'd4: seg = 7'b1001100; // 4
//            16'd5: seg = 7'b0100100; // 5
//            16'd6: seg = 7'b0100000; // 6
//            16'd7: seg = 7'b0001111; // 7
//            16'd8: seg = 7'b0000000; // 8
//            16'd9: seg = 7'b0000100; // 9
            
//            // Lowercase letters
//            16'd10: seg = 7'b0001000; // a 
//            16'd11: seg = 7'b1100000; // b 
//            16'd12: seg = 7'b1110010; // c
//            16'd13: seg = 7'b1000010; // d
//            16'd14: seg = 7'b0110000; // e
//            16'd15: seg = 7'b0111000; // f
//            16'd16: seg = 7'b0100001; // g
//            16'd17: seg = 7'b1101000; // h
//            16'd18: seg = 7'b1101111; // i
//            16'd19: seg = 7'b1000111; // j
//            16'd20: seg = 7'b0101000; // k (approximated)
//            16'd21: seg = 7'b1110001; // l
//            16'd22: seg = 7'b0001001; // m (approximated)
//            16'd23: seg = 7'b1101010; // n
//            16'd24: seg = 7'b1100010; // o
//            16'd25: seg = 7'b0011000; // p
//            16'd26: seg = 7'b0001100; // q (approximated)
//            16'd27: seg = 7'b1111010; // r
//            16'd28: seg = 7'b0100100; // s
//            16'd29: seg = 7'b1110000; // t
//            16'd30: seg = 7'b1100011; // u
//            16'd31: seg = 7'b1100011; // v (same as u)
//            16'd32: seg = 7'b1000001; // w (approximated)
//            16'd33: seg = 7'b1001000; // x (approximated)
//            16'd34: seg = 7'b1000100; // y
//            16'd35: seg = 7'b0010010; // z

//            // Space
//            16'd36: seg = 7'b1111111; // Blank
            
//            // Default to blank
//            default: seg = 7'b1111111;
//        endcase
//    end


endmodule
