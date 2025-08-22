module year_counter #(
    parameter BASE_YEAR = 2025,
    parameter MAX_YEAR  = 3025
)(
    input clk,
    input rst_n,
    input inc,
    input dec,
    input ctrl_set,
    input carry_in_month,
    output reg [11:0] year_count
);
    wire tick_year = carry_in_month;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            year_count <= BASE_YEAR; 
        end else begin
            if(ctrl_set) begin
                if(inc) begin
                    if(year_count == MAX_YEAR) begin
                        year_count <= BASE_YEAR;
                    end else begin
                        year_count <= year_count + 1;
                    end
                end else if(dec) begin
                    if(year_count == BASE_YEAR) begin
                        year_count <= BASE_YEAR;
                    end else begin
                        year_count <= year_count - 1;
                    end
                end
            end else if (tick_year) begin
                    if (year_count == MAX_YEAR) begin
                    year_count <= BASE_YEAR; 
                end else begin
                    year_count <= year_count + 1;
                end
            end
        end
    end

endmodule