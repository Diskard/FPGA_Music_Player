module play_Happy_Birthday(
    input wire [1:0] music_select,
    input clk,         // 输入时钟信号
    output beep        // 输出蜂鸣器信号
);

    reg beep_r;         // 蜂鸣器状态寄存器
    reg[7:0] state;     // 乐谱状态机
    reg[16:0] count, count1; // 计数器
    reg[25:0] count2;   // 用于计时的计数器

    // 定义音符频率参数
    parameter
        L_1 = 18'd127552,
        L_2 = 18'd113636,
        L_3 = 18'd101236,
        L_4 = 18'd95548,
        L_5 = 18'd85136,
        L_6 = 18'd75838,
        L_7 = 18'd67567,
        M_1 = 18'd63776,
        M_2 = 18'd56818,
        M_3 = 18'd50607,
        M_4 = 18'd47778,
        M_5 = 18'd42553,
        M_6 = 18'd37936,
        M_7 = 18'd33783;

    parameter TIME = 50000000; // 每种音阶持续时长为500ms

   
    assign beep = beep_r;    // 将蜂鸣器状态赋给输出端口

    // 在时钟上升沿触发的逻辑
    always @(posedge clk) begin
        if(music_select == 2'b10) begin 
            count <= count + 1'b1;    // 计数器递增
            if (count == count1) begin
                count <= 17'h0;
                beep_r <= !beep_r;      // 翻转蜂鸣器状态，形成音符波形
            end
        end
        else begin
            count <= 1'b0;
        end
    end

    // 乐谱状态机逻辑
    always @(posedge clk) begin
        if(music_select == 2'b10) begin
            if (count2 < TIME)
                count2 = count2 + 1'b1;
            else begin
                count2 = 26'd0;
                if (state == 8'd25)begin
                    state = 8'd0;
                end
                else begin
                    state = state + 1'b1;
                end
                case(state)
                    // 生日快乐曲谱
                    8'D0: count1 = L_5;
                    8'D1: count1 = L_5;
                    8'D2: count1 = L_6;
                    8'D3:count1= L_5;
                    8'D4:count1= M_1;
                    8'D5:count1= L_7;
                    8'D6:count1= L_5;
                    8'D7:count1= L_5;
                    8'D8:count1= L_6;
                    8'D9:count1= L_5;
                    8'D10:count1= M_2;
                    8'D11:count1= M_1;
                    8'D12:count1= L_5;
                    8'D13:count1= L_5;
                    8'D14:count1= M_5;
                    8'D15:count1= M_3;
                    8'D16:count1= M_1;
                    8'D17:count1= L_7;
                    8'D18:count1= L_6;
                    8'D19:count1= M_4;
                    8'D20:count1= M_4;
                    8'D21:count1= M_3;
                    8'D22:count1= M_1;
                    8'D23:count1= M_2;
                    8'D24:count1= M_1;
                    default: count1 = 16'h0;
                endcase
            end
        end
        else begin
            count2 = 1'b0;
        end
    end
endmodule
