`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 09:16:34
// Design Name: 
// Module Name: time_zhen
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


module time_zhen(
input sec,
input clk,
input run_stop,
output reg [15:0]t
    );
       reg [23:0]t_al;
      
       always @(posedge clk or negedge run_stop)
         if(run_stop || t_al[23:16]==8'b0010_0100)
          t<=16'd0;
          else
          t<=t_al[23:8];
          
       always @(posedge sec or negedge run_stop)begin
          if(run_stop)
           t_al<=24'd0;
          else if(t_al[23:16]==8'b0010_0100)
           t_al<=24'd0;
          else if(t_al[19:0]==20'b1001_0101_1001_0101_1001)begin
             t_al[19:0]<=20'd0;
             t_al[23:20]<=(t_al[23:20]+4'd1);
             end
             else if(t_al[15:0]==16'b0101_1001_0101_1001)begin
              t_al[15:0]<=16'd0;
              t_al[19:16]<=(t_al[19:16]+4'd1);
              end
              else if(t_al[11:0]==12'b1001_0101_1001)begin
                t_al[11:0]<=12'd0;
                t_al[15:12]<=(t_al[15:12]+4'd1);
                end       
             else if(t_al[7:0]==8'b0101_1001)begin
               t_al[7:0]<=8'd0;
               t_al[11:8]<=(t_al[11:8]+4'd1);
            end
          else if(t_al[3:0]==4'b1001)begin
            t_al[3:0]<=4'd0;
            t_al[7:4]<=(t_al[7:4]+4'd1);
            end
          else t_al[3:0]<=(t_al[3:0]+4'd1);
          end      
          
endmodule
