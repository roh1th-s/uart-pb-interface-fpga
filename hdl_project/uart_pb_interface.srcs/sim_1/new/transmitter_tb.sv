`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 13:43:21
// Design Name: 
// Module Name: transmitter_tb
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


module transmitter_tb();
    logic clk; //UART input clock
    logic enable; // reset signal
    logic transmit; //btn signal to trigger the UART communication
    logic [7:0] data; // data transmitted
    logic TxD; // Transmitter serial output. TxD will be held high during reset, or when no transmissions aretaking place. 

    transmitter #(
       .BAUD_RATE(100_000_000) // for testing
    ) dut (.clk(clk), .enable(1), .start(transmit),.in(data),.out(TxD));
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        enable = 0;
        # 10
        enable = 1;
        data = 8'b00010010;
        
        transmit = 0;
        # 10
        transmit = 1;
        # 10
        transmit = 0;
        # 400
        $finish;
        //$stop;
    end
endmodule