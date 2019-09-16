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
    output wire[3:0] dtube_cs_n,	//7段数码管位选信号
	output wire[7:0] dtube_data	//7段数码管段选信号（包括小数点为8段）
    );
    wire clk_25m;	//PLL���25MHzʱ��
    wire sys_rst_n;	//PLL�����locked�źţ���ΪFPGA�ڲ��ĸ�λ�źţ��͵�ƽ��λ���ߵ�ƽ��������
	clk_changer clk1(
        .sys_clk_i(sys_clk_i),
        .ext_rst_n(ext_rst_n),
        .clk(clk_25m),
        .sys_rst_n(sys_rst_n)
    );

    wire[15:0] display_num;


    counter counter1(
        .clk(clk_25m),		//ʱ���ź�
		.rst_n(sys_rst_n),	//��λ�źţ��͵�ƽ��Ч
		.display_num(display_num)		//LEDָʾ�ƽӿ�	
    );
    seg seg1(
        .clk(clk_25m),		//ʱ���ź�
        .rst_n(sys_rst_n),	//��λ�źţ��͵�ƽ��Ч
        .display_num(display_num),		//LEDָʾ�ƽӿ�	
        .dtube_cs_n(dtube_cs_n),	//7�������λѡ�ź�
        .dtube_data(dtube_data)		//7������ܶ�ѡ�źţ�����С����Ϊ8�Σ�
    );
endmodule
