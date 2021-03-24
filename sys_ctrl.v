module sys_ctrl(clk,reset,valid,is_inside,num,i_valid);
input clk;
input reset;
output reg valid;
output reg is_inside;
output [2:0] num;
output i_valid;


localparam INPUT_NUM    = 6;
localparam IDLE         = 2'b00;
localparam GETINPUT     = 2'b01;
localparam CALCULATE    = 2'b10;
localparam ANSWER       = 2'b11;
//FSM
reg [1:0] cur_state;
reg [1:0] nxt_state;
reg [2:0] input_cnt;
wire sys_input_full;
wire sys_cal_done;

always @(posedge clk or negedge reset) begin
    if(reset)
        cur_state <= IDLE;
    else
        cur_state <= nxt_state;
end

always @(*) begin
    case(cur_state)
        IDLE:nxt_state = GETINPUT;
        GETINPUT:if(sys_input_full) nxt_state = CALCULATE;
                 else nxt_state = GETINPUT;
        CALCULATE:if(sys_cal_done) nxt_state = ANSWER;
                  else nxt_state = CALCULATE;
        ANSWER:nxt_state = GETINPUT;
    endcase
end

always @(posedge clk or negedge reset) begin
    if(reset)
        input_cnt <= 3'b0;
    else if(cur_state == ANSWER)
        input_cnt <= 3'b0;
    else if(cur_state == GETINPUT)
        input_cnt <= input_cnt + 1'b1;
end

always @(*) begin
    case(cur_state)
        IDLE:begin
            valid = 1'b0;
            is_inside = 1'b0;
        end
        GETINPUT:begin
            valid = 1'b0;
            is_inside = 1'b0;
        end
        CALCULATE:begin
            valid = 1'b0;
            is_inside = 1'b0;
        end
        ANSWER:begin
            valid = 1'b1;
            is_inside = 1'b0;
        end
    endcase
end

assign sys_input_full = (input_cnt == INPUT_NUM);
assign num = input_cnt;
assign i_valid = (cur_state == GETINPUT);
//TEST
assign sys_cal_done = 1'b1;
endmodule