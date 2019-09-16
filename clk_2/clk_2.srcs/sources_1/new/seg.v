module seg(
			input clk,		//ʱ���źţ�25MHz
			input rst_n,	//��λ�źţ��͵�ƽ��Ч
			input[15:0] display_num,	//�������ʾ���ݣ�[15:12]--�����ǧλ��[11:8]--����ܰ�λ��[7:4]--�����ʮλ��[3:0]--����ܸ�λ
			output reg[3:0] dtube_cs_n,	//7�������λѡ�ź�
			output reg[7:0] dtube_data	//7������ܶ�ѡ�źţ�����С����Ϊ8�Σ�
		);

//-------------------------------------------------
//��������

//�������ʾ 0~F ��Ӧ��ѡ���
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
			NDOT	= 8'h80;	//С������ʾ

//�����λѡ 0~3 ��Ӧ���
parameter	CSN		= 4'b1111,
			CS0		= 4'b1110,
			CS1		= 4'b1101,
			CS2		= 4'b1011,
			CS3		= 4'b0111;

//-------------------------------------------------
//��ʱ��ʾ���ݿ��Ƶ�Ԫ
reg[3:0] current_display_num;	//��ǰ��ʾ����
reg[7:0] div_cnt;	//��ʱ������
reg[7:0] dtube_data_1;

	//��ʱ������
always @(posedge clk or negedge rst_n)
	if(!rst_n) div_cnt <= 8'd0;
	else div_cnt <= div_cnt+1'b1;

	//��ʾ����
always @(posedge clk or negedge rst_n)
	if(!rst_n) current_display_num <= 4'h0;
	else begin
		case(div_cnt)
			8'hff: current_display_num <= display_num[3:0];
			8'h3f: current_display_num <= display_num[7:4];
			8'h7f: current_display_num <= display_num[11:8];
			8'hbf: current_display_num <= display_num[15:12];
			default: ;
		endcase
	end
		
	//��ѡ��������
always @(posedge clk or negedge rst_n)
	if(!rst_n) dtube_data <= NUM0;
	else begin
		case(current_display_num) 
			4'h0: dtube_data_1 <= NUM0;
			4'h1: dtube_data_1 <= NUM1;
			4'h2: dtube_data_1 <= NUM2;
			4'h3: dtube_data_1 <= NUM3;
			4'h4: dtube_data_1 <= NUM4;
			4'h5: dtube_data_1 <= NUM5;
			4'h6: dtube_data_1 <= NUM6;
			4'h7: dtube_data_1 <= NUM7;
			4'h8: dtube_data_1 <= NUM8;
			4'h9: dtube_data_1 <= NUM9;
			4'ha: dtube_data_1 <= NUMA;
			4'hb: dtube_data_1 <= NUMB;
			4'hc: dtube_data_1 <= NUMC;
			4'hd: dtube_data_1 <= NUMD;
			4'he: dtube_data_1 <= NUME;
			4'hf: dtube_data_1 <= NUMF;
			default: ;
		endcase
        if(div_cnt[7:6]==2'b10)
        begin
            dtube_data<=dtube_data_1+NDOT;
        end
        else
        begin
            dtube_data<=dtube_data_1;
        end
	end

	//λѡ����
always @(posedge clk or negedge rst_n)
	if(!rst_n) dtube_cs_n <= CSN;
	else begin
		case(div_cnt[7:6])
			2'b00: dtube_cs_n <= CS0;
			2'b01: dtube_cs_n <= CS1;
			2'b10: dtube_cs_n <= CS2;
			2'b11: dtube_cs_n <= CS3;
			default:  dtube_cs_n <= CSN;
		endcase
	end
	

endmodule

