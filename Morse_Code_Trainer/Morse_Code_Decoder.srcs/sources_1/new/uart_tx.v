`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2024 01:10:29 PM
// Design Name: 
// Module Name: uart_tx
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


module uart_tx (
    input wire clk,              // System clock (e.g., 50 MHz)
    input wire reset,            // Synchronous reset
    input wire [7:0] tx_data,    // 8-bit data to transmit
    output reg tx_serial         // UART serial output
);

    // Baud rate configuration
    localparam BAUD_TICK_COUNT = 10416; // For 9600 baud with 100 MHz clock
    reg [12:0] baud_counter;          // 13-bit counter for baud rate
    wire baud_tick;

    assign baud_tick = (baud_counter == 0);

    // UART states defined using localparam
    localparam IDLE        = 3'd0;
    localparam START_BIT   = 3'd1;
    localparam DATA_BITS   = 3'd2;
    localparam PARITY_BIT  = 3'd3;
    localparam STOP_BIT    = 3'd4;

    reg [2:0] state;            // State register
    reg [2:0] bit_index;        // Tracks the current bit in data transmission
    reg [7:0] shift_reg;        // Shift register for the data
    reg parity_bit;             // Parity bit (even parity)

    // Baud rate generator
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            baud_counter <= 0;
        end else begin
            if (baud_counter == 0) begin
                baud_counter <= BAUD_TICK_COUNT - 1;
            end else begin
                baud_counter <= baud_counter - 1;
            end
        end
    end

    // UART state machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            tx_serial <= 1'b1; // Idle line is high
            bit_index <= 3'd0;
            parity_bit <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    tx_serial <= 1'b1; // Ensure idle state (high line)
                    if (baud_tick) begin
                        shift_reg <= tx_data;       // Load data to transmit
                        parity_bit <= ^tx_data;    // Compute even parity
                        bit_index <= 3'd0;         // Reset bit index
                        state <= START_BIT;        // Move to start bit
                    end
                end

                START_BIT: begin
                    if (baud_tick) begin
                        tx_serial <= 1'b0;        // Start bit (low)
                        state <= DATA_BITS;       // Next state
                    end
                end

                DATA_BITS: begin
                    if (baud_tick) begin
                        tx_serial <= shift_reg[bit_index]; // Send current data bit
                        bit_index <= bit_index + 1;
                        if (bit_index == 3'd7) begin
                            state <= PARITY_BIT;
                        end
                    end
                end

                PARITY_BIT: begin
                    if (baud_tick) begin
                        tx_serial <= parity_bit;  // Transmit even parity bit
                        state <= STOP_BIT;        // Move to stop bit
                    end
                end

                STOP_BIT: begin
                    if (baud_tick) begin
                        tx_serial <= 1'b1;        // Stop bit (high)
                        state <= IDLE;           // Return to idle state
                    end
                end

                default: state <= IDLE;          // Safety fallback
            endcase
        end
    end
endmodule


