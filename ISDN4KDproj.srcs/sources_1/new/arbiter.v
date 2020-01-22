`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2020 03:02:08 PM
// Design Name: 
// Module Name: arbiter
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

module arbiter(
    input wire rst,                 //Reset
    input wire clk,                 //Clock
    input wire [1:0] prio,          //Priority switch
    input wire [1:0] req,           //Device request
    input wire [1:0] using,         //Device using channel
    output reg [1:0] en             //Enable usage
);
localparam RR = 400000;
reg switch;                                             //Switch request
reg target;                                             //Target requested
reg [2:0] cnt;                                          //Counter
integer i;
always @(posedge clk) begin
    if (rst) begin                                      //Reset control
        switch <= 0;                                    //Reser switch request
        cnt <= 0;                                       //Reset counter
        for (i = 0; i < 2; i = i + 1)                   
            en[i] <= 0;                                 //disable both device
    end else begin
        if (switch) begin                               //Switching requested
            if (!using[!target]) begin                  //Channel not occupied
                for (i = 0; i < 2; i = i + 1)           //Switch channel
                    en[i] <= target == i;
                switch <= 0;                            //Reset switch req
                cnt <= 0;                               //Reset counter
            end
        end else begin                                  //Switching not req
            if (using[target]) begin                    //Targete using channel
                if (cnt == RR && req[!target]) begin    //Time out + !target req
                    switch <= 1;                        //Req switch
                    en[target] <= 0;                    //disable target
                    target <= !target;                  //swap target
                end else if (cnt != RR)                 //not yet timeout
                    cnt <= cnt + 1;                     //inc counter
            end 
//            else begin                                  //target not using channel
//                for (i = 0; i < 2; i = i + 1)           //disable both device
//                    en[i] <= 0;                         
//                cnt <= 0;                               //reset counter
//            end
            for (i = 0; i < 2; i = i + 1) begin
                if (!using[i] && (prio[!i] || !en[!i]) && req[!i]) begin        //!en[i] -> !using[i]
                    switch <= 1;
                    target = !i;
                    en[i] <= 0;
                end
            end
        end
    end
end
endmodule
