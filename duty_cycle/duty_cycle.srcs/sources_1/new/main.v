`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2023 13:05:05
// Design Name: 
// Module Name: main
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


module main(
    input clk,
    input vauxp6,
    input vauxn6,
    output Q_H,
    output Q_L,
    output F_sw,
    output F_adc,
    input vp_in,
    input vn_in
//    input signed[9:0]adc_data_voltage

    );
    wire signed[9:0]adc_data_voltage;
    wire enable;  
    wire ready;
    wire [15:0] data;   
    //reg [6:0] Address_in=;
    
    
//    parameter cont_out =19'sb0110010000_010000000;

    clock_generator ul(.f_clk(clk),.f_adc_clock(F_adc),.f_sw(F_sw));
    
//    assign Address_in=8'h16;
    xadc_wiz_0  XLXI_7 (
        .daddr_in(8'h16), //addresses can be found in the artix 7 XADC user guide DRP register space
        .dclk_in(F_adc), 
        .den_in(enable), 
        .di_in(0), 
        .dwe_in(0), 
        .busy_out(),                    
        .vauxp6(vauxp6),
        .vauxn6(vauxn6),
//        .vauxp7(vauxp7),
//        .vauxn7(vauxn7),
//        .vauxp14(vauxp14),
//        .vauxn14(vauxn14),
//        .vauxp15(vauxp15),
//        .vauxn15(vauxn15),
        .vn_in(vn_in), 
        .vp_in(vp_in), 
        .alarm_out(), 
        .do_out(data), 
        //.reset_in(),
        .eoc_out(enable),
        .channel_out(),
        .drdy_out(ready)
    );
    assign adc_data_voltage={data[15:6]};
    
    
    
        
    // declaration of wire and registar variables
    reg signed [9:0] N_out;//N_current_out;// saving the data form the adc
    wire signed [9:0] N_e;//,N_current_e;
    wire signed [9:0] N_ref;
    wire signed [18:0] N_con;
    
    // PID controller gain
    parameter K_p = 10'sb0100100101; // Q4.6 signed format 10 bit signed binary
    parameter K_i = 10'sb1010000011; // Q1.9 signed format
    parameter K_d = 10'sb0_000000000; // Q1.9 signed format
    
    parameter N_ref_nom = 10'sb0_011110101; // Q1.9 signed format // VrefNom
    
    
    // Output volatge from ADC and genrate error voltage
    always@(posedge F_sw)begin// capturing output voltage samples
    N_out<={adc_data_voltage[9:1],1'b0};// capturing the data from the adc// gere we are padding with zero
    
    end
    // assining N_ref
    assign N_ref=N_ref_nom;
    
    // creating error
    assign N_e=N_ref-N_out;
    
    
    

    PI_controller u2(.f_pwm(F_sw),.N_er(N_e),.N_con(N_con),.K_p(K_p),.K_i(K_i),.K_d(K_d));
    
//    parameter N_c_con = 19'sb0010000110011001100;
    DPWM_dead_time_circuit D1(
    .clk(clk),
    .f_pwm(F_sw),
    .cont_out(N_con),
    .Q_H(Q_H),
    .Q_L(Q_L)
    );
    
    ila_0 ila_capture (
	.clk(clk), // input wire clk

	.probe0(F_adc), // input wire [0:0]  probe0  
	.probe1(data), // input wire [0:0]  probe1 
	.probe2(N_e), // input wire [0:0]  probe2 
	.probe3(N_con), // input wire [0:0]  probe3 
	.probe4(Q_H), // input wire [0:0]  probe4 
	.probe5(Q_L), // input wire [0:0]  probe5 
	.probe6(adc_data_voltage) // input wire [1:0]  probe6 
//	.probe7(ch_out), // input wire [4:0]  probe7 
//	.probe8(daddr), // input wire [6:0]  probe8 
//	.probe9(dout) // input wire [15:0]  probe9
);     
endmodule
