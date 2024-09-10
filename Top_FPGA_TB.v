`timescale 1ns/1ps

module Top_FPGA_TB;

    reg clk;
    reg rst_n;
    reg [7:0] pattern_in;
    reg [7:0] n_repeats;
    wire pattern_found;
    wire [7:0] prbs_out; 
    wire [31:0] patern;
    wire  finsh;
    wire [7:0] counter_patern;
    wire [7:0] rep;

    Top_FPGA Dut (
        .clk(clk),
        .rst_n(rst_n),
        .pattern_in(pattern_in),
        .n_repeats(n_repeats),
        .pattern_found(pattern_found),
        .prbs_out(prbs_out)
    );

    assign patern = Dut.data_parallel;
    assign finsh = Dut.finsh;
    assign counter_patern =  Dut.pattern_det_inst.pattern_counter ;
    assign rep =  Dut.pattern_det_inst.repeats ;
    initial begin
        
        clk = 0;
        rst_n = 0;
        pattern_in = $random %8'hFF;
        n_repeats = 8'd3;
        //test 1
        //Reset
        #30 rst_n = 1;
        #30 rst_n = 0;
        #30 rst_n = 1;

            pattern_in = 8'hAB;
        #10 pattern_in = 8'hCD;
        #10 pattern_in = 8'hEF;
        #10 pattern_in = 8'h58;
        #100

        //test with changing n_repeats
        //Reset
        #30 rst_n = 1;
        #30 rst_n = 0;
        #30 rst_n = 1;
        n_repeats = 8'd5;

                pattern_in = 8'hFA;
        #10     pattern_in = 8'hE1;
        #10     pattern_in = 8'h89;
        #10     pattern_in = 8'hEE;

        #40
        n_repeats = 8'd7;
        // test with out reset
        //n_repeats = 8'h06;
        pattern_in = 8'h35;
        #10     pattern_in = 8'hFE;
        #10     pattern_in = 8'h88;
        #10     pattern_in = 8'h12;
        #500

        #100 $stop;
    end
    always #5 clk = ~clk;  
endmodule
