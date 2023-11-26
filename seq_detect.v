module seq_detect(clk,reset,x,z,s1,s2,s3,s4);
    input x,clk,reset;
    output reg z,s1,s2,s3,s4;
    parameter idle=3'b000,sl1=3'b001,sl2=3'b010,sl3=3'b011,sl4=3'b100;
    reg [2:0]next_st;
    reg y;
    always@(posedge clk)
    begin
        if(!reset)
        begin
            next_st<=idle;
            z<=0;
        end
        else
        begin
            case(next_st)
                idle:begin
                    if(x==1'b0|x==1'b1)
                    begin
                    y<=x;
                    next_st<=sl1;
                end
                end
                sl1:begin
                    s1<=1'b1;
                    if(x==~y)
                    next_st<=sl2;
                    else
                    next_st<=idle;
                end
                sl2:begin
                    s2<=1'b1;
                    if(x==1'b0)
                    next_st<=sl3;
                    else
                    next_st<=idle;
                end
                sl3:begin
                    s3<=1'b1;
                    if(x==1'b1)
                    next_st<=sl4;
                    else
                    next_st<=idle;
                end
                sl4:begin
                    s4<=1'b1;
                    z<=z+1;
                    next_st<=idle;
                end
        endcase
    end
end
endmodule
