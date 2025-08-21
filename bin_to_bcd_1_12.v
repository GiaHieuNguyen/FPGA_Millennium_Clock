module bin_to_bcd_1_12(
    input  wire [3:0] bin,
    output reg  [3:0] tens,
    output reg  [3:0] ones
);
    reg [4:0] tmp; // up to 12
    always @* begin
        tmp  = bin;
        tens = (tmp >= 10) ? 4'd1 : 4'd0;
        if (tmp >= 10) tmp = tmp - 10;
        ones = tmp[3:0];
    end
endmodule