`timescale 1ns / 1ps

module Seconds(pulseBase, seconds);
    input pulseBase;
    output seconds;
    
    // half of 100MHz/60
    `define countSec 20'b11001011011100110101
    reg [19:0] count;
    reg pulseIt;
    initial begin
        count = 0;
        pulseIt = 0;
    end
    assign seconds = pulseIt;
    
    always@(posedge pulseBase) begin
        if (count == `countSec) begin
            pulseIt = ~pulseIt;
            count = 0;
        end
        else count = count + 1;
    end
endmodule