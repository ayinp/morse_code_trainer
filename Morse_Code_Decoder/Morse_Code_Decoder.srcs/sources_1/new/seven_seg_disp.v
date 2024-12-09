`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2024 01:27:55 PM
// Design Name: 
// Module Name: seven_seg_disp
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


module seven_seg_disp (
    input [7:0] ascii_char,      // ASCII character input
    input clk,
    input wire letter_done,      // Signal that a letter is done (to shift to the next display)
    input wire reset,            // Reset signal to reset the current display to the first display
    output reg [6:0] seg_out,    // Seven-segment output for the active display
    output reg [7:0] current_display_out, // 8-bit register to track which displays are active
    output reg [7:0] current_display
);

    reg [6:0] seg;  // Temporary register to hold the segment pattern
    
    reg [6:0] seg_sav [7:0];
    
    reg [2:0] counter;
    reg [31:0] counter_big;

    // 7-segment encoding for characters
    always @(*) begin
        // Default to blank for the current segment
        case (ascii_char)
            // Numbers
            "0": seg = 7'b0000001; // 0
            "1": seg = 7'b1001111; // 1
            "2": seg = 7'b0010010; // 2
            "3": seg = 7'b0000110; // 3
            "4": seg = 7'b1001100; // 4
            "5": seg = 7'b0100100; // 5
            "6": seg = 7'b0100000; // 6
            "7": seg = 7'b0001111; // 7
            "8": seg = 7'b0000000; // 8
            "9": seg = 7'b0000100; // 9
            
            // Lowercase letters
            "A": seg = 7'b0001000; // a
            "B": seg = 7'b1100000; // b
            "C": seg = 7'b1110010; // c
            "D": seg = 7'b1000010; // d
            "E": seg = 7'b0110000; // e
            "F": seg = 7'b0111000; // f
            "G": seg = 7'b0100001; // g
            "H": seg = 7'b1101000; // h
            "I": seg = 7'b1101111; // i
            "J": seg = 7'b1000111; // j
            "K": seg = 7'b0101000; // k (approximated)
            "L": seg = 7'b1110001; // l
            "M": seg = 7'b0001001; // m (approximated)
            "N": seg = 7'b1101010; // n
            "O": seg = 7'b1100010; // o
            "P": seg = 7'b0011000; // p
            "Q": seg = 7'b0001100; // q (approximated)
            "R": seg = 7'b1111010; // r
            "S": seg = 7'b0100100; // s
            "T": seg = 7'b1110000; // t
            "U": seg = 7'b1100011; // u
            "V": seg = 7'b1100011; // v (same as u)
            "W": seg = 7'b1000001; // w (approximated)
            "X": seg = 7'b1001000; // x (approximated)
            "Y": seg = 7'b1000100; // y
            "Z": seg = 7'b0010010; // z

            // Space
            " ": seg = 7'b1110000; // Blank
            
            // Default to blank
            default: seg = 7'b1111111;
        endcase
    end

    // Shift current_display on letter_done signal
    always @(posedge letter_done or posedge reset) begin
        if (reset) begin
            current_display <= 8'b11111111; // Reset to first display active (leftmost)
        end else begin
            // Shift current_display to the right (move to the next display)
            current_display <= {current_display[6:0], 1'b0};
        end
    end
    
    
    
   always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0; // Reset to first display active (leftmost)
            counter_big <= 0;
            

            
        end else begin
            counter_big <= counter_big +1;
            if (counter_big==10000) begin
                   counter <= counter+1;
                   counter_big <=0;
            end
            case(counter)
            8'd0:begin 
                current_display_out <= 8'b11111110;
                seg_out <= seg_sav[0];
            end
            8'd1:begin 
                current_display_out <= 8'b11111101;
                seg_out <= seg_sav[1];
            end
            8'd2:begin 
                current_display_out <= 8'b11111011;
                seg_out <= seg_sav[2];
            end
            8'd3:begin 
                current_display_out <= 8'b11110111;
                seg_out <= seg_sav[3];
            end
            8'd4:begin 
                current_display_out <= 8'b11101111;
                seg_out <= seg_sav[4];
            end
            8'd5:begin 
                current_display_out <= 8'b11011111;
                seg_out <= seg_sav[5];
            end
            8'd6:begin 
                current_display_out <= 8'b10111111;
                seg_out <= seg_sav[6];
            end
            8'd7:begin 
                current_display_out <= 8'b01111111;
                seg_out <= seg_sav[7];
            end
            
            endcase

        end
    end
    

    // Display the corresponding segment on the active display
    always @(*) begin
        if (reset) begin
            seg_sav[0] = 7'b1111111;
            seg_sav[1] = 7'b1111111;
            seg_sav[2] = 7'b1111111;
            seg_sav[3] = 7'b1111111;
            seg_sav[4] = 7'b1111111;
            seg_sav[5] = 7'b1111111;
            seg_sav[6] = 7'b1111111;
            seg_sav[7] = 7'b1111111;
        end else begin  
        
        case (current_display)
            8'b11111110: seg_sav[0] = seg;  // First display active
            8'b11111100: seg_sav[1] = seg;  // Second display active
            8'b11111000: seg_sav[2] = seg;  // Third display active
            8'b11110000: seg_sav[3] = seg;  // Fourth display active
            8'b11100000: seg_sav[4] = seg;  // Fifth display active
            8'b11000000: seg_sav[5] = seg;  // Sixth display active
            8'b10000000: seg_sav[6] = seg;  // Seventh display active
            8'b00000000: seg_sav[7] = seg;  // Eighth display active
            default: seg_sav[7] = 7'b1111111;  // Default to blank
        endcase
        
        end
    end

//    // Initialize the display to show the first letter on the first display
//    initial begin
//        current_display = 8'b01111111; // Start with the first display active
//    end

endmodule
