`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 04:43:16 PM
// Design Name: 
// Module Name: button_to_morse
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


module button_to_morse (
    input clock,                    // System clock
    input reset,                    // Reset signal
    input button,                   // Button input
    output reg [1:0] morse_one,     // Morse code input 1
    output reg [1:0] morse_two,     // Morse code input 2
    output reg [1:0] morse_three,   // Morse code input 3
    output reg [1:0] morse_four,    // Morse code input 4
    output reg [1:0] morse_five,    // Morse code input 5
    output reg letter_done,         // Indicates that the letter is done
    output reg [2:0] morse_index    // Tracks the current symbol index 
);

    // Parameters for time units
    localparam one_time_unit = 1; 
    localparam three_time_units = 2;   

    reg [31:0] inactivity_counter; // Counter for button inactivity duration
    reg [31:0] counter; // Counter for button press duration
    
    reg button_prev; // Tracks previous button state for edge detection
    
    reg [1:0] latched_morse [4:0]; // Stores bits for morse code, moves them to morse output when letter is done
    reg latched_done; // Detects when bits are done being stored
    
    always @(posedge clock or posedge reset) begin        
        if (reset) begin
            // Reset all signals
            counter <= 0;
            inactivity_counter <= 0;
            morse_index <= 3'b000;
            {morse_one, morse_two, morse_three, morse_four, morse_five} <= 0;
            letter_done <= 0;
            button_prev <= 0;
            latched_done <= 0;
            latched_morse[0] <= 0;
            latched_morse[1] <= 0;
            latched_morse[2] <= 0;
            latched_morse[3] <= 0;
            latched_morse[4] <= 0;
        end else begin  
            if (button) begin // Button is pressed
                // Reset to process new letter          
                letter_done <= 0; 
                latched_done <= 0;   
                
                counter <= counter + 1;  // Increment counter
                inactivity_counter <= 0;  // Reset inactivity counter
            end else if (!button && button_prev) begin  // Button released
                if (counter >= one_time_unit) begin
                    // Determine dot or dash based on press duration
                    if (counter >= three_time_units) begin
                        case (morse_index) // Dash
                            3'b000: latched_morse[0] <= 2'b10;
                            3'b001: latched_morse[1] <= 2'b10;
                            3'b010: latched_morse[2] <= 2'b10;
                            3'b011: latched_morse[3] <= 2'b10;
                            3'b100: latched_morse[4] <= 2'b10;
                            default begin
                                latched_morse[0] <= 2'b00; latched_morse[1] <= 2'b00; latched_morse[2] <= 2'b00;
                                latched_morse[3] <= 2'b00; latched_morse[4] <= 2'b00;
                            end
                        endcase
                    end else begin
                        case (morse_index) // Dot
                            3'b000: latched_morse[0] <= 2'b01;
                            3'b001: latched_morse[1] <= 2'b01;
                            3'b010: latched_morse[2] <= 2'b01;
                            3'b011: latched_morse[3] <= 2'b01;
                            3'b100: latched_morse[4] <= 2'b01;
                            default begin
                                latched_morse[0] <= 2'b00; latched_morse[1] <= 2'b00; latched_morse[2] <= 2'b00;
                                latched_morse[3] <= 2'b00; latched_morse[4] <= 2'b00;
                            end
                        endcase
                    end
                    morse_index <= morse_index + 1; // Increment morse_index for the next symbol
                end
           end
                
           if (!button) begin     
               // Button inactive
               inactivity_counter <= inactivity_counter + 1;
               counter <= 0;
           end                               
            
            // Detect when letter is done, code is stored in output
            if (inactivity_counter >= three_time_units && !latched_done) begin                   
                morse_one <= latched_morse[0];
                morse_two <= latched_morse[1];
                morse_three <= latched_morse[2];
                morse_four <= latched_morse[3];
                morse_five <= latched_morse[4];
                letter_done <= 1; // Detects finished letter
                latched_done <= 1; // Detects when latching is done
                case (morse_index) 
                    3'b000: begin morse_one <= 2'b00; morse_two <= 2'b00; morse_three <= 2'b00; morse_four <= 2'b00; morse_five <= 2'b00; end
                    3'b001: begin morse_two <= 2'b00; morse_three <= 2'b00; morse_four <= 2'b00; morse_five <= 2'b00; end
                    3'b010: begin morse_three <= 2'b00; morse_four <= 2'b00; morse_five <= 2'b00; end
                    3'b011: begin morse_four <= 2'b00; morse_five <= 2'b00; end
                    3'b100: begin morse_five <= 2'b00; end
                    3'b101: begin end
                    default begin 
                        morse_one <= 2'b00; morse_two <= 2'b00; morse_three <= 2'b00; morse_four <= 2'b00; morse_five <= 2'b00;
                    end
                endcase
            end
            
            if (letter_done) begin
                morse_index <= 0; 
            end                                                 
            
            button_prev <= button; // Update previous button state          
        end
    end
endmodule




