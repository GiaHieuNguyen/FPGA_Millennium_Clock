`timescale 1ns/1ps

module tb_top_counter;

    // DUT signals
    reg clk_50MHz;
    reg rst_n;
    reg set_sec;
    reg set_min;
    reg set_hour;
    reg set_day;
    reg set_month;
    reg set_year;
    reg inc, dec;
    reg clk_1hz;

    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hour;
    wire [5:0] day;
    wire [3:0] month;
    wire [11:0] year;
    wire is_leap_year;

    top_counter dut (
        .clk_50MHz(clk_50MHz),
        .rst_n(rst_n),
        .set_sec(set_sec),
        .set_min(set_min),
        .set_hour(set_hour),
        .set_day(set_day),
        .set_month(set_month),
        .set_year(set_year),
        .inc(inc),
        .dec(dec),
        .sec(sec),
        .min(min),
        .hour(hour),
        .day(day),
        .month(month),
        .year(year),
        .clk_1hz(clk_1hz)
    );

    initial clk_50MHz = 0;
    always #10 clk_50MHz = ~clk_50MHz;  

    initial begin
        $dumpfile("top_counter_tb.vcd");
        $dumpvars(0, tb_top_counter);

        // Reset
        rst_n = 0;
        set_sec = 0;
        set_min = 0;
        set_hour = 0;
        set_day = 0;
        set_month = 0;
        set_year = 0;
        inc = 0;
        dec = 0;
        #100;
        rst_n = 1;

        repeat (40000) @(posedge clk_50MHz);

        $display("Simulation finished at time %t", $time);
        $finish;
    end

    // ------------------------------
    // Monitor outputs
    // ------------------------------
    always @(posedge dut.clk_1hz) begin
        $display("Time: %0d:%0d:%0d | Date: %0d/%0d/%0d | Leap=%b",
                  hour, min, sec, day, month, year, is_leap_year);
    end

endmodule
