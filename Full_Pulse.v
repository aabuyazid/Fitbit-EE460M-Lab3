`timescale 1ns / 1ps

module Full_Pulse(start, reset, select, pulseBase, pulseOut);
    input start, reset, pulseBase;
    output pulseOut;
    input [1:0] select;
    
    //half of 100MHz/32
    `define count32 21'b101111101011110000100
    // half of 100MHz/64
    `define count64 20'b10111110101111000010
    // half of 100MHz/128
    `define count128 19'b1011111010111100001
    // half of 100Mz/20
    `define count20 22'b1001100010010110100000
    //half of 100Mz/33
    `define count33 21'b101110001111010010000
    //half of 100Mz/66
    `define count66 20'b10111000111101001000
    //half of 100Mz/27
    `define count27 21'b111000100000111001100
    //half of 100Mz/70
    `define count70 20'b10101110011000101110
    //half of 100Mz/30
    `define count30 21'b110010110111001101011
    //half of 100Mz/19
    `define count19 22'b1010000010011110011011
    //half of 100Mz/69
    `define count69 20'b10110000111010011110
    //half of 100Mz/34
    `define count34 21'b101100111000001111100
    //half of 100Mz/124
    `define count124 19'b1100010011100011010
    reg [21:0] count, countComp;
    reg [9:0] clock;
    reg pulseIt, run;
    wire sec;
    initial begin
        count = 0;
        pulseIt = 0;
        clock = 0;
        run = 0;
        countComp = `count32;
    end
    
    Seconds t1 (pulseBase, sec);
    assign pulseOut = pulseIt;
    always@(posedge start, posedge reset) begin
        if (start) begin 
            run = 1;
            count = 0;
        end else
            run = 0;
    end
    always@(posedge sec) begin
        if (select == 2'b11) clock = clock + 1;
            else begin
                clock = 0;
                run = 1;
            end
    end
    always@(select) begin
        case({clock, select})
            12'b000000000000 : countComp = `count32;
            12'b000000000001 : countComp = `count64;
            12'b000000000010 : countComp = `count128;
            12'b000000000011 : countComp = `count20;
            12'b000000000111 : countComp = `count33;
            12'b000000001011 : countComp = `count66;
            12'b000000001111 : countComp = `count27;
            12'b000000010011 : countComp = `count70;
            12'b000000010111 : countComp = `count30;
            12'b000000011011 : countComp = `count19;
            12'b000000011111 : countComp = `count30;
            12'b000000100011 : countComp = `count33;
            12'b000000100111 : countComp = `count69;
            12'b000000101011 : countComp = `count69;
            12'b000000101111 : countComp = `count69;
            12'b000000110011 : countComp = `count69;
            12'b000000110111 : countComp = `count69;
            12'b000000111011 : countComp = `count69;
            12'b000000111111 : countComp = `count69;
            12'b000001XXXX11 : countComp = `count69;
            12'b00001XXXXX11 : countComp = `count69;
            12'b0001000XXX11 : countComp = `count69;
            12'b000100100X11 : countComp = `count69;
            12'b000100101X11 : countComp = `count34;
            12'b000100110X11 : countComp = `count34;
            12'b000100111X11 : countComp = `count34;
            12'b000101XXXX11 : countComp = `count124;
            12'b00011XXXXX11 : countComp = `count124;
            12'b001000XXXX11 : countComp = `count124;
            12'b001001000011 : countComp = `count124;
            default : begin
                countComp = 20'b11111111111111111111;
                run = 0;
            end
        endcase
        count = 0;
    end
    always@(posedge pulseBase) begin
        if ((count == countComp) & run) begin
            pulseIt <= ~pulseIt;
            count <= 0;
        end
        else count <= count + 1;
    end
endmodule
