`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/26 23:14:43
// Design Name: 
// Module Name: statements
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


module statements(
input run_stop,
input reset_up,
input pause_up,
input clk,
input carry_25,
input carry_5,
output reg min5_en,
output reg sec_out_en,
output reg time_rst
    );
    reg [2:0]nstate;
    reg [2:0]cstate;
    
    parameter WORK=3'b001;
    parameter STOP=3'b010;
    parameter WAIT_5=3'b100;   
    parameter RESET=3'b101;
   initial nstate=STOP;
                
    //×´Ì¬
    always @(posedge clk or negedge run_stop)
    begin 
    if(!run_stop)
    cstate<=STOP;
    else
    cstate<=nstate;
    end
   //×´Ì¬×ª»»
    always @*
    begin
    case(cstate)
    STOP:begin
      if(run_stop)begin
        nstate=WORK;
        end
       else
        nstate=STOP;
       end
      
     WORK:begin
        if(run_stop==1'b0)
         nstate=STOP;
        else if(reset_up==1'b1)
         nstate=RESET;
        else if(pause_up==1'b1 || carry_25==1'b1)begin
         nstate=WAIT_5; 
         end
        else nstate=WORK;
        end
        
      RESET: nstate=WAIT_5;
     
           
      WAIT_5:begin
        if(carry_5==1'b1)
            nstate=WORK;
        else if(reset_up)
         nstate=RESET;
        else if(pause_up)
         nstate=WORK;
        else   nstate=WAIT_5;
        end
       default:nstate=STOP;
       endcase
       end 
 //×´Ì¬ÄÚÈÝ     
       always @*
       begin
       case(cstate)
        STOP:begin
        min5_en<=1'b0;
        sec_out_en<=1'b0;
        time_rst<=1'b1;
        end        
        
        WORK:begin
        min5_en<=1'b0;
        time_rst<=1'b0;
        sec_out_en<=1'b1;
        end         
        
        WAIT_5:begin
        min5_en<=1'b1;
        sec_out_en<=1'b0;
        time_rst<=1'b0;        
        end
        
        RESET:begin
        sec_out_en<=1'b0;  
        time_rst<=1'b1;
        min5_en<=1'b0;
        end
      
        default:begin
        sec_out_en<=1'b0;
        time_rst<=1'b1;
        min5_en<=1'b0;
        end     
        endcase     
       end     
endmodule