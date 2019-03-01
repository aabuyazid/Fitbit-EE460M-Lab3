`timescale 1ns / 1ps

module SSEGClkDivider(
    input clk,
    output slow_clk
);

reg [18:0] COUNT; // Arbitrary number, GO CHANGE IT
    
assign slow_clk = COUNT[18];
    
always @(posedge clk) begin
    COUNT = COUNT + 1;
end