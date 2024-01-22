
`timescale 1ns / 1ps
 
module tb(    );
    reg clk;
    reg rst;
    wire music_select;
  debounce_b deb_u1(
       .clk(clk),
       .run_stop(run_stop),
       .key_in(reset),
       .key_out(reset_up)
       );
     
     play_QingTian Music1(
        .clk(clk),
        .music_select(music_select),
        .beep(beep)
     );
     play_Happy_Birthday Music2(
        .clk(clk),
        .music_select(music_select),
        .beep(beep)
     );
     play_little_star Music3(
        .clk(clk),
        .music_select(music_select),
        .beep(beep)
     );
     MusicController music_ctrl(
        .clk(clk),
        .next_song(reset_up),
        .music_select(music_select)
       // .next_song(),
       // .last_song()
     );
     
    
    parameter PERIOD = 10;
 
    always    //����ִ�� 
        begin
            clk = 1'b0;
            #(PERIOD/2)
            clk = 1'b1;
            #(PERIOD/2);
        end
    //ʱ������,����Ϊ10��ʱ�䵥λ��ռ�ձ�50%
 
    initial    //��ִ��һ��
        begin
            clk = 1'b0;
            rst = 1'b0;
            #100;
            rst = 1'b1;
            #100;
            rst = 1'b0; 
            #100; 
            rst = 1'b1;
        end
    //��ʼ����λ״̬
endmodule
