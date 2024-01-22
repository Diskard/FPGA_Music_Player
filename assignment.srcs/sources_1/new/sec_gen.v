`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 22:13:49
// Design Name: 
// Module Name: sec_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 分频得到秒脉冲,一个秒脉冲发生模块
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module one_sec_count(
    input clk,
    output reg [0:6] a_to_g,
    output reg [3:0] an,
    output reg sec_out
);

    reg [25:0] n;
    initial begin
        n <= 26'b0;
    end

    always @(posedge clk) begin
        if (n == 30'd10000000) begin
            n <= 26'd0;
        end
        else begin
            n <= n + 1;
        end
    end
    
    always @(posedge clk) begin
        if(n == 30'd10000000)begin
             sec_out <= 1'b1;  // 产生脉冲
        end
        else begin
            sec_out <= 1'b0;
        end
    end

endmodule
