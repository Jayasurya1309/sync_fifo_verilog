module sync_fifo(clk,rst,cs,wr_en,rd_en,data_in,data_out,empty,full);
parameter fifo_depth = 8;
parameter data_width = 32;
input clk;
input rst;
input cs;
input wr_en;
input rd_en;
input [data_width-1:0]data_in;
output reg[data_width-1:0]data_out;
output empty;
output full;
parameter fifo_depth_log = $clog2(fifo_depth);
reg[data_width-1:0]fifo[0:fifo_depth-1];
reg[fifo_depth_log:0]wr_ptr;
reg[fifo_depth_log:0]rd_ptr;
//write
always@(posedge clk or posedge rst)
begin
  if(rst)
  wr_ptr<=0;
  else if(cs&&wr_en&&!full)begin
  fifo[wr_ptr[fifo_depth_log-1:0]]<=data_in;
  wr_ptr<=wr_ptr+1'b1;
  end
end
//read
always@(posedge clk or posedge rst)
begin
if(rst)begin
rd_ptr<=0;
data_out<=0;
end
else if (cs&&rd_en&&!empty)begin
data_out<=fifo[rd_ptr[fifo_depth_log-1:0]];
rd_ptr<= rd_ptr+1'b1;
end
end
//empty&full logic
assign empty=(rd_ptr==wr_ptr);
assign full=(rd_ptr=={~wr_ptr[fifo_depth_log],wr_ptr[fifo_depth_log-1:0]});
endmodule