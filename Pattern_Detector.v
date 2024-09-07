module Pattern_Detector (
    input clk,
    input rst_n,
    input [7:0] data_in,        
    input [31:0] pattern,        
    input [7:0] n_repeats,     
    output reg pattern_found  
);

    reg [7:0] pattern_counter ; 
    reg [1:0] byte_counter;
    reg [1:0] current_state, next_state;

    localparam IDLE = 2'b00,
               MATCHING = 2'b01,
               FOUND = 2'b10;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
           current_state <= IDLE;
           next_state <= IDLE;
            pattern_counter  <= 0;
            pattern_found <= 0;
            byte_counter <=0;
        end else begin
           current_state <= next_state;
        end
    end

always @(*) begin
    case (current_state)
        IDLE:  begin
            if (data_in == pattern[31:24]) begin
                pattern_counter  = 1;
                byte_counter=1;
                next_state = MATCHING;
            end
            else begin
            next_state = IDLE;
            pattern_counter  = 0;
            byte_counter =0;
            end
        end
        MATCHING:  begin
            if (data_in == pattern[31:24] && byte_counter == 0) begin
                byte_counter =byte_counter+1;
            end
            else if (data_in == pattern[23:16] && byte_counter == 1) begin
                byte_counter =byte_counter+1;
            end
            else if (data_in == pattern[15:8] && byte_counter == 2) begin
                byte_counter =byte_counter+1;
            end
            else if (data_in == pattern[7:0] && byte_counter == 3) begin
                byte_counter =0;
                pattern_counter   = pattern_counter  + 1;
                if (pattern_counter  > n_repeats) 
                begin
                    pattern_found  = 1;
                    next_state  = FOUND;
                end
            end
            else begin
                pattern_counter = 0;
                next_state = IDLE;
            end
 
        end
        FOUND: begin
            pattern_found = 1;
        end
        default:next_state = IDLE;
    endcase
end

endmodule