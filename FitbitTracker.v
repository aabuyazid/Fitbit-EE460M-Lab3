module FitbitTracker(CLK,pulse,reset,display,decimal_number,SI);

input CLK, pulse, reset;
output [15:0] display;  
output decimal_number, SI;

reg second = 0;

reg [26:0] second_divider = 0;
reg display_change = 0;
reg [1:0] display_mode = 0;

reg [3:0] nine_seconds_counter = 0;
reg [7:0] steps_per_sec = 0;
reg [31:0] total_steps = 0;

reg [15:0] high_activity_counter = 0;
reg [15:0] distance_traveled = 0;
reg [15:0] over32_time = 0;
reg [15:0] over32_highest_time = 0;


/* 
Defines a second based on CLK
*/
always @(posedge CLK) 
begin
    if(second_divider == 500000) second = second + 1;
    second_divider = second_divider + 1;
end


/* 
Updates total_steps and distance_traveled
*/
always @(pulse, reset) 
begin
    if(reset) total_steps = 0;
    else if(pulse) total_steps = total_steps + 1;
    else total_steps = total_steps;
    distance_traveled = total_steps >> 10;
end

/*
Updates steps_per_sec
*/
always @(pulse, reset) 
begin
    if(reset) steps_per_sec = 0;
    else if(pulse) steps_per_sec = steps_per_sec + 1;
    else steps_per_sec = steps_per_sec;
end

always @(posedge second)
begin
    steps_per_sec = 0;
end
endmodule
