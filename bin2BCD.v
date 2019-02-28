`define UNDERLINE 15

module bin2BCD(
    input [15:0] bin_value,
    input is_miles,
    output reg [15:0] BCD_value 
    );
    
    reg [15:0] temp;
    
    always @ (*) 
        temp = bin_value;   
        if(is_miles) begin
            if(temp % 2 == 1) BCD_value[3:0] = 5;
            else BCD_value[3:0] = 0;
            temp = temp >> 1;
            BCD_value[7:4] = UNDERLINE;
            BCD_value[11:8] = temp % 10;
            temp = temp/10;
            BCD_value[15:12] = temp % 10; 
        end
        else begin
            BCD_value[3:0] = temp % 10;
            temp = temp/10;
            BCD_value[7:4] = temp % 10;
            temp = temp/10;
            BCD_value[11:8] = temp % 10;
            temp = temp/10;
            BCD_value[15:12] = temp % 10;
        end
    end
        
endmodule
