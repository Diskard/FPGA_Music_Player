`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/28 15:48:07
// Design Name: 
// Module Name: music_count_down
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


module music_count_down(  
    input next_song,  // 信号用于切换到下一首歌
    input last_song,
    input clk,
    input rst,
    input sec_in,
    input mode_song,
    output reg music_end,
    input [1:0] music_select,
    output reg [15:0] display
);

    reg [15:0] counter;
    reg [15:0] total;
    reg [15:0] sec1;
    reg [15:0] sec2;
    reg [15:0] min1;
    reg [15:0] min2;
    
    parameter
        single_loop = 1'b1,
        all_loop = 1'd0;

    initial begin
        counter <= 16'd165;
        total <= 16'd165;
    end
    
    always @(music_select) begin//不能clk or sec_in
        case(music_select)
            2'b00: begin
                counter <= 16'd165;
                total <= 16'd165;
            end
            2'b01: begin
                counter <= 16'd165;
                total <= 16'd165;
            end
            2'b10: begin
                counter <= 16'd125;
                total <= 16'd125;
            end
            2'b11: begin
                counter <= 16'd315;
                total <= 16'd315;
            end
            default: begin
                counter <= 16'd165;
                total <= 16'd165;
            end
        endcase
    end

    always @(posedge sec_in) begin
        if(counter == 16'd0) begin
            counter <= total;
        end
        else begin
            counter <= counter - 16'b01;
        end
    end

    always @(posedge clk) begin//必须clk
        if(counter == 16'd0) music_end <= 1'b1;
        else music_end <= 1'b0;
    end
    
    always @(posedge clk) begin//必须clk

        sec1 = counter % 10;
        sec2 = counter % 100 / 10;
        min1 = counter / 100 % 10;
        min2 = counter / 100 / 10; 
        sec2 = sec2 << 4;
        min1 = min1 << 8;
        min2 = min2 << 12;
        display <= sec1 + sec2 + min1 + min2;
    end

endmodule

