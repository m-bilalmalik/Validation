
module co_sim_dual_port_rom_logic
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10);

    reg [(ADDR_WIDTH-1):0] addr_a, addr_b;
	reg clk;
	wire [(DATA_WIDTH-1):0] q_a, q_b, q_a_netlist, q_b_netlist;

    integer mismatch=0;
    reg [6:0] i;

    dual_port_rom_logic golden(.*);
    `ifdef PNR
    `else
        dual_port_rom_logic_post_synth netlist(.*, .q_a(q_a_netlist), .q_b(q_b_netlist));
    `endif


    always #10 clk = ~clk;

    initial begin
    {clk, addr_a, addr_b, i} = 0;

    repeat (1) @ (negedge clk);
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr_a <= $urandom_range(0,255); addr_b <= $urandom_range(256,512);
       
        compare();

    end

    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr_b <= $urandom_range(0,255); addr_a <= $urandom_range(256,512);
       
        compare();

    end

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk); $finish;
    end

    task compare();
    if(q_a !== q_a_netlist) begin
        $display("q_a mismatch. Golden: %0h, Netlist: %0h, Time: %0t", q_a, q_a_netlist,$time);
        mismatch = mismatch+1;
    end
    if(q_b !== q_b_netlist) begin
        $display("q_b mismatch. Golden: %0h, Netlist: %0h, Time: %0t", q_b, q_b_netlist,$time);
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule