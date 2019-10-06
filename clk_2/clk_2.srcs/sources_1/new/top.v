`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/15 20:52:02
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
    input second_zero,
    input min_zero,
    input wire[3:0] key_h,
    output wire[3:0] dtube_cs_n,	//7段数码管位选信号
	output wire[7:0] dtube_data	//7段数码管段选信号（包括小数点为8段）
    );
    wire clk_25m;	
    wire sys_rst_n;	
	clk_changer clk1(
        .sys_clk_i(sys_clk_i),
        .ext_rst_n(ext_rst_n),
        .clk(clk_25m),
        .sys_rst_n(sys_rst_n)
    );

    wire [3:0]key_press;
    remove_shake rm1(
        .sys_clk_i(clk_25m),
        .ext_rst_n(sys_rst_n),
        .key_h(key_h),
        .key_press(key_press)
    );

    wire stop;// 停止信号

    stop s1(
        .sys_rst_n(sys_rst_n),
        .key_press(key_press),
        .stop(stop)

    );

    wire second_zero_p;//经过获取上升沿信号后的秒停和分停
    wire min_zero_p;

    key_press_get s(
        .sys_clk_i(clk_25m),
        .ext_rst_n(sys_rst_n),
        .key_press(second_zero),
        .key_pos(second_zero_p)
    );
    key_press_get m(
        .sys_clk_i(clk_25m),
        .ext_rst_n(sys_rst_n),
        .key_press(min_zero),
        .key_pos(min_zero_p)
    );


    wire[15:0] display_num;//输入给译码阶段的信号

    counter counter1(
        .clk(clk_25m),		
		.rst_n(sys_rst_n),	
		.display_num(display_num),	
        .second_zero(second_zero_p),
        .min_zero(min_zero_p),
        .stop(stop),
        .min_add(key_press[1]),
        .second_add(key_press[2])
    );

    //译码
    seg seg1(
        .clk(clk_25m),		
        .rst_n(sys_rst_n),	
        .display_num(display_num),		
        .dtube_cs_n(dtube_cs_n),	
        .dtube_data(dtube_data)		
    );
endmodule
