`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SDU
// Engineer: Ziyu Hao
// 
// Create Date: 2023/12/11 20:08:34
// Design Name: counter_1s
// Module Name: counter_1s
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


module counter_1s(
        input a_second,
        output reg second_clk
    );

    reg [15:0] n;

    always @(posedge a_second)
    begin
        if(n == 16'd500) begin
            n <= 16'd0;
        end
        else begin
            n <= n + 16'd1;
        end
    end

    always @(posedge a_second)
    begin
        if(n == 16'd500) begin
            second_clk <= ~second_clk;
        end
        else begin
            second_clk <= second_clk;
        end
    end

endmodule
