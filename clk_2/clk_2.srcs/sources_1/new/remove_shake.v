//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/30 15:59:25
// Design Name: 
// Module Name: remove_shake
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


module remove_shake(
input sys_clk_i,	//外部输入50MHz时钟信号
input ext_rst_n,	//外部输入复位信号，低电平有效
input[3:0] key_h,	//4个独立按键输入，未按下为高电平，按下后为低电平
output [3:0] key_press
    );
    wire key;	//所有按键值相与的结果，用于按键触发判断
reg[3:0] keyr;  //按键值key的缓存寄存器

assign key = key_h[0] & key_h[1] & key_h[2] & key_h[3];

always @(posedge sys_clk_i or negedge ext_rst_n)
    if (!ext_rst_n) keyr <= 4'b1111;
    else keyr <= {keyr[2:0],key};

wire key_neg = ~keyr[2] & keyr[3];	//有按键被按下	
wire key_pos = keyr[2] & ~keyr[3];	//有按键被释放

//-------------------------------------
//定时计数20ms时间，用于对按键的消抖判断
reg[19:0]  cnt;	

	//按键消抖定时计数器
always @ (posedge sys_clk_i or negedge ext_rst_n)
   if (!ext_rst_n) cnt <= 20'd0;	
	else if(key_pos || key_neg) cnt <= 20'd0;
	else if(cnt < 20'd999_999) cnt <= cnt + 1'b1;
	else cnt <= 20'd0;
  
reg[3:0] key_halue[1:0];

	//定时采集按键值
always @(posedge sys_clk_i or negedge ext_rst_n)
    if (!ext_rst_n) begin
		key_halue[0] <= 4'b1111;
		key_halue[1] <= 4'b1111;
	end
	else begin 
		key_halue[1] <= key_halue[0];		
		if(cnt == 20'd999_999) key_halue[0] <= key_h;	//定时键值采集
		else ;	
	end

assign key_press = key_halue[1] & ~key_halue[0];		//消抖后按键值变化标志位
endmodule
