`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 05:05:39 PM
// Design Name: 
// Module Name: clock_div
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


module clock_divider(
    input clock,      // 100 MHz input clock
    input reset,      // Reset signal
    output reg clk_out // 2 Hz output clock
);

    // 50 million counter value for 2 Hz clock (100 MHz / 2 Hz = 50 million)
    localparam DIVISOR = 50_000_000;

    reg [31:0] counter; // 32-bit counter to count up to 50 million

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 0;     // Reset the counter
            clk_out <= 0;     // Reset the output clock
        end else begin
            if (counter == DIVISOR - 1) begin
                counter <= 0;         // Reset the counter
                clk_out <= ~clk_out;  // Toggle the output clock
            end else begin
                counter <= counter + 1; // Increment the counter
            end
        end
    end

endmodule

