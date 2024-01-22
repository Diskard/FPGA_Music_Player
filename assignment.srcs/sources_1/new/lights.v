`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 16:57:30
// Design Name: 
// Module Name: lights
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


module lights(
 input sec,
 input light_on,
 input clk,
 input sec_en,
 output reg[7:0] light_show
    );
    reg [3:0]cstate;
    reg [3:0]nstate;
    
    always @(posedge clk or negedge sec_en)
      if(!sec_en)
       cstate<=4'd0;
      else
       cstate<=nstate;
    
   always @(posedge sec)
      case(cstate)
       4'd0:nstate=4'd1;
       4'd1:nstate=4'd2;
       4'd2:nstate=4'd3;
       4'd3:nstate=4'd4;
       4'd4:nstate=4'd5;
       4'd5:nstate=4'd6;
       4'd6:nstate=4'd7;
       4'd7:nstate=4'd0;
       default:nstate=4'd0;
       endcase
   
    always @*        
      if(!sec_en||!light_on)
       light_show<=8'd0;
      else
        case(cstate)
          4'd0:light_show<=8'b11100000;
          4'd1:light_show<=8'b01110000;
          4'd2:light_show<=8'b00111000;
          4'd3:light_show<=8'b00011100;
          4'd4:light_show<=8'b00001110;
          4'd5:light_show<=8'b00000111;
          4'd6:light_show<=8'b10000011;
          4'd7:light_show<=8'b11000001;
          default:light_show<=8'b00000000;
          endcase      
       
endmodule
