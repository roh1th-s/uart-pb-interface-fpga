`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 12:26:35
// Design Name: 
// Module Name: D_ff
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

module d_ff( input logic clk,reset,//slow clock
             input logic d,//button
             output logic q
           );
    always@(posedge clk,posedge reset) begin
        if(reset) begin
            q<=0;
        end else begin
            q<=d;
        end
    end
endmodule
