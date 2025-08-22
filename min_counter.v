module min_counter(
    input  wire       clk,
    input  wire       rst_n,
    input  wire       inc,
    input  wire       dec,
    input  wire       ctrl_set,
    input  wire       carry_in_sec,       
    output reg  [5:0] min_count,          
    output            carry_out
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            min_count <= 6'd0;
        end else begin
            if (ctrl_set) begin
                if (inc)      min_count <= (min_count == 6'd59) ? 6'd0  : min_count + 6'd1;
                else if (dec) min_count <= (min_count == 6'd0 ) ? 6'd59 : min_count - 6'd1;
            end else if (carry_in_sec) begin
                if (min_count == 6'd59) begin
                    min_count <= 6'd0;
                end else begin
                    min_count <= min_count + 6'd1;
                end
            end
        end
    end
    assign carry_out = ((min_count == 6'd59) && carry_in_sec) ? 1'b1 : 1'b0;
endmodule