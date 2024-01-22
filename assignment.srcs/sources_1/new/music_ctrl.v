module MusicController(
    input clk,
    //input rst,
    input next_song,  // �ź������л�����һ�׸�
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
    
    // ��ʼ����ǰ����
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

  // �����л��߼�
    always @(posedge clk) begin //posedge rst
//        if (rst) begin
//            current_song <= 2'b00;  // ��λʱ�ص���һ�׸�
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
                    current_song <= 2'b01;  // ����Ѿ������һ�ף��лص�һ��
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
                  current_song <= 2'b11;// ����Ѿ��ǵ�һ�ף��л����һ��
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
                    current_song <= 2'b01;  // ����Ѿ������һ�ף��лص�һ��
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
    
    always @(posedge clk) begin//����clk
        sec1 = counter % 10;
        sec2 = counter % 100 / 10;
        min1 = counter / 100 % 10;
        min2 = counter / 100 / 10; 
        sec2 = sec2 << 4;
        min1 = min1 << 8;
        min2 = min2 << 12;
        display <= sec1 + sec2 + min1 + min2;
    end

    // �����ǰѡ�еĸ���
    always @* begin
      music_select = current_song;
    end

endmodule
