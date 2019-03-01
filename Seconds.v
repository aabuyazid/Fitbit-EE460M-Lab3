`timescale 1ns / 1ps

module Seconds(pulseBase, seconds);
    input pulseBase;
    output seconds;
    
    // half of 100MHz/1
    `define countSec 26'd50000000
    reg [25:0] count;
    reg pulseIt;
    initial begin
        count = 0;
        pulseIt = 0;
    end
    assign seconds = pulseIt;
    
    always@(posedge pulseBase) begin
        if (count == `countSec) begin
            pulseIt = ~pulseIt;
            count = 1;
        end
        else count = count + 1;
    end
endmodule
