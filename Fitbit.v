`timescale 1ns / 1ps

module Fitbit(
    input CLK,
    input start,
    input reset,
    input [1:0] select,
    output [6:0] sseg,
    output [3:0] an,
    output SI,
    output dp
    );

assign dp = 1;

wire pulseOut;

wire [15:0] display;

wire is_miles;

SquarePulse square (.CLK(CLK), .start(start), 
    .reset(reset), .select(select), .pulse(pulseOut));

/*
Full_Pulse pulse (.start(start), .reset(reset), .select(select),
    .pulseBase(CLK), .pulseOut(pulseOut));
*/

FitbitTracker fit (.clk(CLK), .pulse(pulseOut), .reset(reset),
    .display(display), .is_miles(is_miles),.SI(SI));

DisplayController dis (.clk(CLK), .fitbit_data(display), 
    .is_miles(is_miles), .an(an), .sseg(sseg));
    
endmodule
