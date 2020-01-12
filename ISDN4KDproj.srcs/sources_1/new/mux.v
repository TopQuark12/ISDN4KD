`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2020 04:40:30 AM
// Design Name: 
// Module Name: mux
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


module mux(
    input wire [1:0] en,
    input wire [1:0] muxIn,
    output reg muxOut
);
    
    always @ (en, muxIn) begin
    
        case (en)
            2'b01   : muxOut = muxIn[0];
            2'b10   : muxOut = muxIn[1];
            default : muxOut = 0;
        endcase
    
    end       
    
endmodule
