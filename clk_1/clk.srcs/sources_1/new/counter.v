`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/11 16:20:50
// Design Name: 
// Module Name: counter
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


module counter(
input wire  clk,
input wire reset,
output reg [3:0]number1,
output reg[3:0]number2,
output reg[3:0]number3,
output reg[3:0]number4
 );
 reg n2;
 reg n3;
 reg n4;
 always @(posedge clk or posedge  reset)begin
    if (!reset) begin
        if(number1<4'd9)begin
        n2<=0;
         number1<=number1+1;
        end else begin
            number1<=0;
            n2<=1'b1;
        end
    end else begin
        number1<=0;
        n2<=0;
        
     end
 end
 always @(posedge n2 or posedge  reset)begin
     if (!reset) begin
        if(number2<4'd5)begin
         n3<=0;
         number2<=number2+1;
        end else begin
            number2<=0;
            n3<=1;
        end
    end else begin
        n3<=0;
         number2<=0;
     end
 end
always @(posedge n3 or  posedge reset)begin
     if (!reset) begin
        if(number3<4'd9)begin
        n4<=0;
         number3<=number3+1;
        end else begin
            number3<=0;
            n4<=1;
        end
    end else begin
        n4<=0;
         number3<=0;
     end
 end
 always @(posedge n4 or posedge reset)begin
     if (!reset) begin
        if(number4<4'd5)begin
         number4<=number4+1;
        end else begin
            number4<=0;
        end
    end else begin
         number4<=0;
     end
 end
endmodule
