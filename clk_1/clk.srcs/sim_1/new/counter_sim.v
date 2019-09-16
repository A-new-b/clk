`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/11 17:09:34
// Design Name: 
// Module Name: counter_sim
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


module counter_sim();
reg clk;
reg reset;
wire[3:0] dtube_cs_n;	//7段数码管位选信号
wire[7:0] dtube_data;	//7段数码管段选信号（包括小数点为8段）
top m1(
    .sys_clk_i(clk),
    .ext_rst_n(reset),
    .dtube_cs_n(dtube_cs_n),
    .dtube_data(dtube_data)
);
initial begin
    #0 
    clk<=0;
    reset<=0;
    #1
    clk=0;
    reset=1;
    repeat(150000000)begin
        #1
        reset<=0;
        clk=~clk;
    end
end

endmodule
