`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2024 20:00:21
// Design Name: 
// Module Name: transmitter
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


module transmitter # (
    parameter BAUD_RATE = 921600
) (
    input  logic       clk,   // baud rate
    input  logic       enable,
    input  logic       start, // start of transaction
    input  logic [7:0] in,    // data to transmit
    output logic        out   // tx
);
    localparam BAUD_RATE_DIV = 100_000_000 / BAUD_RATE;

    typedef enum logic [2:0] {IDLE, START_BIT, DATA_BITS, STOP_BIT, RESET} uart_state;
    uart_state state  = RESET;
    logic [7:0] data   = 8'b0; // to store a copy of input data
    logic [2:0] bitIdx = 3'b0; // bit counter
    logic [2:0] idx;
    logic [15:0] baud_rate_counter;
    
    assign idx = bitIdx;

    always @(posedge clk) begin
        case (state)
            default     : begin
                state   <= IDLE;     
            end
            IDLE       : begin
                out     <= 1'b1; // keep at high for idle 
                bitIdx  <= 3'b0;
                data    <= 8'b0;
                baud_rate_counter <= 0;
                
                if (start) begin
                    data    <= in; // save a copy of input data
                    state   <= START_BIT;
                end
            end
            START_BIT  : begin
                out     <= 1'b0; // Send start bit (low)
                state   <= DATA_BITS;
            end
            DATA_BITS  : begin // Send out data bits 
                if (baud_rate_counter < BAUD_RATE_DIV - 1)
                    baud_rate_counter <= baud_rate_counter + 1;
                //if (baud_rate_counter >= BAUD_RATE_DIV) begin
                else begin
                    baud_rate_counter <= 0;
                    out <= data[idx];
                    if (&bitIdx) begin
                        bitIdx  <= 3'b0;
                        state   <= STOP_BIT;
                    end else begin
                        bitIdx  <= bitIdx + 1'b1;
                    end
                end
            end
            STOP_BIT   : begin // Send out Stop bit (high)
                if (baud_rate_counter < BAUD_RATE_DIV - 1)
                    baud_rate_counter <= baud_rate_counter + 1;
                //if (baud_rate_counter >= BAUD_RATE_DIV) begin
                else begin
                    baud_rate_counter <= 0;
                    out <= 1'b1;
                    data    <= 8'b0;
                    state   <= IDLE;
                end
            end
        endcase
    end

endmodule
