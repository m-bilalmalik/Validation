module dsp_mul_complex_eq(a, b, z, z1, z2);
input [15:0] a, b;
output [31:0] z, z1, z2;
assign z = {((a[15:8]*b[15:8])-(a[7:0]*b[7:0])),((a[15:8]*b[7:0])+(a[7:0]*b[15:8]))};
assign z1 = {((a[15:8]*b[15:8])+(a[7:0]*b[7:0])),((a[15:8]*b[7:0])-(a[7:0]*b[15:8]))};
assign z2 = {((a[15:8]*b[15:8])+(a[7:0]*b[7:0])),((a[15:8]*b[7:0])+(a[7:0]*b[15:8]))};
endmodule