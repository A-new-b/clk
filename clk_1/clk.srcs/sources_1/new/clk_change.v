//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/15 17:41:19
// Design Name: 
// Module Name: clk_change
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


module clk_change(
    input wire  sys_clk_i,
    input wire  ext_rst_n,
    output reg clk,
    output reg clk2
    );
    reg [27:0] clk_counter;
    reg [1:0] clk_counter2;
    always@(posedge sys_clk_i ,posedge ext_rst_n)
    begin
        if(!ext_rst_n)begin
            if(clk_counter < 28'd49999999 )//49_999_999 
            begin
                clk<=0;
                clk_counter <= clk_counter+1'b1;
            end
            else begin
                clk<=1;
                clk_counter <= 28'd0;
            end
        end
        else begin
            clk<=0;
            clk_counter <=  28'd0;
        end
    end


    always@(posedge sys_clk_i ,posedge ext_rst_n)
    if(!ext_rst_n)
    begin
        if(clk_counter2 < 1'd1 )//49_999_999 
        begin
        clk2<=0;
        clk_counter2<= clk_counter2+1'b1;
        end
        else begin
            clk2<=1;
            clk_counter2 <= 1'd0;
        end
    end 
    else begin
        clk2<=0;
        clk_counter2 <= 0;
    end
endmodule
