module integrator
/*********************************************************************************************/
#(parameter idw = 8 , odw = 9)
/*********************************************************************************************/
(
    input   clk,
    input   reset_n,
    input   signed [idw-1:0] data_in,
    output  reg signed [odw-1:0] data_out
);
/*********************************************************************************************/
always_ff @(posedge clk)
begin
    if (!reset_n)
        data_out <= '0;
    else
        data_out <= data_out + data_in;
end
/*********************************************************************************************/
endmodule
