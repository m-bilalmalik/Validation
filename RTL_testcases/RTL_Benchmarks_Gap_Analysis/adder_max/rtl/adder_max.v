// Creating a scalable adder

module adder_max(cout, sum, a, b, cin);
parameter size = 190;  /* declare a parameter. default required */
output cout;
output [size-1:0] sum; 	 // sum uses the size parameter
input cin;
input [size-1:0] a, b;  // 'a' and 'b' use the size parameter

assign {cout, sum} = a + b + cin;

endmodule









