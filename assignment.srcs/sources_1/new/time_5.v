`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 15:24:45
// Design Name: 
// Module Name: time_5
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


module time_5(
input sec,
input clk,
input min5_en,
output reg carry_5,
output reg [4:0]light_5
    );
    reg [11:0]t;
       always @(posedge clk or negedge min5_en)
         if(!min5_en)
          light_5<=5'd0;
         else case(t[11:8])
          4'd0:light_5<=5'b10000;
          4'd1:light_5<=5'b11000;
          4'd2:light_5<=5'b11100;
          4'd3:light_5<=5'b11110;
          4'd4:light_5<=5'b11111;
          4'd5:light_5<=5'b11111;
          default:light_5<=5'b00000;
          endcase
          
       always @(posedge sec or negedge min5_en)begin
          if(!min5_en)begin
           t<=16'b0101_0000_0000;
           carry_5<=1'b0;
           end
          else if(t[11:0]==11'd0)begin
           t<=16'b0101_0000_0000;
           carry_5<=1'b1;
           end
          else if(t[7:0]==8'd0)begin
            t[7:4]<=4'd5;
            t[3:0]<=4'd9;
            t[11:8]<=(t[11:8]-4'd1);
            carry_5<=1'b0;
            end
          else if(t[3:0]==4'd0)begin
            t[3:0]<=4'd9;
            t[7:4]<=(t[7:4]-4'd1);
            end
          else t[3:0]<=(t[3:0]-4'd1);
          end      
          
endmodule
