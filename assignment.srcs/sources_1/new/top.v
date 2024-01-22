`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 22:17:08
// Design Name: 
// Module Name: top
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

module top(
input clk,
input next_btn,
input mode_btn,
input last_btn,
//input pause_btn,
//input pause,
input run_stop,
output wire[0:6]a_to_g,
output wire dot,
output wire[0:6]a_to_g_right,
output wire[3:0]an,
output wire[3:0]an_right,
//output wire[7:0]light_out,
//output wire[4:0]light_5,
output beep
    );

    //wire [7:0]seconds;
    //wire [7:0]minutes;
    wire [15:0]digit_num;
    //wire sec_5;
    //wire sec_out;
    //wire sec_out_en;
    
      //wire min5_en;
      //wire carry_5;
      wire mode_song;
      //wire pause_song;
      wire next_song;
      wire last_song;
      //wire pause_up;
      //wire carry_25;
      //wire time_rst;
      wire [2:0]music_select;
      //wire music1_flag;
      //wire music2_flag;
      //wire music3_flag;
      wire beep_1;
      wire beep_2;
      wire beep_3;
      wire sec_pause;
      
      debounce_s0 deb_s0(
         .clk(clk),
         .run_stop(run_stop),
         .key_in(mode_btn),
         .key_out(mode_song)
      );
      
      debounce_s1 deb_s1(
         .clk(clk),
         .run_stop(run_stop),
         .key_in(next_btn),
         .key_out(next_song)
      );
      
      // debounce_s2 deb_s2(
      //    .clk(clk),
      //    .run_stop(run_stop),
      //    .key_in(pause_btn),
      //    .key_out(pause_song)
      // );
      
      debounce_s4 deb_s4(
         .clk(clk),
         .run_stop(run_stop),
         .key_in(last_btn),
         .key_out(last_song)
      );

      play_QingTian Music1(
         .clk(clk),
         .music_select(music_select),
         .beep(beep_1)
     );
      play_Happy_Birthday Music2(
         .clk(clk),
         .music_select(music_select),
         .beep(beep_2)
     );
      play_Song_of_Joy Music3(
         .clk(clk),
         .music_select(music_select),
         .beep(beep_3)
     );
      MusicController music_ctrl(      
         .sec_in(sec_pause),
         .display(digit_num),
         .clk(clk),
         .next_song(next_song),
         .last_song(last_song),
         .music_select(music_select),
         .mode_song(mode_song)
     );
      beep_ctrl beep_ctrl(
         .music_select(music_select),
         .beep_1(beep_1),
         .beep_2(beep_2),
         .beep_3(beep_3),
         .beep(beep)
      );
      digit_test digital(
         .clk(clk),
         .an(an),
         .next_song(next_song),
         .last_song(last_song),
         .a_to_g(a_to_g)
        );
        
      //  music_count_down mct(
      //       .clk(clk),
      //       .next_song(next_song),
      //       .last_song(last_song),
      //       .music_select(music_select),
      //       .sec_in(sec_pause),
      //       .mode_song(mode_song),
      //       .music_end(music_end),
      //       .display(digit_num)
      //   );
        
        one_sec_count sec_cnt(
            .clk(clk),
            .sec_out(sec_pause),
            .a_to_g(a_to_g),
            .an(an)
        );
        
        pipe pipe_u6(
            .clk(clk),
            .x(digit_num),
            .a_to_g(a_to_g),
            .an(an),
            .an_right(an_right),
            .a_to_g_right(a_to_g_right),
            .music_select(music_select),
            .dot(dot)
        ); 
endmodule
