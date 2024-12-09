`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 03:25:10 PM
// Design Name: 
// Module Name: morse_decoder
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

module morse_decoder (
    input [1:0] morse_one,   // . = 01, - = 10
    input [1:0] morse_two,   // . = 01, - = 10
    input [1:0] morse_three, // . = 01, - = 10
    input [1:0] morse_four,  // . = 01, - = 10
    input [1:0] morse_five,  // . = 01, - = 10
    input [1:0] morse_six,   // . = 01, - = 10
    input letter_done,       // Detect if letter is done
    input is_space,          // Detects a space
    input is_delete,
    output reg [7:0] ascii_char // ASCII character output
);

    // Register to hold the last valid character
    reg [7:0] last_valid_char;
    
    initial begin
        last_valid_char = "-";
    end
    
    always @(*) begin

        // Default: Hold the last valid character
        ascii_char = last_valid_char;
    
        // If space is valid, ascii_char = space
        if (is_space) begin
            ascii_char = ascii_char;
            last_valid_char = ascii_char;
        end else if (is_delete) begin
            ascii_char = 8'h7f;
            last_valid_char = ascii_char;
        end else if (letter_done) begin         
            // Start traversal of binary tree
            if (morse_one == 2'b01) begin // Dot (E branch)
                if (morse_two == 2'b01) begin // Dot (I branch)
                    if (morse_three == 2'b01) begin // Dot (S branch)
                        if (morse_four == 2'b01) begin // Dot (H branch)
                            if (morse_five == 2'b01) begin // Dot
                                ascii_char = "5"; // ......
                            end else if (morse_five == 2'b10) ascii_char = "4"; // .....-
                            else ascii_char = "H"; // ....
                        end else if (morse_four == 2'b10) // ...-
                            if (morse_five == 2'b01) begin // Dot
                                if (morse_six == 2'b01) ascii_char = " "; // ......
                            end else if (morse_five == 2'b10) ascii_char = "3"; // .....-
                            else ascii_char = "V"; // ....
                        else ascii_char = "S"; // ...
                    end else if (morse_three == 2'b10) begin // Dash (U branch)
                        if (morse_four == 2'b01) ascii_char = "F"; // ..-.
                        else if (morse_four == 2'b10) ascii_char = "2"; // ..---
                        else ascii_char = "U"; // ..-
                    end else ascii_char = "I"; // ..
                end else if (morse_two == 2'b10) begin // Dash (A branch)
                    if (morse_three == 2'b01) begin // Dot (R branch)
                        if (morse_four == 2'b01) ascii_char = "L"; // .-..
                        else ascii_char = "R"; // .-.
                    end else if (morse_three == 2'b10) begin // Dash (W branch)
                        if (morse_four == 2'b01) ascii_char = "P"; // .--.
                        else if (morse_four == 2'b10) 
                            if (morse_five == 2'b10)
                                ascii_char = "1"; // .---
                            else
                                ascii_char = "J";
                        else ascii_char = "W"; // .--
                    end else ascii_char = "A"; // .-
                end else ascii_char = "E"; // .
            end else if (morse_one == 2'b10) begin // Dash (T branch)
                if (morse_two == 2'b01) begin // Dot (N branch)
                    if (morse_three == 2'b01) begin // Dot (D branch)
                        if (morse_four == 2'b01) 
                            if (morse_five == 2'b01)
                                ascii_char = "6"; // -...
                            else
                                ascii_char = "B";
                        else if (morse_four == 2'b10) ascii_char = "X"; // -..-
                        else ascii_char = "D"; // -..
                    end else if (morse_three == 2'b10) begin // Dash (K branch)
                        if (morse_four == 2'b01) ascii_char = "C"; // -.-.
                        else if (morse_four == 2'b10) ascii_char = "Y";
                        else ascii_char = "K"; // -.-
                    end else ascii_char = "N"; // -.
                end else if (morse_two == 2'b10) begin // Dash (M branch)
                    if (morse_three == 2'b01) begin // Dot (G branch)
                        if (morse_four == 2'b01) 
                            if (morse_five == 2'b01)
                                ascii_char = "7";
                            else
                                ascii_char = "Z"; // --..
                        else if (morse_four == 2'b10) ascii_char = "Q"; // --...
                        else ascii_char = "G"; // --.
                    end else if (morse_three == 2'b10) begin // Dash (O branch)
                        if (morse_four == 2'b01) ascii_char = "8"; // ---..
                        else if (morse_four == 2'b10) begin
                            if (morse_five == 2'b10) ascii_char = "0"; // -----
                            else ascii_char = "9"; // ----.
                        end else ascii_char = "O"; // ---
                    end else ascii_char = "M"; // --
                end else ascii_char = "T"; // -
            end
            // Update the last valid character when a new letter is done
            last_valid_char = ascii_char;
        end
    end
endmodule




