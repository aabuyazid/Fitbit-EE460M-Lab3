`timescale 1ns / 1ps

`define UNDERLINE 15

module bin2BCD(
    input [15:0] bin_value,
    input is_miles,
    output reg [15:0] BCD_value 
    );
    reg [15:0] temp;
    
    reg dec_flag = 0;

    always @ (*) begin
        temp = bin_value;
         
        if(is_miles) begin
            dec_flag = temp % 2;
            if(dec_flag) BCD_value[3:0] = 5;
            else BCD_value[3:0] = 0;
            temp = temp >> 1;
            BCD_value[7:4] = `UNDERLINE;
            BCD_value[11:8] = temp % 10;
            temp = temp/10;
            BCD_value[15:12] = temp % 10; 
        end
        else begin
            BCD_value [3:0] = temp % 10;
            temp = temp/10;
            BCD_value [7:4] = temp % 10;
            temp = temp/10;
            BCD_value [11:8] = temp % 10;
            temp = temp/10;
            BCD_value [15:12] = temp % 10;
        end
    end    
endmodule
