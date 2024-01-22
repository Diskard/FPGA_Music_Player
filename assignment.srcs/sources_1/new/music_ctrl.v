module MusicController(
    input clk,
    //input rst,
    input next_song,  // 信号用于切换到下一首歌
    input last_song,
    input mode_song,
    input sec_in,
    output reg [1:0] music_select,
    output reg [15:0] display
);
    reg [15:0] counter;
    reg [1:0] current_song;
    reg play_mode;
    reg [15:0] total;
    reg [15:0] sec1;
    reg [15:0] sec2;
    reg [15:0] min1;
    reg [15:0] min2;

    parameter
        single_loop = 1'b1,
        all_loop = 1'd0;
    
    // 初始化当前歌曲
    initial begin
      current_song <= 2'b01;
      play_mode <= single_loop;
      counter <= 16'd165;
      total <= 16'd165;
    end

    always @(posedge clk) begin
        if(mode_song) begin
            case(play_mode)
                single_loop:play_mode <= all_loop;
                all_loop:   play_mode <= single_loop;
            endcase
        end
    end

  // 音乐切换逻辑
    always @(posedge clk) begin //posedge rst
//        if (rst) begin
//            current_song <= 2'b00;  // 复位时回到第一首歌
//        end
        if(sec_in)begin
            if(counter == 16'd0) begin
                counter <= total;
            end
            else begin
                counter <= counter - 16'b01;
            end
        end
        if (next_song) begin
            case(current_song)
                2'b00:begin
                    current_song <= 2'b01;  
                    counter <= 16'd165;
                    total <= 16'd165;
                end
                2'b01:begin
                    current_song <= 2'b10;
                    counter <= 16'd125;
                    total <= 16'd125;
                    
                end
                2'b10:begin
                    current_song <= 2'b11;  
                    counter <= 16'd315;
                    total <= 16'd315;
                end
                2'b11:begin
                    current_song <= 2'b01;  // 如果已经是最后一首，切回第一首
                    counter <= 16'd165;
                    total <= 16'd165;
                end
                default:begin
                    current_song <= 2'b01;
                    counter <= 16'd165;
                    total <= 16'd165;
                end
            endcase
        end
        if (last_song) begin
            case(current_song)
              2'b00:begin
                  current_song <= 2'b01; 
                  counter <= 16'd165;
                  total <= 16'd165;
              end
              2'b11:begin
                  current_song <= 2'b10;  
                  counter <= 16'd125;
                  total <= 16'd125;
              end
              2'b01:begin
                  current_song <= 2'b11;// 如果已经是第一首，切回最后一首
                  counter <= 16'd315;
                  total <= 16'd315;
              end
              2'b10:begin
                  current_song <= 2'b01;
                  counter <= 16'd165;
                  total <= 16'd165;
              end
              default:begin
                  current_song <= 2'b01;
                  counter <= 16'd165;
                  total <= 16'd165;
              end
            endcase
        end
        if(counter == 16'd0 && play_mode == all_loop)begin
            case(current_song)
                2'b00:begin
                    current_song <= 2'b01;  
                    counter <= 16'd165;
                    total <= 16'd165;
                end
                2'b01:begin
                    current_song <= 2'b10;
                    counter <= 16'd125;
                    total <= 16'd125;
                    
                end
                2'b10:begin
                    current_song <= 2'b11;  
                    counter <= 16'd315;
                    total <= 16'd315;
                end
                2'b11:begin
                    current_song <= 2'b01;  // 如果已经是最后一首，切回第一首
                    counter <= 16'd165;
                    total <= 16'd165;
                end
                default:begin
                    current_song <= 2'b01;
                    counter <= 16'd165;
                    total <= 16'd165;
                end
            endcase
        end
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

    // 输出当前选中的歌曲
    always @* begin
      music_select = current_song;
    end

endmodule
