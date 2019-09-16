//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/11 19:23:25
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
    input wire  sys_clk_i,//50HMZclk
    input wire ext_rst_n,
    output wire[3:0] dtube_cs_n,	//7段数码管位选信号
	output wire[7:0] dtube_data	//7段数码管段选信号（包括小数点为8段）
    );
    wire clk,clk2;
    wire [3:0]number1,number2,number3,number4;
    // assign number1=number_1;
    // assign number2=number_2;
    // assign number3=number_3;
    // assign number4=number_4;
    clk_change c1(
        .sys_clk_i(sys_clk_i),
        .ext_rst_n(ext_rst_n),
        .clk(clk),
        .clk2(clk2)
    );
    counter m1(
        .clk(clk),
        .reset(ext_rst_n),
        .number1(number1),
        .number2(number2),
        .number3(number3),
        .number4(number4)
    );
    seg s1(
        .clk(clk),
        .reset(ext_rst_n),
        .number1(number1),
        .number2(number2),
        .number3(number3),
        .number4(number4),
        .sseg(dtube_data),
        .an(dtube_cs_n)
    );
endmodule
