`timescale 1ns/1ps
module co_sim_dsp_mul_signed_in_not_reg_with_accum_output_is_reg_neg;
	reg signed [19:0] A;
	reg signed [17:0] B;
	reg clk, reset, subtract_i;
	wire signed [37:0] P;
	wire signed [37:0] P_netlist;

	integer mismatch=0;

dsp_mul_signed_in_not_reg_with_accum_output_is_reg_neg golden(.*);
    `ifdef PNR
    `else
    dsp_mul_signed_in_not_reg_with_accum_output_is_reg_neg_post_synth netlist(.*, .P(P_netlist));
    `endif

//clock initialization
initial begin
    clk = 1'b1;
    forever #5 clk = ~clk;
end
initial begin
	reset = 1;
	A=0;
	B=0;
	subtract_i = 0;
	@(posedge clk);
	reset = 1;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(posedge clk);

	$display ("\n\n***Directed Functionality Test is applied for P = P + A*B***\n\n");
	A = 5;
	B = 2;
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P + A*B is ended***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P + A*B***\n\n");
	A = $random( );
	B = $random( );
	repeat (500) begin
		display_stimulus();
		@(posedge clk);
		@(posedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for P = P + A*B are ended***\n\n");

	reset =1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	subtract_i = 1;
	reset=0;
	@(posedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P - A*B***\n\n");
	A = $random( );
	B = $random( );
	repeat (500) begin
		display_stimulus();
		@(posedge clk);
		@(posedge clk);
		compare();
	end
	$display ("\n\n*** Random Functionality Tests with signed inputs for P = P - A*B is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for P = P + A*B***\n\n");
	A = 20'hfffff;
	B = 18'h3ffff;
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P + A*B is ended***\n\n");
	if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	
  	if(P !== P_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", P, P_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", P, P_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: A=%0d, B=%0d", A, B);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule