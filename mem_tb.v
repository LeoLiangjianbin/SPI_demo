`timescale 1ns/100ps

module mem_tb ();

mem dut_mem(
    .mem_clk(clk),

    .mem_en(mem_en_t),
    .mem_address(mem_address_t),
    
    .buffer_rx(buffer_rx_t),
    .buffer_tx(buffer_tx_t),

    .mem_we(mem_we_t),
    .mem_re(mem_re_t),
    .mem_initial(mem_initial_t)
);



reg             clk;

reg             mem_en_t;

wire     [3:0]   mem_address_t;
reg      [3:0]   mem_address_t_reg;

assign           mem_address_t = mem_address_t_reg;



wire    [7:0]   buffer_tx_t;
reg     [7:0]   buffer_tx_t_reg;

always@(*)
        buffer_tx_t_reg = buffer_tx_t;


wire    [7:0]   buffer_rx_t;
reg     [7:0]   buffer_rx_t_reg;
assign          buffer_rx_t = buffer_rx_t_reg;


reg             mem_we_t;
reg             mem_re_t;
reg             mem_initial_t;

always
        #5 clk = ~clk;


initial 
begin
    clk=0;
    #1 ;
    #20 mem_en_t =1'b0;
    #20 mem_en_t =1'b1;


    #20 mem_initial_t = 1'b1;
    #20 ;
    #5  mem_initial_t = 1'b0;buffer_rx_t_reg = 8'b1111_0000;
    #20 mem_re_t = 1'b1; mem_we_t = 1'b0;mem_address_t_reg = 4'b1010; 
    #20 ;
    #20 mem_re_t = 1'b0; mem_we_t = 1'b1; 
    #20 ;
    #20 mem_re_t = 1'b1; mem_we_t = 1'b0;


    #2000 $finish(); 

end


initial
    begin
        $dumpfile("mem_wave.vcd");
        $dumpvars(0,mem_tb);
    end
    
endmodule