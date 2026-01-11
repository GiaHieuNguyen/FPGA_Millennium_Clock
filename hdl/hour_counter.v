module hour_counter(
    input  wire       clk,
    input  wire       rst_n,
    input  wire       inc,
    input  wire       dec,
    input  wire       ctrl_set,
    input  wire       carry_in_min,       
    output reg  [4:0] hour_count,         
    output            carry_out
);
    wire tick_hour = carry_in_min;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            hour_count <= 5'd0;
        end else begin
            if (ctrl_set) begin
                if (inc)      hour_count <= (hour_count == 5'd23) ? 5'd0  : hour_count + 5'd1;
                else if (dec) hour_count <= (hour_count == 5'd0 ) ? 5'd23 : hour_count - 5'd1;
            end else if (tick_hour) begin
                if (hour_count == 5'd23) begin
                    hour_count <= 5'd0;
                end else begin
                    hour_count <= hour_count + 5'd1;
                end
            end
        end
    end
    assign carry_out = ((hour_count == 5'd23) && carry_in_min) ? 1'b1 : 1'b0;
endmodule