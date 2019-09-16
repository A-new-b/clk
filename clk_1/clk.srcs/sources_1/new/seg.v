`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/12 16:43:48
// Design Name: 
// Module Name: seg
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


module seg(
input clk,reset,
input wire [3:0] number1,number2,number3,number4,
output reg [3:0] an,
output reg[7:0] sseg
    );
    //数码管显示 0~F 对应段选输出
parameter 	NUM0 	= 8'h3f,//c0,
			NUM1 	= 8'h06,//f9,
			NUM2 	= 8'h5b,//a4,
			NUM3 	= 8'h4f,//b0,
			NUM4 	= 8'h66,//99,
			NUM5 	= 8'h6d,//92,
			NUM6 	= 8'h7d,//82,
			NUM7 	= 8'h07,//F8,
			NUM8 	= 8'h7f,//80,
			NUM9 	= 8'h6f,//90,
			NUMA 	= 8'h77,//88,
			NUMB 	= 8'h7c,//83,
			NUMC 	= 8'h39,//c6,
			NUMD 	= 8'h5e,//a1,
			NUME 	= 8'h79,//86,
			NUMF 	= 8'h71,//8e;
			NDOT	= 8'h80;	//小数点显示
//数码管位选 0~3 对应输出
parameter	CSN		= 4'b1111,
			CS0		= 4'b1110,
			CS1		= 4'b1101,
			CS2		= 4'b1011,
			CS3		= 4'b0111;
reg[1:0]regN;
reg [3:0 ]number_in;
reg point;
reg [3:0]an_1;
always @(posedge clk,posedge reset)
begin
    if(reset)
    regN<=2'b00;
    else
    regN<=regN+1;
end
always @(posedge clk)
case (regN)
    2'b00:
    begin
        an_1<=CS0;
        number_in<=number1;
        point<=0;
    end
    2'b01:
    begin
        an_1<=CS1;
        number_in<=number2;
        point<=1;
    end
    2'b10:
    begin
        an_1<=CS2;
        number_in<=number3;
        point<=0;
    end
    default: 
    begin
        an_1<=CS3;
        number_in<=number4;
        point<=0;
    end
endcase
always @(posedge clk)
begin
    case(number_in)
        4'h0:sseg<=NUM0;
        4'h1:sseg<=NUM1;
        4'h2:sseg<=NUM2;
        4'h3:sseg<=NUM3;
        4'h4:sseg<=NUM4;
        4'h5:sseg<=NUM5;
        4'h6:sseg<=NUM6;
        4'h7:sseg<=NUM7;
        4'h8:sseg<=NUM8;
        4'h9:sseg<=NUM9;
        // 4'ha:sseg=NUMA;
        // 4'hb:sseg=NUMB;
        //if Don't add default?
    endcase
    an<=an_1;
end
endmodule
