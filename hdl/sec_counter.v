module sec_counter(
    input        clk,
    input  wire       rst_n,
    input  wire       inc,
    input  wire       dec,
    input  wire       ctrl_set,
    input  wire       freeze,
    output reg  [5:0] sec_count, 
    output            carry_out
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sec_count <= 6'd0;
        end else if (freeze) begin
            sec_count <= sec_count;
        end else begin
            if (ctrl_set) begin
                if (inc)      sec_count <= (sec_count == 6'd59) ? 6'd0  : sec_count + 6'd1;
                else if (dec) sec_count <= (sec_count == 6'd0 ) ? 6'd59 : sec_count - 6'd1;
            end else begin
                if (sec_count == 6'd59) begin
                    sec_count <= 6'd0;
                end else begin
                    sec_count <= sec_count + 6'd1;
                end
            end
        end
    end
    assign carry_out = (sec_count == 6'd59) ? 1'b1 : 1'b0;
endmodule