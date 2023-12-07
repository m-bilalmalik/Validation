
module co_sim_rams_sp_wf_1024x32_neg;
    reg clk;
    reg we;
    reg [9:0] addr;
    reg [31:0] di;
    wire [31:0] dout, dout_net;

    integer mismatch=0;
    reg [31:0]cycle, i;

    rams_sp_wf_1024x32_neg golden(.*);
    rams_sp_wf_1024x32_neg_post_synth netlist(.*, .dout(dout_net));


    always #10 clk = ~clk;

    initial begin
    {clk, we, addr ,di, cycle, i} = 0;

    repeat (1) @ (posedge clk);

    //write, but will read the being written value (read through)
    for (integer i=0; i<1024; i=i+1)begin
        addr <= i; we <=1; di<= $random;
        cycle = cycle +1;
        repeat (1) @ (posedge clk)
        // $display ("%0t", $time);
        compare(cycle);

    end

    //not writing and reading from the addr of rams
    for (integer i=0; i<1024; i=i+1)begin
        addr <= i; we <=0;
        cycle = cycle +1;
        repeat (1) @ (posedge clk)
        compare(cycle);

    end

    //random
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (posedge clk)
        we<=$random;  addr<=$random; di<=$random;
        cycle = cycle +1;
        compare(cycle);

    end
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(posedge clk); $finish;
    end

    task compare(input integer cycle);
    //$display("\n Comparison at cycle %0d", cycle);
    if(dout !== dout_net) begin
        $display("dout mismatch. Golden: %0h, Netlist: %0h, Time: %0t, we=%b", dout, dout_net,$time,golden.we);
        mismatch = mismatch+1;
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule
