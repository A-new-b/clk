`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/16 14:46:59
// Design Name: 
// Module Name: clk_sim
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


module clk_sim();
reg clk;
reg reset;
wire clk2;
wire e_reset;
clk_changer c1(
    .sys_clk_i(clk),
    .ext_rst_n(reset),
    .clk(clk2),
    .sys_rst_n(e_reset)
);
initial begin
    #0 
    clk<=0;
    reset<=0;
    #1
    clk<=0;
    reset<=1;
    repeat(150000000)begin
        #1
        reset<=0;
        clk<=~clk;
    end
end
endmodule
