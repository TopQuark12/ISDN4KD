`timescale 1ns / 1ps

module testbench();
reg rst;
reg clk;
reg [1:0] prio;
reg [1:0] req;
reg [1:0] using;
wire [1:0] en;

arbiter arb(rst, clk, prio, req, using, en);

always
    #1 clk = !clk;
    
always @ (posedge en[0])
begin 
    #1;
    using[0] = 1;
    #20
    using[0] = 0;
    req[0] = 0;
end

always @ (negedge en[0])
begin 
    using[0] = 0;
end

always @ (posedge en[1])
begin 
    #2;
    using[1] = 1;
    #10;
    using[1] = 0;
    req[1] = 0;
end

always @ (negedge en[1])
begin 
    #1;
    using[1] = 0;
end

initial 
begin

    clk = 0;
    rst = 1;
    prio = 0;
    req = 0;
    using = 0;
    #1
    
    rst = 0;
    req[0] = 1;
    #20
    
    req[1] = 1;
    #20
    
    req[1] = 1;
    #20
    
    req[0] = 1;
    #5
    req[1] = 1;
    #40

$stop;
end
endmodule
