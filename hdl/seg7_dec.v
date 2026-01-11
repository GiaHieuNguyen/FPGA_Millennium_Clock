module seg7_dec(
    input  wire [3:0] digit,    
    output reg  [6:0] HEX
);
    always @(digit) begin
            case (digit)
                4'd0: HEX = 7'b100_0000;
                4'd1: HEX = 7'b111_1001;
                4'd2: HEX = 7'b010_0100;
                4'd3: HEX = 7'b011_0000;
                4'd4: HEX = 7'b001_1001;
                4'd5: HEX = 7'b001_0010;
                4'd6: HEX = 7'b000_0010;
                4'd7: HEX = 7'b111_1000;
                4'd8: HEX = 7'b000_0000;
                4'd9: HEX = 7'b001_0000;
                default: HEX = 7'b111_1111; 
            endcase
        end
endmodule
