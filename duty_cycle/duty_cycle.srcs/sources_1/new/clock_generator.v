`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2023 13:05:37
// Design Name: 
// Module Name: clock_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module clock_generator(

//    );
//endmodule

module clock_generator(f_clk,f_adc_clock,f_sw);
input f_clk;
output reg f_adc_clock,f_sw;
//parameter N_sw=499;
parameter N_sw=9999;
parameter N_adc=3;
//reg [9:0] counter1,counter2;
reg [14:0] counter1,counter2;
initial begin
counter1=0;
counter2=0;
end
always@(posedge f_clk)begin //switching frequency clock
if(counter1<=10) begin
f_sw<=1;
counter1<=counter1+1;
end
else if(counter1 == N_sw)begin
f_sw<=1;
counter1<=0;
end
else begin
f_sw<=0;
counter1<=counter1+1;
end
end

always@(posedge f_clk)begin // ADC and DAC clock
if(counter2<=0)begin
f_adc_clock<=0;
counter2<=counter2+1;
end
else if(counter2==N_adc)begin
f_adc_clock<=1;

counter2<=0;
end
else begin
f_adc_clock<=0;
counter2<=counter2+1;
end
end 


endmodule

