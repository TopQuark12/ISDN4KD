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
//    input btnC,
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
    
//    reg [1:0] enReg ;

    wire [1:0] nCS;
    
    assign nWPd = 1;
    assign nRSTd = 1;
    
    assign nCS[0] = !CS[0];
    assign nCS[1] = !CS[1];
    
    assign MISO[0] = MISOd;
    assign MISO[1] = MISOd;
    
    assign led[15:0] = sw[15:0];
    
    arbiter arb (
        .rst(btnC),
        .prio(sw[1:0]),
        .clk(clk),
        .req(REQ[1:0]),
        .using(nCS[1:0]),
        .en(enOUT[1:0])
    );
    
    mux MOSImux (
        .en(enOUT[1:0]),
        .muxIn(MOSI[1:0]),
        .muxOut(MOSId)        
    );
    
    mux CSmux (
        .en(enOUT[1:0]),
        .muxIn(CS[1:0]),
        .muxOut(CSd) 
    );
    
    mux CLKmux(
        .en(enOUT[1:0]),
        .muxIn(CLK[1:0]),
        .muxOut(CLKd) 
    );
    
endmodule
