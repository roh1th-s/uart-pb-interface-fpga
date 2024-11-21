`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 15:43:36
// Design Name: 
// Module Name: detect_btn_up
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


module detect_btn_up(
        input logic clk, btn_down, 
        output logic btn_trigger
    );
    
    logic btn_down_reg = 0; // used to detect button release
    
    always_ff @ (posedge clk) begin
        if (btn_trigger == 1)
            btn_trigger <= 0;
            
        if (btn_down)
            btn_down_reg <= 1;
            
        if (btn_down_reg && !btn_down) begin
            btn_trigger <= 1;  
            btn_down_reg <= 0;
        end  
    end
endmodule
