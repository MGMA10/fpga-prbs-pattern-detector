module Top_FPGA (
    input clk,
    input rst_n,
    input [7:0] pattern_in,   
    input [7:0] n_repeats, 
    output pattern_found,
    output [7:0] prbs_out     
);
   wire [31:0] data_parallel ;
   wire finsh;

    serial_parallel sp(
        .clk(clk),
        .rst(rst_n),
        .data_serial(pattern_in),
        .data_parallel(data_parallel),
        .finsh(finsh)
    );
   
    PRBS_15 prbs_inst (
        .clk(clk),
        .rst_n(finsh),
        .pattern_in(data_parallel),
        .n_repeats(n_repeats),
        .prbs_out(prbs_out)
    );

    
    Pattern_Detector pattern_det_inst (
        .clk(clk),
        .rst_n(finsh),
        .data_in(prbs_out),
        .pattern(data_parallel),   
        .n_repeats(n_repeats),
        .pattern_found(pattern_found)
    );


endmodule