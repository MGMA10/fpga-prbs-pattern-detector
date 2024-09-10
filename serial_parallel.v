module serial_parallel #(parameter N = 4) (
    input       clk,
    input       rst,
    input   [7:0]  data_serial,
    output reg [8*N-1:0]  data_parallel,
    output reg finsh
);
reg [$clog2(N)-1:0] counter;
always @(posedge clk or negedge rst) begin
    if(!rst)begin
        data_parallel <= 0;
        counter <= 0;
        finsh <= 0;
    end
    else
    begin
        if(!finsh)
        begin
            case (counter)
                0:data_parallel[7:0] <= data_serial;
                1:data_parallel[15:8] <= data_serial;
                2:data_parallel[23:16] <= data_serial;
                3:data_parallel[31:24] <= data_serial;
                default: data_parallel <= 0;
            endcase
            if(counter >= (N-1))
            begin
                finsh <=1;
            end
            counter <= counter +1;
        end
    end
end
    
endmodule