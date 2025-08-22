module clk_1hz #(
    parameter HALF_CYCLE = 25_000_000 - 1
)(
    input clk_50MHz,
    input rst_n,
    output reg clk_1hz  
);
    reg [25:0] counter; 

    always @(posedge clk_50MHz or negedge rst_n) begin
        if(!rst_n) begin
            counter <= 0;
            clk_1hz <= 1'b0;
        end else if(counter == HALF_CYCLE) begin
            counter <= 0;
            clk_1hz <= ~clk_1hz; 
        end else begin
            counter <= counter + 1'b1;
        end
    end
endmodule



