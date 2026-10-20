module sbox(
    input en,
    input [3:0] in,
    output reg [3:0] out
);
    /*
    Substitution box, as described in the spec.
    If en is low, just pass in through to out unchanged.
    */
    //Do not modify above this line

    always @(*) begin
        if (en) begin
            case (in)
                4'd0: out = 4'd10;
                4'd1: out = 4'd14;
                4'd2: out = 4'd13;
                4'd3: out = 4'd7;
                4'd4: out = 4'd15;
                4'd5: out = 4'd9;
                4'd6: out = 4'd8;
                4'd7: out = 4'd3;
                4'd8: out = 4'd6;
                4'd9: out = 4'd5;
                4'd10: out = 4'd0;
                4'd11: out = 4'd12;
                4'd12: out = 4'd11;
                4'd13: out = 4'd2;
                4'd14: out = 4'd1;
                4'd15: out = 4'd4;
            endcase
        end
        else out = in;
    end

endmodule