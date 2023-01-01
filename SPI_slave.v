module SPI_slave(
    input               SS,
    input               SCK,
    input               MOSI,
    output    reg       MISO,

    input               mem_initial
);



//write to mem, 8bit in clock;
    reg    [7:0]        slave_buffer_rx;

    wire   [7:0]        slave_buffer_tx_wire;
    reg    [7:0]        slave_buffer_tx;

    always@(*)
    slave_buffer_tx  = slave_buffer_tx_wire;

//write to slave_bufer_rx
    reg                 slave_buffer_mosi;
//read from slave_buffer_tx
    reg                 slave_buffer_miso;

//counter for states
    reg    [3:0]        cnt;

//Read or Write to slave mem definition
// ==1 read
// ==0 write
    wire                RW_define;
    reg                 RW_define_reg;
    assign              RW_define = RW_define_reg;

    wire   [3:0]        address;
    reg    [3:0]        address_reg;
    assign              address = address_reg;

    
//////////////////////////////////////////////////////////////////////

/////////////////
/////////////////////////////////////////
///////////////////////////////////////////////////////////


//mem and mem control signal lines




////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////


    //reg   [7:0]        mem [15:0];
    //$readmemh("ex1.mem", ex1_memory);

    
    //
    reg                mem_en_reg;
    wire               mem_en;

    assign               mem_en = (cnt ==4'd12)||(cnt ==4'd13)||(cnt ==4'd4)||((cnt ==4'd5));
    //assign             mem_en = ~SS;
    //assign             mem_en = mem_en_reg;

    wire               mem_we;
    wire               mem_re;





    assign mem_we = (cnt == 4'd13)&(SS == 1'b0)&(RW_define == 1'b0);

    assign mem_re = (cnt == 4'd5 )&(SS == 1'b0)&(RW_define == 1'b1);
    //mem_we= RW_define ? 1'b1 :1'b0;


/////////////////////////////////////////////////
///////////////////////////////
///////////////////////////////////////////////////////////////









mem mem0(

    .mem_clk(SCK),

    .mem_en(mem_en),
    .mem_address(address),

    .buffer_rx(slave_buffer_rx),
    .buffer_tx( slave_buffer_tx_wire),

    .mem_we(mem_we),
    .mem_re(mem_re),
    .mem_initial(mem_initial)
);











    always@(negedge SCK)
    begin
        if(cnt == 4'b1111)
            cnt <= 4'b0000;
        else if(!SS)
            begin
            cnt <= cnt +1'b1;
            end
        else
            cnt <= 4'b0000;

    end

    always@(*)//sensitive list
    begin
        slave_buffer_mosi = MOSI;
        
        if(RW_define ==1)
            begin MISO = slave_buffer_miso; end

    end

    
    always@(posedge SCK)


        case(cnt)
            4'd0: begin RW_define_reg = MOSI;end

            4'd1: begin address_reg[3]   = slave_buffer_mosi;          end
            4'd2: begin address_reg[2]   = slave_buffer_mosi;          end
            4'd3: begin address_reg[1]   = slave_buffer_mosi;          end
            4'd4: begin address_reg[0]   = slave_buffer_mosi;     /*mem_en_reg =1'b1; */     end

            4'd5: begin slave_buffer_rx[7] = slave_buffer_mosi;                         end
            4'd6: begin slave_buffer_rx[6] = slave_buffer_mosi;       slave_buffer_miso = slave_buffer_tx[7];                   end 
            4'd7: begin slave_buffer_rx[5] = slave_buffer_mosi;       slave_buffer_miso = slave_buffer_tx[6];                   end 
            4'd8: begin slave_buffer_rx[4] = slave_buffer_mosi;       slave_buffer_miso = slave_buffer_tx[5];                   end
            4'd9: begin slave_buffer_rx[3] = slave_buffer_mosi;       slave_buffer_miso = slave_buffer_tx[4];                   end
            4'd10: begin slave_buffer_rx[2] = slave_buffer_mosi;      slave_buffer_miso = slave_buffer_tx[3];                   end  
            4'd11: begin slave_buffer_rx[1] = slave_buffer_mosi;      slave_buffer_miso = slave_buffer_tx[2];                   end
            4'd12: begin slave_buffer_rx[0] = slave_buffer_mosi;      slave_buffer_miso = slave_buffer_tx[1];                   end

            4'd13: begin        /*mem_en_reg =1'b1;   */                  slave_buffer_miso = slave_buffer_tx[0];                   end






            default: begin  RW_define_reg = RW_define_reg; address_reg = address_reg; slave_buffer_rx = slave_buffer_rx;slave_buffer_tx = slave_buffer_tx; mem_en_reg = 1'b0; end
        endcase

  /*  
  always@(negedge SCK)

        case(cnt)
//working

            4'd1: begin address_reg[3]   = slave_buffer_mosi;          mem_en_reg =1'b1;end
            4'd2: begin address_reg[2]   = slave_buffer_mosi;          slave_buffer_miso = slave_buffer_tx[7];                  end
            4'd3: begin address_reg[1]   = slave_buffer_mosi;          slave_buffer_miso = slave_buffer_tx[6];                  end
            4'd4: begin address_reg[0]   = slave_buffer_mosi;          slave_buffer_miso = slave_buffer_tx[5];                  end
        
            4'd5: begin slave_buffer_rx[7] = slave_buffer_mosi;        slave_buffer_miso = slave_buffer_tx[4];                  end
            4'd6: begin slave_buffer_rx[6] = slave_buffer_mosi;        slave_buffer_miso = slave_buffer_tx[3];                  end 
            4'd7: begin slave_buffer_rx[5] = slave_buffer_mosi;        slave_buffer_miso = slave_buffer_tx[2];                  end 
            4'd8: begin slave_buffer_rx[4] = slave_buffer_mosi;        slave_buffer_miso = slave_buffer_tx[1];                  end
            4'd9: begin slave_buffer_rx[3] = slave_buffer_mosi;        slave_buffer_miso = slave_buffer_tx[0];                  end
            4'd10: begin slave_buffer_rx[2] = slave_buffer_mosi;                                                                end  
            4'd11: begin slave_buffer_rx[1] = slave_buffer_mosi;                         end
            4'd12: begin slave_buffer_rx[0] = slave_buffer_mosi;                         end

            4'd13: begin mem_en_reg <=1'b1;  end

//working




            default: begin  RW_define_reg = RW_define_reg; address_reg = address_reg; slave_buffer_rx = slave_buffer_rx;slave_buffer_tx = slave_buffer_tx; mem_en_reg = 1'b0; end
        endcase


*/




endmodule



module mem (
    input    mem_clk,

    input    mem_en,
    input    [3:0] mem_address,
    
    output  reg [7:0] buffer_tx,
    input    [7:0] buffer_rx,

    input    mem_we,
    input    mem_re,
    input    mem_initial
);
reg [7:0]  mem [15:0];

wire [7:0]      mem_view_binary_F;
assign          mem_view_binary_F = mem[15];  


wire [7:0]      mem_view_binary_D;
assign          mem_view_binary_D = mem[13];


wire [7:0]      mem_view_binary_A;
assign          mem_view_binary_A = mem[10];  


//
    always@(posedge mem_clk)// or mem_initial
    begin


/*
        if(mem_initial)
            begin
                mem[15]<=8'h00;
                mem[14]<=8'h00;
                mem[13]<=8'h00;
                mem[12]<=8'h00;
                mem[11]<=8'h00;
                mem[10]<=8'h00;
                mem[9]<=8'h00;
                mem[8]<=8'h00;
                mem[7]<=8'h00;
                mem[6]<=8'h00;
                mem[5]<=8'h00;
                mem[4]<=8'h00;
                mem[3]<=8'h00;
                mem[2]<=8'h00;
                mem[1]<=8'h00;
                mem[0]<=8'h00;

                buffer_tx <= 8'h11;

                 
            end

        else if(~mem_initial)

                          
            
            if(mem_we)
                begin
                 mem[mem_address] <= buffer_rx;
                 
                end
            else if(mem_re)
                buffer_tx <= mem[mem_address];
            
            else
            begin
                mem[15]<=mem[15];
                mem[14]<=mem[14];
                mem[13]<=mem[13];
                mem[12]<=mem[12];
                mem[11]<=mem[11];
                mem[10]<=mem[10];
                mem[9]<=mem[9];
                mem[8]<=mem[8];
                mem[7]<=mem[7];
                mem[6]<=mem[6];
                mem[5]<=mem[5];
                mem[4]<=mem[4];
                mem[3]<=mem[3];
                mem[2]<=mem[2];
                mem[1]<=mem[1];
                mem[0]<=mem[0];

                buffer_tx <= buffer_tx;
            end

        else


            begin
                mem[15]<=8'h00;
                mem[14]<=8'h00;
                mem[13]<=8'h00;
                mem[12]<=8'h00;
                mem[11]<=8'h00;
                mem[10]<=8'h00;
                mem[9]<=8'h00;
                mem[8]<=8'h00;
                mem[7]<=8'h00;
                mem[6]<=8'h00;
                mem[5]<=8'h00;
                mem[4]<=8'h00;
                mem[3]<=8'h00;
                mem[2]<=8'h00;
                mem[1]<=8'h00;
                mem[0]<=8'h00;

                buffer_tx <= 8'h22;

                 
            end
*/

case (mem_initial)
    1'b1:
    begin
                mem[15]<=8'h00;
                mem[14]<=8'h00;
                mem[13]<=8'h00;
                mem[12]<=8'h00;
                mem[11]<=8'h00;
                mem[10]<=8'h00;
                mem[9]<=8'h00;
                mem[8]<=8'h00;
                mem[7]<=8'h00;
                mem[6]<=8'h00;
                mem[5]<=8'h00;
                mem[4]<=8'h00;
                mem[3]<=8'h00;
                mem[2]<=8'h00;
                mem[1]<=8'h00;
                mem[0]<=8'h00;

                buffer_tx <= 8'h11;

                 
            end

        1'b0:
        begin 
            if(mem_we)
                begin
                 mem[mem_address] <= buffer_rx;
                 
                end
            else if(mem_re)
                buffer_tx <= mem[mem_address];
            
            else
            begin
                mem[15]<=mem[15];
                mem[14]<=mem[14];
                mem[13]<=mem[13];
                mem[12]<=mem[12];
                mem[11]<=mem[11];
                mem[10]<=mem[10];
                mem[9]<=mem[9];
                mem[8]<=mem[8];
                mem[7]<=mem[7];
                mem[6]<=mem[6];
                mem[5]<=mem[5];
                mem[4]<=mem[4];
                mem[3]<=mem[3];
                mem[2]<=mem[2];
                mem[1]<=mem[1];
                mem[0]<=mem[0];

                buffer_tx <= buffer_tx;
            end

        end

    default: 
            begin
                mem[15]<=8'h00;
                mem[14]<=8'h00;
                mem[13]<=8'h00;
                mem[12]<=8'h00;
                mem[11]<=8'h00;
                mem[10]<=8'h00;
                mem[9]<=8'h00;
                mem[8]<=8'h00;
                mem[7]<=8'h00;
                mem[6]<=8'h00;
                mem[5]<=8'h00;
                mem[4]<=8'h00;
                mem[3]<=8'h00;
                mem[2]<=8'h00;
                mem[1]<=8'h00;
                mem[0]<=8'h00;

                buffer_tx <= 8'h22;

                 
            end
endcase

        
    end
//






    
endmodule