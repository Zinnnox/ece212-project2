module ones_comp_add(
    input [3:0] a,
    input [3:0] b,
    output reg [3:0] out
);
    /*
    Applies ones complement addition. Add a and b, and then add the
    carry out to the ones bit of the result. The carry can be
    accessed by adding a and b and putting the result in a 5 bit reg.
    */
    //Do not modify above this line

    reg [4:0] sum;

    always @(*) begin
        sum = a + b; 
        out = sum[3:0] + sum[4]; // adds 1 if carry out is 1, 0 otherwise
    end 

endmodule