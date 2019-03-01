`timescale 1ns / 1ps

module Full_Pulse(start, reset, select, pulseBase, pulseOut);
    input start, reset, pulseBase;
    output pulseOut;
    input [1:0] select;
    
    reg [25:0] count, countComp, prevComp;
    reg [9:0] clock;
    reg pulseIt, stop;
    wire sec;//, stop;
    initial begin
        count = 0;
        pulseIt = 0;
        clock = 0;
        countComp = 0;
    end
    
    Seconds t1 (pulseBase, sec);
    assign pulseOut = pulseIt;
    
    always@(posedge start, posedge reset) begin
        if (reset) begin
            stop <= 1;
        end
        else begin
            stop <= 0;
        end
    end
    //assign stop = reset | ~start;
    always@(posedge sec) begin
        if ((select == 2'b11) & ~stop) clock = clock + 1;
            else
                clock = 0;
    end
    
    always@(clock, select) begin
            if (select == 2'b00)
                countComp <= 22'd1562500;//32/s
            else begin
            if (select == 2'b01)
                countComp <= 22'd781250;//64/s
            else begin
            if (select == 2'b10)
                countComp <= 22'd390625;//128/s
            else begin
            if ((select == 2'b11) & (clock == 0))
                countComp <= 22'd2500000;//20/s
            else begin
            if ((select == 2'b11) & (clock == 1))
                countComp <= 22'd1515152;//33/s
            else begin
            if ((select == 2'b11) & ((clock == 2)|(clock == 8)))
                countComp <= 22'd757576;//66/s
            else begin
            if ((select == 2'b11) & (clock == 3))
                countComp <= 22'd1851852;//27/s
            else begin
            if ((select == 2'b11) & (clock == 4))
                countComp <= 22'd714286;//70/s
            else begin
            if ((select == 2'b11) & ((clock == 5)|(clock == 7)))
                countComp <= 22'd1666667;//30/s
            else begin
            if ((select == 2'b11) & (clock == 6))
                countComp <= 22'd2631579;//19/s
            else begin
            if ((select == 2'b11) & (8 < clock) & (clock < 74))
                countComp <= 22'd724638;//69/s
            else begin
            if ((select == 2'b11) & (73 < clock) & (clock < 80))
                countComp <= 22'd1470588;//34/s
            else begin
            if ((select == 2'b11) & (79 < clock) & (clock < 145))
                countComp <= 22'd403226;//124/s
            else begin
                countComp <= 0;
            end end end end end end end end end end end end end 
    end
    
    always@(posedge pulseBase) begin
        if(countComp != prevComp) begin
            count <= 2;
            prevComp <= countComp;
        end else begin
        if(~stop && countComp) begin
            if ((count == countComp) ) begin
                pulseIt <= ~pulseIt;
                count <= 1;
            end
            else count <= count + 2;
        end
        end
    end
endmodule
