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
    input clock,            // 100 MHz input clock
    input quarter_sec_unit, // Unit time: 1/4 s
    input half_sec_unit,    // Unit time: 1/2 s
    input tenth_sec_unit,   // Unit time: 1/10 s
    input reset,            // Reset signal
    output reg clk_out      // Output clock
);

    reg [31:0] divisor;    // Divisor value
    reg [31:0] counter;    // 32-bit counter

    always @(*) begin
        // Select the divisor based on the inputs
        if (quarter_sec_unit && !half_sec_unit && !tenth_sec_unit)
            divisor = 25_000_000;    // 4 Hz clock
        else if (half_sec_unit && !quarter_sec_unit && !tenth_sec_unit)
            divisor = 50_000_000;    // 2 Hz clock
        else if (tenth_sec_unit && !half_sec_unit && !quarter_sec_unit)
            divisor = 10_000_000;    // 10 Hz clock
        else
            divisor = 100_000_000;   // Default is 1 Hz clock
    end

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 0;     // Reset the counter
            clk_out <= 0;     // Reset the output clock
        end else begin
            if (counter == divisor - 1) begin
                counter <= 0;         // Reset the counter
                clk_out <= ~clk_out;  // Toggle the output clock
            end else begin
                counter <= counter + 1; // Increment the counter
            end
        end
    end

endmodule


