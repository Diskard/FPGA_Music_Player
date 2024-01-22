`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 14:06:52
// Design Name: 
// Module Name: time
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


module timer(
input sec,
input time_rst,
output reg carry_25,
output reg [15:0]t
    );
       always @(posedge sec or negedge time_rst)begin
          if(time_rst)
           t<=16'b0010_0101_0000_0000;
          else if(t[15:0]==16'd0)begin
           t<=16'b0010_0101_0000_0000;
           carry_25<=1'b1;
           end
          else if(t[11:0]==12'd0)begin
             t[11:8]<=4'd9;
             t[15:12]<=(t[15:12]-4'd1);
             end
          else if(t[7:0]==8'd0)begin
            t[7:4]<=4'd5;
            t[3:0]<=4'd9;
            t[11:8]<=(t[11:8]-4'd1);
            carry_25<=1'b0;
            end
          else if(t[3:0]==4'd0)begin
            t[3:0]<=4'd9;
            t[7:4]<=(t[7:4]-4'd1);
            end
          else t[3:0]<=(t[3:0]-4'd1);
          end      
          
endmodule
