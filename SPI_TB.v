`timescale 1ns/100ps

module SPI_TB();

reg SS_m;

reg SCK_m;

reg MOSI_m;

wire MISO_m;
reg MISO_m_reg;

//assign MISO_m = MISO_m_reg;

reg         mem_initial_m;

///////////////////////////////
reg [7:0]  mem_ini_test [15:0];
initial begin
        $display("Loading rom.");
        $readmemh("hex_memory_file.mem", mem_ini_test);
    end
 

reg [7:0] mem_view_15;

always@(*)
begin
    mem_view_15 <= mem_ini_test[15];
end
//////////////////////////////////////////////


initial begin
    SS_m = 1'b1;
    SCK_m  =1'b1;
    MOSI_m = 1'b0;
    MISO_m_reg = 1'b0;
    end



always
    #10 SCK_m = ~SCK_m;

SPI_slave dut(
    .SS(SS_m),
    .SCK(SCK_m),
    .MOSI(MOSI_m),
    .MISO(MISO_m),
    .mem_initial(mem_initial_m)
);



initial
begin

    #10 mem_initial_m = 1'b1;
    #15 ;
    #5 SS_m =1'b0;MOSI_m = 1'b0;mem_initial_m = 1'b0;

    #200 SS_m= 1'b1;MOSI_m = 1'b0;

    #5 SS_m = 1'b0;MOSI_m = 1'b1;


    #20 SS_m = 1'b1;MOSI_m = 1'b0;


    #25 SS_m  = 1'b0;MOSI_m = 1'b1;


    #360             MOSI_m = 1'b0;

    #20             MOSI_m = 1'b1;

    end


initial
begin            
    $dumpfile("wave.vcd");        //生成的vcd文件名称
    $dumpvars(0, SPI_TB);    //tb模块名称
    
    #2000 ;
    $finish();
end


/*

module readmemh_tb();
    reg [7:0] test_memory [0:15];
    initial begin
        $display("Loading rom.");
        $readmemh("rom_image.mem", test_memory);
    end
endmodule


*/


endmodule