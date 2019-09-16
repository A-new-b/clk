module clk_changer(
    input wire  sys_clk_i,
    input wire  ext_rst_n,
    output reg clk,
    output wire sys_rst_n
);
    reg[1:0]clk_counter;
    assign sys_rst_n=~ext_rst_n;
    always @(posedge sys_clk_i or negedge sys_rst_n)
    begin
        if(!sys_rst_n)
            begin
                clk<=0;
                clk_counter<=0;
            end
        else 
        begin
            if(clk_counter<2'b01)
                begin
                    clk_counter<=clk_counter+1;
                    clk<=0;
                end
            else
                begin
                    clk_counter<=0;
                    clk<=1;
                end
        end
    end
endmodule 