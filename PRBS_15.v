module PRBS_15 (
    input clk,
    input rst_n,
    input [31:0] pattern_in,       
    input [7:0] n_repeats,        
    output reg [7:0] prbs_out     
);

    reg [7:0] pattern_counter;  
    reg [1:0] byte_counter;
    reg [7:0] repeats;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n || n_repeats == 0) 
            begin
            prbs_out <= 8'hFF;
            pattern_counter <= 0;
            prbs_out <= 0;
            byte_counter <= 0;
            repeats <= n_repeats;
            end 
        else 
            begin
                if(pattern_counter < repeats)
                begin
                    case (byte_counter)
                        0: prbs_out <= pattern_in[31:24];
                        1:prbs_out <= pattern_in[23:16];
                        2:prbs_out <= pattern_in[15:8];
                        3:prbs_out <= pattern_in[7:0];
                        default: prbs_out <= 8'hFF;
                    endcase
                    if (byte_counter < 2'b11)
                        byte_counter<=byte_counter+1;
                    else
                        begin
                        byte_counter <= 2'b00;
                        pattern_counter <= pattern_counter+1;               
                        end
                end
                else
                if (byte_counter == 2'b11) begin
                    prbs_out <= {prbs_out[6:0],pattern_in[13]^pattern_in[14]};
                    byte_counter <= byte_counter+1;
                end
                else
                begin
                    byte_counter <= 0;
                    pattern_counter <= 0;
                end

            
    end
end


endmodule