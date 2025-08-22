// Connect all counters and leap year check module together
module top_counter(
    input  wire clk_50MHz,
    input  wire rst_n,
    input wire  set_sec,
    input wire  set_min,
    input wire  set_hour,   
    input wire  set_day,
    input wire  set_month,
    input wire  set_year, 
    input  wire inc,      
    input  wire dec,
    output wire [5:0] sec,
    output wire [5:0] min,
    output wire [4:0] hour,
    output wire [5:0] day,
    output wire [3:0] month,
    output wire [11:0] year,
    output wire clk_1hz
);
    wire sec_carry_raw, min_carry_raw, 
        hour_carry_raw, day_carry_raw, month_carry_raw, is_leap_year;

    wire freeze = set_min | set_hour | set_day | set_month | set_year;

    reg [5:0]blink_mask;
    wire set_sec_in   = blink_mask[0];
    wire set_min_in   = blink_mask[1];
    wire set_hour_in  = blink_mask[2];
    wire set_day_in   = blink_mask[3];
    wire set_month_in = blink_mask[4];
    wire set_year_in  = blink_mask[5];

    always @(set_sec or set_min or set_hour or set_day or set_month or set_year) begin
        if      (set_sec)   blink_mask = 6'b000001;
        else if (set_min)   blink_mask = 6'b000010;
        else if (set_hour)  blink_mask = 6'b000100;
        else if (set_day)   blink_mask = 6'b001000;
        else if (set_month) blink_mask = 6'b010000;
        else if (set_year)  blink_mask = 6'b100000;
        else                blink_mask = 6'b000000;
    end
    
    clk_1hz #(25000000 - 1) u_clk1hz (
        .clk_50MHz(clk_50MHz),
        .rst_n(rst_n),
        .clk_1hz(clk_1hz)
    );

    sec_counter u_sec (
        .clk(clk_1hz),
        .rst_n(rst_n),
        .inc(inc),
        .dec(dec),
        .freeze(freeze),
        .ctrl_set(set_sec_in),
        .sec_count(sec),
        .carry_out(sec_carry_raw)
    );

    min_counter u_min (
        .clk(clk_1hz),
        .rst_n(rst_n),
        .inc(inc),
        .dec(dec),
        .ctrl_set(set_min_in),
        .carry_in_sec(sec_carry_raw),
        .min_count(min),
        .carry_out(min_carry_raw)
    );

    hour_counter u_hour (
        .clk(clk_1hz),
        .rst_n(rst_n),
        .inc(inc),
        .dec(dec),
        .ctrl_set(set_hour_in),
        .carry_in_min(min_carry_raw),
        .hour_count(hour),
        .carry_out(hour_carry_raw)
    );
    
    day_counter u_day (
        .clk(clk_1hz), 
        .rst_n(rst_n),
        .inc(inc), 
        .dec(dec), 
        .ctrl_set(set_day_in),
        .carry_in_hour(hour_carry_raw),
        .current_month(month), 
        .is_leap_year(is_leap_year),
        .day_count(day), 
        .carry_out(day_carry_raw)
    );

    month_counter u_month (
        .clk(clk_1hz), 
        .rst_n(rst_n),
        .inc(inc), 
        .dec(dec), 
        .ctrl_set(set_month_in),
        .carry_in_day(day_carry_raw),
        .month_count(month), 
        .carry_out(month_carry_raw)
    );

    year_counter #(.BASE_YEAR(2025), .MAX_YEAR(3025)) u_year (
        .clk(clk_1hz), 
        .rst_n(rst_n),
        .inc(inc), 
        .dec(dec), 
        .ctrl_set(set_year_in),
        .carry_in_month(month_carry_raw),
        .year_count(year)
    );

    leap_year_check u_ly (
        .clk(clk_1hz),
        .rst_n(rst_n),
        .current_year(year),
        .is_leap_year(is_leap_year)
    );

endmodule
