`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 09:52:10
// Design Name: 
// Module Name: sec_gen_zhen
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


module sec_gen_zhen(
input clk,
output reg sec_con
    );
    reg [25:0] n;
         
    always @(posedge clk)
    begin
    if(n==26'd5000000)
    n<=26'd1;
    else
    n<=(n+26'd1);
    end
  
    always @(posedge clk)
    begin
    if(n==26'd5000000)
    sec_con<=~sec_con;
    else
    sec_con<=sec_con;
    end
         
endmodule
