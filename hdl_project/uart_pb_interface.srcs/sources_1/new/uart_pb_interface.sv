`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 15:56:59
// Design Name: 
// Module Name: uart_pb_interface
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

// UART Push button Interface

module uart_pb_interface(
    input logic btnC, btnU, btnR, btnD, btnL,
    input logic clk,
    output logic TxD,
    output logic  transmit
    ); 

    localparam int CENTER = 3'b000, UP = 3'b001, RIGHT = 3'b010, DOWN = 3'b011, LEFT = 3'b100;

    // 5-bit arrays to store button states
    logic btn_down [4:0];
    logic btn_triggers [4:0];
    
    // debouncing required to prevent detecting multiple button presses
    debouncer center_btn (clk, 0, btnC, btn_down[CENTER]);
    detect_btn_up handle_center (clk, btn_down[CENTER], btn_triggers[CENTER]);
    
    debouncer up_btn (clk, 0, btnU, btn_down[UP]);
    detect_btn_up handle_up(clk, btn_down[UP], btn_triggers[UP]);
    
    debouncer right_btn (clk, 0, btnR, btn_down[RIGHT]);
    detect_btn_up handle_right(clk, btn_down[RIGHT], btn_triggers[RIGHT]);
    
    debouncer down_btn (clk, 0, btnD, btn_down[DOWN]);
    detect_btn_up handle_down(clk, btn_down[DOWN], btn_triggers[DOWN]);
    
    debouncer left_btn (clk, 0, btnL, btn_down[LEFT]);
    detect_btn_up handle_left (clk, btn_down[LEFT], btn_triggers[LEFT]);
    
    logic [7:0] data;
    logic start;
    always_comb begin
        data = 0;
        start = 0;
        for(int i = 0; i < 5; i++) begin
            if (btn_triggers[i]) begin
                data = i;
                start = 1;
                break;
            end
        end
    end
    
    transmitter T1 (.clk(clk), .enable(1), .start(start), .in(data), .out(TxD));
    
    assign transmit = start;
endmodule

