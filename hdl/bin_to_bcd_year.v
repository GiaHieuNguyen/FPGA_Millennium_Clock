module bin_to_bcd_year (
    input  [11:0] year,      
    output reg [3:0] d_thou, 
    output reg [3:0] d_hund, 
    output reg [3:0] d_tens, 
    output reg [3:0] d_ones  
);

    reg [11:0] n3;  // remainder after subtracting 2000/3000
    reg [11:0] n2;  // remainder after subtracting hundreds
    reg [11:0] n1;  // remainder after subtracting tens

    always @(year) begin
        //Thousands digit 
        if (year >= 3000) begin
            d_thou = 4'd3;
            n3 = year - 3000;
        end else begin
            d_thou = 4'd2;
            n3 = year - 2000;
        end

        //Hundreds digit 
        if (n3 >= 900)      begin d_hund = 4'd9; n2 = n3 - 900; end
        else if (n3 >= 800) begin d_hund = 4'd8; n2 = n3 - 800; end
        else if (n3 >= 700) begin d_hund = 4'd7; n2 = n3 - 700; end
        else if (n3 >= 600) begin d_hund = 4'd6; n2 = n3 - 600; end
        else if (n3 >= 500) begin d_hund = 4'd5; n2 = n3 - 500; end
        else if (n3 >= 400) begin d_hund = 4'd4; n2 = n3 - 400; end
        else if (n3 >= 300) begin d_hund = 4'd3; n2 = n3 - 300; end
        else if (n3 >= 200) begin d_hund = 4'd2; n2 = n3 - 200; end
        else if (n3 >= 100) begin d_hund = 4'd1; n2 = n3 - 100; end
        else                begin d_hund = 4'd0; n2 = n3;       end

        //Tens digit
        if (n2 >= 90)      begin d_tens = 4'd9; n1 = n2 - 90; end
        else if (n2 >= 80) begin d_tens = 4'd8; n1 = n2 - 80; end
        else if (n2 >= 70) begin d_tens = 4'd7; n1 = n2 - 70; end
        else if (n2 >= 60) begin d_tens = 4'd6; n1 = n2 - 60; end
        else if (n2 >= 50) begin d_tens = 4'd5; n1 = n2 - 50; end
        else if (n2 >= 40) begin d_tens = 4'd4; n1 = n2 - 40; end
        else if (n2 >= 30) begin d_tens = 4'd3; n1 = n2 - 30; end
        else if (n2 >= 20) begin d_tens = 4'd2; n1 = n2 - 20; end
        else if (n2 >= 10) begin d_tens = 4'd1; n1 = n2 - 10; end
        else               begin d_tens = 4'd0; n1 = n2;      end

        //Ones digit
        d_ones = n1[3:0]; 
    end

endmodule
