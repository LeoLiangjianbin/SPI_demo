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