`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SDU
// Engineer: Ziyu Hao
// 
// Create Date: 2023/12/11 17:59:05
// Design Name: counter
// Module Name: counter
// Project Name: 
// Target Devices: EGO1
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


module counter(
    input clk,
    input cnt_1ms,
    output reg m_sec_clk
    );
    
    reg [25:0] cnt;
    
    always @(posedge clk)
    begin
        if(cnt ==  26'd50000) begin // 1ms
            cnt <= 26'd0; 
        end
        else begin
            cnt <= cnt + 26'd1;
        end
    end
    
    always @(posedge clk)
    begin
        if(cnt ==  26'd50000) begin
            m_sec_clk <= ~m_sec_clk; 
        end
    end
    
endmodule
