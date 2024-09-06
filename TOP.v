module Top_Module (
    input clk,
    input rst_n,
    input [31:0] pattern_in,   
    input [7:0] n_repeats, 
    output pattern_found     
);

    wire [7:0] prbs_data;     

   
    PRBS_15 prbs_inst (
        .clk(clk),
        .rst_n(rst_n),
        .pattern_in(pattern_in),
        .n_repeats(n_repeats),
        .prbs_out(prbs_data)
    );

    
    Pattern_Detector pattern_det_inst (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(prbs_data),
        .pattern(pattern_in),   
        .n_repeats(n_repeats),
        .pattern_found(pattern_found)
    );

endmodule