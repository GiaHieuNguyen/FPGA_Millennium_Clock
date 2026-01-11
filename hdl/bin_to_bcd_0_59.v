module bin_to_bcd_0_59(
    input  wire [5:0] bin,
    output reg  [3:0] tens,
    output reg  [3:0] ones
);
    reg [6:0] tmp; 
    always @(bin) begin
        tmp  = bin;
        tens = 4'd0;
        if (tmp >= 50) begin tens = 4'd5; tmp = tmp - 50; end
        else if (tmp >= 40) begin tens = 4'd4; tmp = tmp - 40; end
        else if (tmp >= 30) begin tens = 4'd3; tmp = tmp - 30; end
        else if (tmp >= 20) begin tens = 4'd2; tmp = tmp - 20; end
        else if (tmp >= 10) begin tens = 4'd1; tmp = tmp - 10; end
        ones = tmp[3:0];
    end
endmodule