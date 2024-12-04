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
    input reset,                  // Reset signal
    input button,                 // Button input (active high)
    output reg [1:0] morse_one,   // Morse code input 1
    output reg [1:0] morse_two,   // Morse code input 2
    output reg [1:0] morse_three, // Morse code input 3
    output reg [1:0] morse_four,  // Morse code input 4
    output reg [1:0] morse_five,  // Morse code input 5
    output reg [1:0] morse_six,   // Morse code input 6
    output reg is_space,           // Indicator for space between letters (1 = space)
    output reg letter_done // Indicates that the letter is done
);

    localparam one_time_unit = 5; // 0.5 seconds at 100 MHz clock 50_000_000
    localparam three_time_units = 15; // 1.5 seconds at 100 MHz clock
    // localparam seven_time_units = 350_000_000; // 3.5 seconds at 100 MHz clock

    reg [31:0] counter; // Counter for button press duration
    reg [31:0] inactivity_counter; // Counter for inactivity between button presses
    reg [2:0] morse_index; // Index for Morse code symbol
    reg symbol; // Current symbol (dot or dash)
    reg button_state; // To store button press state (debouncing)

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 0;
            inactivity_counter <= 0;
            morse_index <= 0;
            morse_one <= 2'b00;
            morse_two <= 2'b00;
            morse_three <= 2'b00;
            morse_four <= 2'b00;
            morse_five <= 2'b00;
            morse_six <= 2'b00;
            is_space <= 0;
            letter_done <= 0;
            button_state <= 0;
        end else begin
            if (button) begin  // Button is pressed
                if (!button_state) begin  // Button press detected (rising edge)
                    counter <= 0; // Reset counter on new press
                    button_state <= 1; // Update button state to pressed
                end
                counter <= counter + 1; // Increment counter while button is pressed
                inactivity_counter <= 0; // Reset inactivity counter
            end else if (button_state) begin  // Button was released
                button_state <= 0; // Update button state to released
                // Determine dot or dash based on press duration
                if (counter >= one_time_unit) begin
                    symbol <= (counter >= three_time_units) ? 1 : 0; // Dash if >= 1.5s, else dot
                    case (morse_index) // Assign the symbol to the correct Morse input
                        3'd0: morse_one <= symbol ? 2'b10 : 2'b01;
                        3'd1: morse_two <= symbol ? 2'b10 : 2'b01;
                        3'd2: morse_three <= symbol ? 2'b10 : 2'b01;
                        3'd3: morse_four <= symbol ? 2'b10 : 2'b01;
                        3'd4: morse_five <= symbol ? 2'b10 : 2'b01;
                        3'd5: morse_six <= symbol ? 2'b10 : 2'b01;
                    endcase
                end
                counter <= 0; // Reset counter after button release
            end else begin
                inactivity_counter <= inactivity_counter + 1; // Count inactivity time
            end

            // Move to next symbol if time between presses is <= 0.5s
            if (inactivity_counter > 0 && inactivity_counter <= one_time_unit) begin
                if (morse_index < 6) begin
                    morse_index <= morse_index + 1;
                end
            end

            // If inactivity time > 1.5s, signal end of letter
            if (inactivity_counter >= three_time_units) begin
                letter_done <= 1; // End of letter
                // Clear unused Morse code inputs
                case (morse_index)
                    3'd0: begin
                        morse_two <= 0; morse_three <= 0; morse_four <= 0; morse_five <= 0; morse_six <= 0;
                    end
                    3'd1: begin
                        morse_three <= 0; morse_four <= 0; morse_five <= 0; morse_six <= 0;
                    end
                    3'd2: begin
                        morse_four <= 0; morse_five <= 0; morse_six <= 0;
                    end
                    3'd3: begin
                        morse_five <= 0; morse_six <= 0;
                    end
                    3'd4: begin
                        morse_six <= 0;
                    end
                endcase
                morse_index <= 0; // Reset for next letter
            end else begin
                letter_done <= 0; // Continue processing
            end
        end
    end
endmodule


