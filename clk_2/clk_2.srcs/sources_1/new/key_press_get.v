//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/30 10:04:29
// Design Name: 
// Module Name: key_press_get
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


module key_press_get(
input key_press,
input wire  sys_clk_i,//50HMZclk
input wire ext_rst_n,
output key_pos
    );

    reg [2:0] delay;
    always@(posedge sys_clk_i or negedge ext_rst_n)
    begin
        if(!ext_rst_n)begin
            delay <=0;
        end
        else 
        begin
            delay<={delay[1:0],key_press};
        end
    end
    assign key_pos=delay[1]&&(~delay[2]);

endmodule
