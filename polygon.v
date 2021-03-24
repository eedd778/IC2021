module polygon(clk,reset,X,Y,R,num,i_valid,start);
input clk;
input reset;
input [9:0] X,Y,R;
input [2:0] num;
input i_valid;
input start;

reg [9:0] point_X [5:0];
reg [9:0] point_Y [5:0];
reg [9:0] point_R [5:0];

always @(posedge clk) begin
    if(i_valid) begin
        point_X[num] <= X;
        point_Y[num] <= Y;
        point_R[num] <= R;
    end
end
endmodule