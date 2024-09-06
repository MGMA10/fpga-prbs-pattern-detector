module PRBS_15 (
    input clk,
    input rst_n,
    input [31:0] pattern_in,       
    input [7:0] n_repeats,        
    output reg [7:0] prbs_out     
);

  reg [7:0] pattern_counter;  
  reg [1:0] byte_counter;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
            begin
            prbs_out <= 8'hFF;
            pattern_counter <= 0;
            prbs_out <= 0;
            byte_counter <= 0;
            end 
        else 
            begin
                if(pattern_counter < n_repeats)
                begin
                    case (byte_counter)
                        0: prbs_out <= pattern_in[7:0];
                        1:prbs_out <= pattern_in[15:8];
                        2:prbs_out <= pattern_in[23:16];
                        3:prbs_out <= pattern_in[31:24];
                        default: prbs_out <= 8'hFF;
                    endcase
                    if (pattern_counter < 3)
                    pattern_counter<=pattern_counter+1;
                    else
                    pattern_counter <= 0;               
                    
                end
                else
            prbs_out <= {prbs_out[6:0],pattern_in[13]^pattern_in[14]};
    end
end


endmodule