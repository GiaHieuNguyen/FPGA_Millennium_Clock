// Connects counters to HEX displays.
// mode_date=0 -> show HH:MM:SS
// mode_date=1 -> show DD/MM/YYYY

module top_module(
    input [17:0]       SW, 
    input  wire        clk_50MHz,
    output wire [6:0]  HEX7,
    output wire [6:0]  HEX6,
    output wire [6:0]  HEX5,
    output wire [6:0]  HEX4,
    output wire [6:0]  HEX3,
    output wire [6:0]  HEX2,
    output wire [6:0]  HEX1,
    output wire [6:0]  HEX0
);
    wire [5:0]  sec, min, day;
    wire [4:0]  hour;
    wire [3:0]  month;
    wire [11:0] year;
    wire        clk_1hz;
    wire        is_leap_year;

    wire mode_date = SW[0]; // Switch between time and date display

    top_counter u_cnt (
        .clk_50MHz   (clk_50MHz),
        .rst_n       (SW[17]),
        .set_sec     (SW[1]), 
        .set_min     (SW[2]), 
        .set_hour    (SW[3]), 
        .set_day     (SW[4]), 
        .set_month   (SW[5]), 
        .set_year    (SW[6]), 
        .inc         (SW[15]),       
        .dec         (SW[16]),
        .sec         (sec),
        .min         (min),
        .hour        (hour),
        .day         (day),
        .month       (month),
        .year        (year),
        .clk_1hz     (clk_1hz)
    );
 
    top_display u_disp (
        .clk_1hz     (clk_1hz),
        .set_sec     (SW[1]), 
        .set_min     (SW[2]), 
        .set_hour    (SW[3]), 
        .set_day     (SW[4]), 
        .set_month   (SW[5]), 
        .set_year    (SW[6]), 
        .mode_date   (mode_date),
        .hour(hour), .min(min), .sec(sec),
        .day(day), .month(month), .year(year),
        .HEX7(HEX7), .HEX6(HEX6), .HEX5(HEX5), .HEX4(HEX4),
        .HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0)
    );
endmodule
