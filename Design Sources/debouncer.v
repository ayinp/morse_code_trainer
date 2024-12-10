`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 11:10:51 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer (
    input wire clock,   // 100MHz clock signal
    input wire button,  // Noisy button
    output reg clean    // Clean button
); 

    parameter max_count = 1000000;
    reg [31:0] counter;
    
    initial begin
        counter = 0;
        clean = 0;
    end
    
    always @(posedge clock) begin
        if (button == clean) begin
            counter <= 0;
        end else begin
            if (counter == max_count) begin           
                clean <= button;
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule


