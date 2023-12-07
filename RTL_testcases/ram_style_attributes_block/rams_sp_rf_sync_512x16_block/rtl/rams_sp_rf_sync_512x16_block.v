
module rams_sp_rf_sync_512x16_block (clk, we, addr, di, dout);
input clk;
input we;
input [8:0] addr;
input [15:0] di;
output [15:0] dout;

(* ram_style = "block" *)
reg [15:0] RAM [511:0];
reg [15:0] dout;

always @(posedge clk)
    begin
        if (we)
        begin
            RAM[addr] <= di;
        end
            dout <= RAM[addr];
    end
endmodule