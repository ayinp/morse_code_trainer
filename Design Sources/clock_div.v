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


module clock_div(
    input clock,               // 100 MHz input clock
    input one_sec_unit,        // Select 2 Hz clock
    input half_sec_unit,       // Select 4 Hz clock
    input quarter_sec_unit,    // Select 8 Hz clock
    input reset,               // Reset signal
    output reg clk_out         // Output clock
);

    // Parameters for divisors
    localparam ONE_SEC_DIV = 50_000_000; // 2 Hz
    localparam HALF_SEC_DIV = 25_000_000; // 4 Hz
    localparam QUARTER_SEC_DIV = 12_500_000; // 8 Hz
    localparam DEFAULT_DIV = 100_000_000; // 1 Hz (fallback)

    reg [31:0] divisor;    // Selected divisor value
    reg [31:0] counter;    // 32-bit counter

    // Determine divisor based on inputs
    always @(*) begin
        // Prioritize inputs to prevent conflicts
        if (one_sec_unit && !half_sec_unit && !quarter_sec_unit)
            divisor = ONE_SEC_DIV; // (1.0s)
        else if (half_sec_unit && !one_sec_unit && !quarter_sec_unit)
            divisor = HALF_SEC_DIV; // (0.5s)
        else if (quarter_sec_unit && !half_sec_unit && !one_sec_unit)
            divisor = QUARTER_SEC_DIV; // (0.25a)
        else
            divisor = DEFAULT_DIV; // Default: (2s)
    end

    // Clock divider logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 0;         // Reset the counter
            clk_out <= 0;         // Reset the output clock
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





