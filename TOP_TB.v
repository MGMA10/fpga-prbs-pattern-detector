`timescale 1ns/1ps

module Top_TB;

    reg clk;
    reg rst_n;
    reg [31:0] pattern_in;
    reg [7:0] n_repeats;
    wire pattern_found1;
    wire pattern_found2;
    wire [7:0] prbs_out1; 
    wire [7:0] prbs_out2;
    Top Dut (
        .clk(clk),
        .rst_n(rst_n),
        .pattern_in(pattern_in),
        .n_repeats(n_repeats),
        .pattern_found(pattern_found1),
        .prbs_out(prbs_out1)
    );
    
    PRBS_15 prbs_inst (
        .clk(clk),
        .rst_n(rst_n),
        .pattern_in(pattern_in),
        .n_repeats(n_repeats),
        .prbs_out(prbs_out2)
    );

    Pattern_Detector pattern_det_inst (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(prbs_out2),
        .pattern(pattern_in),   
        .n_repeats(n_repeats),
        .pattern_found(pattern_found2)
    );

    initial begin
        $dumpfile("Top_Module_tb.vcd");
        $dumpvars(0, Top_TB);
        
        clk = 0;
        rst_n = 0;
        pattern_in = $random %32'hFFFFFFFF;
        n_repeats = 8'd3;

        //Reset
        #30 rst_n = 1;
        #30 rst_n = 0;
        #30 rst_n = 1;

        pattern_in = $random %32'hFFFFFFFF;
        n_repeats = 8'd2;
        #200;

        pattern_in = $random %32'hFFFFFFFF;
        n_repeats = 8'd3;
        #100;

        //Reset
        #10 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;

        pattern_in = $random %32'hFFFFFFFF;
        n_repeats = 8'd3;
        #10;
        pattern_in = pattern_in +1;
        #20

        pattern_in = $random %32'hFFFFFFFF;
        // End simulation
        #100 $stop;
    end
    always #5 clk = ~clk;  
endmodule
