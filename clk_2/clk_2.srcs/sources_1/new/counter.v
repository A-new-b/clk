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
			input clk,		//25Mhz
			input rst_n,	//复位
			input min_zero,
			input second_zero,
			input min_add,
			input second_add,
			input stop,
			output reg[15:0] display_num	//[15:12]--[11:8]--[7:4]--[3:0]
		);

//`define SIMULATION_AT7
`ifdef SIMULATION_AT7
	`define	MAX_CNT	25'd9_999
`else
	`define	MAX_CNT	25'd24_999_999
`endif
		
//-------------------------------------------------
//1s��ʱ�����߼�
reg[24:0] timer_cnt;	//24999999

	//1s��ʱ����
always @(posedge clk or negedge rst_n)
	if(!rst_n) timer_cnt <= 25'd0;
	else if(timer_cnt < `MAX_CNT) timer_cnt <= timer_cnt+1'b1;
	else timer_cnt <= 25'd0;

wire timer_1s_flag = (timer_cnt == `MAX_CNT);		


always @(posedge clk or negedge rst_n )
	if(!rst_n) display_num <= 16'd0;
	else if(second_zero)
		begin
			display_num[15:12] <= 16'h0;
			display_num[11:8] <= 16'h0;
		end
		
	else if(min_zero)
		begin
				display_num[7:4]<=16'h0;
				display_num[3:0]<=16'h0;
		end
	else if(min_add)
		begin
			if(display_num[11:8]==16'd9)
			begin
				if(display_num[15:12]>=16'd5)
					begin
						display_num[11:8]<=4'd0;
						display_num[15:12]<=4'd0;
					end

				else
				begin
				display_num[15:12]<=display_num[15:12]+1'b1;
				display_num[11:8]<=1'b0;
				end
				
			end
			else
			display_num[11:8]=display_num[11:8]+1'b1;
			end
	else if(timer_1s_flag || second_add) 
		begin
			if(stop)
			begin
				if(display_num[3:0]==16'd9)
				begin
					if(display_num[7:4]==16'd5)
						begin
							if(display_num[11:8]==16'd9)
								begin
									if(display_num[15:12]==16'd5)
										begin
											display_num[3:0]<=4'd0;
											display_num[7:4]<=4'd0;
											display_num[11:8]<=4'd0;
											display_num[15:12]<=4'd0;
										end
									else
										begin
											display_num[3:0]<=4'd0;
											display_num[7:4]<=4'd0;
											display_num[11:8]<=4'd0;
											display_num[15:12]<=display_num[15:12]+1'b1;
										end
								end
							else
								begin
									display_num[3:0]<=4'd0;
									display_num[7:4]<=4'd0;
									display_num[11:8]<=display_num[11:8]+1'b1;
								end
						end
					else 
						begin
							display_num[3:0]<=4'd0;
							display_num[7:4]<=display_num[7:4]+1'b1;
						end
				end
				else
					display_num <= display_num+1'b1;
			end
		end
endmodule

