`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 09:42:20
// Design Name: 
// Module Name: pipe2
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


module pipe2(
  input clk,
  input run_stop,
  input [15:0]x,
  output reg [6:0]a_to_g,
  output reg [3:0]an
    );
    reg [20:0]clkdiv;
    wire [1:0]rank;
    reg  [3:0]digit;
    assign rank=clkdiv[20:19];
    initial clkdiv<=21'd0;
    
    always @(posedge clk or negedge run_stop)begin
    if(run_stop)
    clkdiv<=21'd0;
    else
    clkdiv<=clkdiv+21'd1;
    end
    
    always @*begin
    if(run_stop)
      an=4'd0;
     else 
	case(rank)
	2'd0:an=4'b0001;
	2'd1:an=4'b0010;
	2'd2:an=4'b0100;
	2'd3:an=4'b1000;
    endcase
     end
    
    always @*
      case(rank)
      2'd0:digit=x[3:0];
      2'd1:digit=x[7:4];
      2'd2:digit=x[11:8];
      2'd3:digit=x[15:12];
      default:digit=4'd0;
      endcase
     
     always @*
     case(digit)
     4'd0:a_to_g=7'b1111110;
     4'd1:a_to_g=7'b0110000;
     4'd2:a_to_g=7'b1101101;
     4'd3:a_to_g=7'b1111001;
     4'd4:a_to_g=7'b0110011;
     4'd5:a_to_g=7'b1011011;
     4'd6:a_to_g=7'b1011111;
     4'd7:a_to_g=7'b1110000;
     4'd8:a_to_g=7'b1111111;
     4'd9:a_to_g=7'b1111011;
     default:a_to_g=7'b1111110;
     endcase     
endmodule
