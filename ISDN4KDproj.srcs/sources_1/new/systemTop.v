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
    output [15:0] led,
    
    input [1:0] REQ,
    input [1:0] MOSI,
    input [1:0] CS,  
    input [1:0] CLK,
    output [1:0] MISO,
    output [1:0] enOUT,
    
    output MOSId,
    output CSd,  
    output CLKd,
    output nRSTd,
    output nWPd,
    input MISOd
       
    );
    
    reg [1:0] enReg ;
    
    assign led[15:0] = sw[15:0];
    
    arbiter arb (
        .rst(btnC),
        .prio(sw[1:0]),
        .clk(clk),
        .req(REQ[1:0]),
        .using(CS[1:0]),
        .en(enReg[1:0])
    );
    
    mux MOSImux (
        .en(enReg[1:0]),
        .muxIn(MOSI[1:0]),
        .muxOut(MOSId)        
    );
    
    mux CSmux (
        .en(enReg[1:0]),
        .muxIn(CS[1:0]),
        .muxOut(CSd) 
    );
    
    mux CLKmux(
        .en(enReg[1:0]),
        .muxIn(CLK[1:0]),
        .muxOut(CLKd) 
    );
    
endmodule
