module leap_year_check(
    input clk,
    input rst_n,
    input [11:0] current_year,
    //input year_carry_in,
    output reg is_leap_year
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            is_leap_year <= 1'b0;
        end else begin
            if(current_year == 2400 || current_year == 2800) begin
                is_leap_year <= 1;
            end else begin
                if(current_year == 2100 || current_year == 2200 || current_year == 2300 || 
                   current_year == 2500 || current_year == 2600 || current_year == 2700 ||
                   current_year == 2900 || current_year == 3000) begin
                    is_leap_year <= 0;
                end else if((current_year & 12'b11) == 0) begin
                    is_leap_year <= 1; // Every 4 years is a leap year
                end else begin
                    is_leap_year <= 0; // Not a leap year
                end
            end
        end
    end
endmodule


