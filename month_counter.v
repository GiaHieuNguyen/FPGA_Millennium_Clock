module month_counter #(parameter NUMS_OF_MONTH = 12
)(
    input clk,
    input rst_n,
    input inc,  
    input dec,
    input ctrl_set,
    input carry_in_day,
    output reg [3:0] month_count, 
    output carry_out
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            month_count <= 1;
        end else begin
            if(ctrl_set) begin
                if(inc) begin
                    if(month_count == NUMS_OF_MONTH) begin
                        month_count <= 1;
                    end else begin
                        month_count <= month_count + 1;
                    end
                end else if(dec) begin
                    if(month_count == 4'd1) begin
                        month_count <= NUMS_OF_MONTH - 1;
                    end else begin
                        month_count <= month_count - 1;
                    end
                end
            end else if(carry_in_day) begin
                    if (month_count == NUMS_OF_MONTH)begin
                    month_count <= 1;
                end else begin
                    month_count <= month_count + 1;
                end
            end
        end
    end
    assign carry_out = (month_count == NUMS_OF_MONTH && carry_in_day) ? 1'b1 : 1'b0;
endmodule