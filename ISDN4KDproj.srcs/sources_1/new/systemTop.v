`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2020 02:47:54 PM
// Design Name: 
// Module Name: systemTop
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


module systemTop(    
    input clk,
    input btnC,
    input [15:0] sw,    
    output [15:0] led    
    );
    
    assign led[15:0] = sw[15:0];
    
    arbiter arb (
    
    );
    
    spiGen dev1 (
    
    );
    
    spiGen dev2 (
    
    );
    
    mux MOSImux (
    
    );
    
    mux CSmux (
    
    );
    
    mux CLKmux(
    
    );
    
endmodule
