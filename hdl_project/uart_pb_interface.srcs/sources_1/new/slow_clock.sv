`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 12:29:13
// Design Name: 
// Module Name: slow_clock
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


module slow_clock(
    input logic clk,
    input logic reset,
    output logic clk_out
);
    logic [20:0]count;
    
    always @(posedge clk,posedge reset) begin 
        if(reset) begin
            count<=0;
            clk_out<=0;
        end else begin
        if(count[20]==1) begin
            clk_out=~clk_out;
            count<=0;
        end else
            count<=count+1;
        end
    end
endmodule
