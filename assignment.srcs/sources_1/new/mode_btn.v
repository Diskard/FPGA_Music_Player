`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 10:30:02
// Design Name: 
// Module Name: debounce_b
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


module debounce_s0(
input clk,
input run_stop,
input key_in,
output wire key_out
    );
 reg key_value;
 reg key_p_flag;
 reg key_reg;
 reg [20:0]delay_cnt;
 parameter DELAY_TIME=21'd1500000;

//key_reg:按键输入寄存器
always@(posedge clk or negedge run_stop)
if(!run_stop)
    key_reg<=1'b0;
else
    key_reg<=key_in;

//delay_cnt:延时计数器
always@(posedge clk or negedge run_stop)
    if(!run_stop)
        delay_cnt<=21'b0;
    else if(key_in!=key_reg)
        delay_cnt<=DELAY_TIME;
    else if(delay_cnt>0)
        delay_cnt<=delay_cnt-1'b1;
    else
        delay_cnt<=21'd0;
        
//key_value
always@(posedge clk or negedge run_stop)
    if(!run_stop)
        key_value<=1'b0;
    else if(delay_cnt==1'b1)
        key_value<=key_in;
    else
        key_value<=key_value;

//key_p_falg:按键上升沿标志信号
always@(posedge clk or negedge run_stop)
    if(!run_stop)
        key_p_flag<=1'b0;
    else if(delay_cnt==1'b1&&key_in==1)
        key_p_flag<=1'b1;
    else
        key_p_flag<=1'b0;

assign key_out=key_p_flag;
endmodule
