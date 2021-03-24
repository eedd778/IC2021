module geofence ( clk,reset,X,Y,R,valid,is_inside);
input clk;
input reset;
input [9:0] X;
input [9:0] Y;
input [10:0] R;
output valid;
output is_inside;

wire [2:0] num;
wire i_valid;

sys_ctrl sys_ctrl_block(
    .clk        (clk),
    .reset      (reset),
    .valid      (valid),
    .is_inside  (is_inside),
    .num        (num),
    .i_valid    (i_valid)
);

polygon polygon_block(
    .clk        (clk),
    .reset      (reset),
    .X          (X),
    .Y          (Y),
    .R          (R),
    .num        (num),
    .i_valid    (i_valid),
    .start      ()
);

endmodule

