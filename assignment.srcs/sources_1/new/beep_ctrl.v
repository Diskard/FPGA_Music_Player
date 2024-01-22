`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 21:40:49
// Design Name: 
// Module Name: beep_ctrl
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


module beep_ctrl(
    input beep_1,
    input beep_2,
    input beep_3,
    input wire [1:0]music_select,
    output reg beep
    );
    always@(*)begin
        if(2'b01 == music_select)begin
            beep <= beep_1;
        end else if (2'b10 == music_select)begin
            beep <= beep_2;
        end else if (2'b11 == music_select)begin
            beep <= beep_3;
        end
    end
endmodule
