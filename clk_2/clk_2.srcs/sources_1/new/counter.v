//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/15 20:56:57
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
			input clk,		//ʱ���źţ�25MHz
			input rst_n,	//��λ�źţ��͵�ƽ��Ч
			output reg[15:0] display_num	//�������ʾ���ݣ�[15:12]--�����ǧλ��[11:8]--����ܰ�λ��[7:4]--�����ʮλ��[3:0]--����ܸ�λ
		);

//`define SIMULATION_AT7
`ifdef SIMULATION_AT7
	`define	MAX_CNT	25'd9_999
`else
	`define	MAX_CNT	25'd24_999_999
`endif
		
//-------------------------------------------------
//1s��ʱ�����߼�
reg[24:0] timer_cnt;	//1s��������0-24999999

	//1s��ʱ����
always @(posedge clk or negedge rst_n)
	if(!rst_n) timer_cnt <= 25'd0;
	else if(timer_cnt < `MAX_CNT) timer_cnt <= timer_cnt+1'b1;
	else timer_cnt <= 25'd0;

wire timer_1s_flag = (timer_cnt == `MAX_CNT);		//1s��ʱ����־λ������Чһ��ʱ������

//-------------------------------------------------
//�������ݲ����߼�

	//��ʾ����ÿ�����
always @(posedge clk or negedge rst_n)
	if(!rst_n) display_num <= 16'd0;
	else if(timer_1s_flag) 
	begin
		if(display_num[3:0]==16'd9)
		begin
			if(display_num[7:4]==16'd5)
				begin
					if(display_num[11:8]==16'd9)
						begin
							if(display_num[15:12]==16'd5)
								begin
									display_num[3:0]=4'd0;
									display_num[7:4]=4'd0;
									display_num[11:8]=4'd0;
									display_num[15:12]=4'd0;
								end
							else
								begin
									display_num[3:0]=4'd0;
									display_num[7:4]=4'd0;
									display_num[11:8]=4'd0;
									display_num[15:12]=display_num[15:12]+1'b1;
								end
						end
					else
						begin
							display_num[3:0]=4'd0;
							display_num[7:4]=4'd0;
							display_num[11:8]=display_num[11:8]+1'b1;
						end
				end
			else 
				begin
					display_num[3:0]=4'd0;
					display_num[7:4]=display_num[7:4]+1'b1;
				end
		end
		else
			display_num <= display_num+1'b1;
	end
endmodule

