// -----------------------------------------------------------------------------
// Auto-Generated by:        __   _ __      _  __
//                          / /  (_) /____ | |/_/
//                         / /__/ / __/ -_)>  <
//                        /____/_/\__/\__/_/|_|
//                     Build your hardware, easily!
//                   https://github.com/enjoy-digital/litex
//
// Filename   : ocla_wrapper3_v1_0.v
// Device     : gemini
// LiteX sha1 : --------
// Date       : 2024-03-22 15:36:22
//------------------------------------------------------------------------------
// This file is Copyright (c) 2022 RapidSilicon
//--------------------------------------------------------------------------------

`timescale 1ns / 1ps

//------------------------------------------------------------------------------
// Module
//------------------------------------------------------------------------------

module ocla_mode_axilite4_mem_depth_32 #(
	parameter IP_TYPE 		= "OCLA",
	parameter IP_VERSION 	= 32'h1, 
	parameter IP_ID 		= 32'h5633916
)
(    input  wire          clk,
    input  wire          rstn,
    input  wire          jtag_tck,
    input  wire          jtag_tms,
    input  wire          jtag_tdi,
    output wire          jtag_tdo,
    input  wire          jtag_trst,
    input  wire          axi_sampling_clk,
    input  wire   [31:0] awaddr,
    input  wire    [2:0] awprot,
    input  wire          awvalid,
    input  wire          awready,
    input  wire   [31:0] wdata,
    input  wire    [3:0] wstrb,
    input  wire          wvalid,
    input  wire          wready,
    input  wire    [1:0] bresp,
    input  wire          bvalid,
    input  wire          bready,
    input  wire   [31:0] araddr,
    input  wire    [2:0] arprot,
    input  wire          arvalid,
    input  wire          arready,
    input  wire   [31:0] rdata,
    input  wire    [1:0] rresp,
    input  wire          rvalid,
    input  wire          rready
);


//------------------------------------------------------------------------------
// Signals
//------------------------------------------------------------------------------

wire          sys_clk;
wire          rstn_rst;
wire   [31:0] awaddr_1;
wire    [2:0] awprot_1;
wire          awvalid_1;
wire          awready_1;
wire   [31:0] wdata_1;
wire    [3:0] wstrb_1;
wire          wvalid_1;
wire          wready_1;
wire    [1:0] bresp_1;
wire          bvalid_1;
wire          bready_1;
wire   [31:0] araddr_1;
wire    [2:0] arprot_1;
wire          arvalid_1;
wire          arready_1;
wire   [31:0] rdata_1;
wire    [1:0] rresp_1;
wire          rvalid_1;
wire          rready_1;
wire          jtag_tck_1;
wire          jtag_tms_1;
wire          jtag_tdi_1;
wire          jtag_tdo_1;
wire          jtag_trst_1;
reg           probes_in = 1'd0;
reg   [249:0] axifull = 250'd0;
wire          axi_sampling_clk_1;
reg           sampling_clk = 1'd0;

//------------------------------------------------------------------------------
// Combinatorial Logic
//------------------------------------------------------------------------------

assign sys_clk = clk;
assign rstn_rst = rstn;
assign jtag_tck_1 = jtag_tck;
assign jtag_tms_1 = jtag_tms;
assign jtag_tdi_1 = jtag_tdi;
assign jtag_tdo = jtag_tdo_1;
assign jtag_trst_1 = jtag_trst;
assign axi_sampling_clk_1 = axi_sampling_clk;
assign awaddr_1 = awaddr;
assign awprot_1 = awprot;
assign awvalid_1 = awvalid;
assign awready_1 = awready;
assign wdata_1 = wdata;
assign wstrb_1 = wstrb;
assign wvalid_1 = wvalid;
assign wready_1 = wready;
assign bresp_1 = bresp;
assign bvalid_1 = bvalid;
assign bready_1 = bready;
assign araddr_1 = araddr;
assign arprot_1 = arprot;
assign arvalid_1 = arvalid;
assign arready_1 = arready;
assign rdata_1 = rdata;
assign rresp_1 = rresp;
assign rvalid_1 = rvalid;
assign rready_1 = rready;


//------------------------------------------------------------------------------
// Synchronous Logic
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// Specialized Logic
//------------------------------------------------------------------------------

ocla_debug_subsystem #(
	.AXI_Core_BaseAddress(32'h02000000),
	.Axi_Type("AXILite"),
	.Cores(1),
	.EIO_BaseAddress(32'h01000000),
	.EIO_Enable(0),
	.IF01_BaseAddress(32'h03000000),
	.IF01_Probes(64'h0000000000000000),
	.IF02_BaseAddress(32'h04000000),
	.IF02_Probes(64'h0000000000000000),
	.IF03_BaseAddress(32'h05000000),
	.IF03_Probes(64'h0000000000000000),
	.IF04_BaseAddress(32'h06000000),
	.IF04_Probes(64'h0000000000000000),
	.IF05_BaseAddress(32'h07000000),
	.IF05_Probes(64'h0000000000000000),
	.IF06_BaseAddress(32'h08000000),
	.IF06_Probes(64'h0000000000000000),
	.IF07_BaseAddress(32'h09000000),
	.IF07_Probes(64'h0000000000000000),
	.IF08_BaseAddress(32'h01000000),
	.IF08_Probes(64'h0000000000000000),
	.IF09_BaseAddress(32'h01100000),
	.IF09_Probes(64'h0000000000000000),
	.IF10_BaseAddress(32'h01200000),
	.IF10_Probes(64'h0000000000000000),
	.IF11_BaseAddress(32'h01300000),
	.IF11_Probes(64'h0000000000000000),
	.IF12_BaseAddress(32'h01400000),
	.IF12_Probes(64'h0000000000000000),
	.IF13_BaseAddress(32'h01500000),
	.IF13_Probes(64'h0000000000000000),
	.IF14_BaseAddress(32'h01600000),
	.IF14_Probes(64'h0000000000000000),
	.IF15_BaseAddress(32'h01700000),
	.IF15_Probes(64'h0000000000000000),
	.IP_ID(IP_ID),
	.IP_TYPE(IP_TYPE),
	.IP_VERSION(IP_VERSION),
	.Mem_Depth(32),
	.Mode("AXI"),
	.No_AXI_Bus(1),
	.No_Probes(0),
	.Probe01_Width(11'd0),
	.Probe02_Width(11'd0),
	.Probe03_Width(11'd0),
	.Probe04_Width(11'd0),
	.Probe05_Width(11'd0),
	.Probe06_Width(11'd0),
	.Probe07_Width(11'd0),
	.Probe08_Width(11'd0),
	.Probe09_Width(11'd0),
	.Probe10_Width(11'd0),
	.Probe11_Width(11'd0),
	.Probe12_Width(11'd0),
	.Probe13_Width(11'd0),
	.Probe14_Width(11'd0),
	.Probe15_Width(11'd0),
	.Probes_Sum(14'd152),
	.Sampling_Clk("SINGLE")
) ocla_debug_subsystem (
	.ACLK(sys_clk),
	.RESETn(rstn_rst),
	.axi4_probes(axifull),
	.axiLite_probes({rready_1, rvalid_1, rresp_1, rdata_1, arready_1, arvalid_1, arprot_1, araddr_1, bready_1, bvalid_1, bresp_1, wready_1, wvalid_1, wstrb_1, wdata_1, awready_1, awvalid_1, awprot_1, awaddr_1}),
	.axi_sampling_clk(axi_sampling_clk_1),
	.jtag_tck(jtag_tck_1),
	.jtag_tdi(jtag_tdi_1),
	.jtag_tms(jtag_tms_1),
	.jtag_trst(jtag_trst_1),
	.native_sampling_clk(sampling_clk),
	.probes(1'd0),
	.probes_in(probes_in),
	.jtag_tdo(jtag_tdo_1)
);

endmodule

// -----------------------------------------------------------------------------
//  Auto-Generated by LiteX on 2024-03-22 15:36:22.
//------------------------------------------------------------------------------
