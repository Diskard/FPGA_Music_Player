module digit_test(
    input clk,
    input next_song,
    input last_song,
    output reg [0:7] a_to_g,  // ��������ܵ�����ź�
    output reg [3:0] an       // �����ѡ���ź�
);

    always @(posedge clk) begin
        if(next_song) begin
//            a_to_g <= 8'b11111111;
//            an <= 4'b0001;
        end
        if(last_song) begin
//            a_to_g <= 8'b10111111;
//            an <= 4'b0001;
        end
    end

endmodule
