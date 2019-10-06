//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/01 18:31:41
// Design Name: 
// Module Name: stop
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


module stop(
input wire[3:0] key_press,
input sys_rst_n,
output reg stop
);
wire stop_signal=~key_press[0];
always@(posedge stop_signal or negedge sys_rst_n)
begin
    if(!sys_rst_n)
    begin
        stop<=1'b1;
    end
    else
    begin
        stop<=~stop;
    end
end
endmodule
