`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 22:15:50
// Design Name: 
// Module Name: pipe
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
module pipe(
  input clk,
  input [15:0]x,
  input [2:0] music_select,
  output reg [0:6]a_to_g,//不能在这加一位显示点 脑袋会不显示
  output reg [0:6]a_to_g_right,
  output reg [3:0]an_right,
  output reg [3:0]an,
  output reg dot
    );
    reg [20:0]clkdiv;
    wire [1:0]rank;
    reg  [3:0]digit;
    assign rank=clkdiv[20:19];
    initial begin
        an_right <= 4'b0001;
        a_to_g_right <= 7'b0110000;
        clkdiv<=21'd0;
    end
    
    always @(posedge clk)begin
        clkdiv<=clkdiv+21'd1;
    end
    always @*begin
        case(rank)
            2'd0:begin
                an<=4'b0001;
                dot<=1'b0;
            end
            2'd1:begin
                an<=4'b0010;
                dot<=1'b0;
            end
            2'd2:begin
                an<=4'b0100;
                dot<=1'b1;
            end
            2'd3:begin
                an<=4'b1000;
                dot<=1'b0;
            end
        endcase
     end
    
    always @*
      case(rank)
      2'd3:digit=x[3:0];
      2'd2:digit=x[7:4];
      2'd1:digit=x[11:8];
      2'd0:digit=x[15:12];
      endcase
     
     always @(music_select)begin
        case(music_select)
            2'b01:a_to_g_right <= 7'b0110000;
            2'b10:a_to_g_right <= 7'b1101101;
            2'b11:a_to_g_right <= 7'b1111001;
        endcase
     end
     always @*
         case(digit)
             4'd0:begin
                a_to_g<=8'b1111110;
             end
             4'd1:begin
                a_to_g<=8'b0110000;
             end
             4'd2:begin
                a_to_g<=8'b1101101;
             end
             4'd3:begin
                a_to_g<=8'b1111001;
             end
             4'd4:begin
                a_to_g<=8'b0110011;
             end
             4'd5:begin
                a_to_g<=8'b1011011;
             end
             4'd6:begin
                a_to_g<=8'b1011111;
             end
             4'd7:begin
                a_to_g<=8'b1110000;
             end
             4'd8:begin
                a_to_g<=8'b1111111;
             end
             4'd9:begin
                a_to_g<=8'b1111011;
             end
             default:begin
                a_to_g<=8'b1111110;
             end
        endcase
endmodule