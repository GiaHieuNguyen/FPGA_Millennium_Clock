module day_counter(
    input  wire       clk,
    input  wire       rst_n,
    input  wire       inc,
    input  wire       dec,
    input  wire       ctrl_set,
    input  wire       carry_in_hour,
    input  wire [3:0] current_month,   
    input  wire       is_leap_year,
    output reg  [5:0] day_count,       
    output            carry_out
);
    reg [5:0] END_OF_MONTH;           // Days in the current month
    reg [5:0] END_OF_PREVIOUS_MONTH;  // Days in the previous month

    always @(current_month or is_leap_year) begin
        case (current_month)
            2: begin
                END_OF_MONTH = (is_leap_year) ? 29 : 28;
                END_OF_PREVIOUS_MONTH = 31;
            end
            4, 6, 9, 11: begin
                END_OF_MONTH = 30;
                END_OF_PREVIOUS_MONTH = 31;
            end
            default: begin
                END_OF_MONTH = 31;
                END_OF_PREVIOUS_MONTH = 30;
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            day_count <= 1; 
            end else begin
            if(ctrl_set) begin
                if(inc) begin
                    if(day_count == END_OF_MONTH) begin
                        day_count <= 1; 
                    end else begin
                        day_count <= day_count + 1;
                    end
                end else if(dec) begin
                    if(day_count == 1) begin
                        day_count <= END_OF_MONTH;
                    end else begin
                        day_count <= day_count - 1;
                    end
                end
            end else begin
                // Normal day cycle
                if(carry_in_hour) begin
                    if(day_count == END_OF_MONTH) begin
                    day_count <= 1;
                end else begin
                    day_count <= day_count + 1;
                end
                end
            end
        end
    end
    assign carry_out = (day_count == END_OF_MONTH && carry_in_hour) ? 1'b1 : 1'b0;
endmodule