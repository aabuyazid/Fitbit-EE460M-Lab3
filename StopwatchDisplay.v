module StopwatchDisplay(
    input clk,
    input [27:0] sev_seg_data,
    output reg [3:0] an,
    output reg [6:0] sseg,
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @ (*) begin
        case (state)
            2'b00: begin
                an = 4'b0111;
                sseg = sev_seg_data[27:21];
                next_state = 2'b01;
            end
            2'b01: begin
                an = 4'b1011;
                sseg = sev_seg_data[20:14];
                next_state = 2'b10;
            end
            2'b10: begin
                an = 4'b1101; 
                sseg = sev_seg_data[13:7];
                next_state = 2'b11;
            end
            2'b11: begin
                an = 4'b1110; 
                sseg = sev_seg_data[6:0];
                next_state = 2'b00;
            end
        endcase
    end

    always @(posedge clk) begin
        state <= next_state;
    end
    
endmodule