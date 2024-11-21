`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 12:28:04
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


module debouncer(
    input logic clk,reset,//normal clock
    input logic pb,//push button
    output logic button//output to button
    );
    logic clk_out;
    logic q1;
    
    slow_clock sclk1(.clk(clk),
                       .reset(reset),
                       .clk_out(clk_out));
                       
    d_ff d1(.clk(clk_out),
              .reset(reset),
              .d(pb),
              .q(q1));
              
    d_ff d2(.clk(clk_out),
              .reset(reset),
              .d(q1),
              .q(button));
endmodule
