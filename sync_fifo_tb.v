module sync_fifo_tb();
parameter fifo_depth=8;
parameter data_width=32;
reg clk;
reg rst;
reg cs;
reg wr_en;
reg rd_en;
reg [data_width-1:0]data_in;
wire[data_width-1:0]data_out;
wire empty;
wire full;
sync_fifo #(fifo_depth,data_width) dut(.clk(clk),.rst(rst),.cs(cs),.wr_en(wr_en),.rd_en(rd_en),
.data_in(data_in),.data_out(data_out),.empty(empty),.full(full));
initial begin
    $dumpfile("fifo.vcd");  
    $dumpvars(0, dut);      
end
initial clk=0;
always #5 clk=~clk;
initial begin
rst=1;
cs=1;
wr_en=0;
rd_en=0;
data_in=0;
#10 rst=0;
#10 wr_en=1;
data_in = 32'hA1;
#10 data_in= 32'hB2;
#10 data_in= 32'hC3;
#10 wr_en = 0;
#10 rd_en = 1;
#40 rd_en = 0;
#20 $finish;
end
endmodule