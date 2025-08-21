//   mode_date=0:  [HEX7:blank][HEX6:blank][HEX5..HEX4:HH][HEX3..HEX2:MM][HEX1..HEX0:SS]
//   mode_date=1:  [HEX7..HEX6:DD][HEX5..HEX4:MM][HEX3..HEX0:YYYY]

module top_display(
    input  wire        mode_date,     // 0=time, 1=date
    // time
    input  wire [4:0]  hour,
    input  wire [5:0]  min,
    input  wire [5:0]  sec,
    // date
    input  wire [5:0]  day,
    input  wire [3:0]  month,
    input  wire [11:0] year,          // 2025..3025
    // control signals
    input  wire        clk_1hz,      // 1Hz clock signal
    input  wire        set_sec,      // Set seconds
    input  wire        set_min,      // Set minutes
    input  wire        set_hour,     // Set hours
    input  wire        set_day,      // Set day
    input  wire        set_month,    // Set month
    input  wire        set_year,     // Set year
    // HEX outputs (active-low segments)
    output wire [6:0]  HEX7,
    output wire [6:0]  HEX6,
    output wire [6:0]  HEX5,
    output wire [6:0]  HEX4,
    output wire [6:0]  HEX3,
    output wire [6:0]  HEX2,
    output wire [6:0]  HEX1,
    output wire [6:0]  HEX0
);
    // --------- BCD conversions ----------
    wire [3:0] h_t, h_o, m_t, m_o, s_t, s_o;
    wire [3:0] d_t, d_o, mo_t, mo_o;
    wire [3:0] y_th, y_h, y_t, y_o;

    bin_to_bcd_0_23 u_h (.bin(hour), .tens(h_t), .ones(h_o));
    bin_to_bcd_0_59 u_m (.bin(min),  .tens(m_t), .ones(m_o));
    bin_to_bcd_0_59 u_s (.bin(sec),  .tens(s_t), .ones(s_o));

    bin_to_bcd_1_31 u_d (.bin(day),   .tens(d_t),  .ones(d_o));
    bin_to_bcd_1_12 u_mo(.bin(month), .tens(mo_t), .ones(mo_o));

    bin_to_bcd_year  u_y (.year(year), .d_thou(y_th), .d_hund(y_h), .d_tens(y_t), .d_ones(y_o));

    // --------- Digit MUX for the 8 displays ----------
    // Choose which BCD nibble goes to which HEX based on mode_date
    reg [3:0] dig7, dig6, dig5, dig4, dig3, dig2, dig1, dig0;

    reg [7:0] blink_mask;
    always @(*) begin
        blink_mask = 8'b00000000; // Default: no blinking
        if (set_sec) blink_mask[0] = 1'b1;
        if (set_min) blink_mask[1] = 1'b1;
        if (set_hour) blink_mask[2] = 1'b1;
        if (set_day) blink_mask[3] = 1'b1;
        if (set_month) blink_mask[4] = 1'b1;
        if (set_year) blink_mask[5] = 1'b1;
    end

    always @* begin
        if (mode_date == 1'b0) begin
            // TIME: __ HH MM SS
            dig7 = 4'd10;
            dig6 = 4'd10; 
            dig5 = (blink_mask[2] && !clk_1hz) ? 4'd10 : h_t;
            dig4 = (blink_mask[2] && !clk_1hz) ? 4'd10 : h_o;
            dig3 = (blink_mask[1] && !clk_1hz) ? 4'd10 : m_t;
            dig2 = (blink_mask[1] && !clk_1hz) ? 4'd10 : m_o;
            dig1 = (blink_mask[0] && !clk_1hz) ? 4'd10 : s_t;
            dig0 = (blink_mask[0] && !clk_1hz) ? 4'd10 : s_o;  
        end else begin
            // DATE: DD MM YYYY
            dig7 = (blink_mask[3] && !clk_1hz) ? 4'd10 : d_t;
            dig6 = (blink_mask[3] && !clk_1hz) ? 4'd10 : d_o;
            dig5 = (blink_mask[4] && !clk_1hz) ? 4'd10 : mo_t;
            dig4 = (blink_mask[4] && !clk_1hz) ? 4'd10 : mo_o;
            dig3 = (blink_mask[5] && !clk_1hz) ? 4'd10 : y_th;
            dig2 = (blink_mask[5] && !clk_1hz) ? 4'd10 : y_h;
            dig1 = (blink_mask[5] && !clk_1hz) ? 4'd10 : y_t;
            dig0 = (blink_mask[5] && !clk_1hz) ? 4'd10 : y_o;   
        end
    end

    // --------- 7-seg encoders ----------
    seg7_dec u7(.digit(dig7), .HEX(HEX7));
    seg7_dec u6(.digit(dig6), .HEX(HEX6));
    seg7_dec u5(.digit(dig5), .HEX(HEX5));
    seg7_dec u4(.digit(dig4), .HEX(HEX4));
    seg7_dec u3(.digit(dig3), .HEX(HEX3));
    seg7_dec u2(.digit(dig2), .HEX(HEX2));
    seg7_dec u1(.digit(dig1), .HEX(HEX1));
    seg7_dec u0(.digit(dig0), .HEX(HEX0));
endmodule
