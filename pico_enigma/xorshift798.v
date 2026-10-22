module xorshift798(
    input clk,
    input reset,
    input [15:0] seed,
    output reg [15:0] random
);
    /*
    Pseudorandom number generator. Each clock cycle applies
    the following mutation to the input:

    XOR the seed with itself left shifted by 7 bits.
    XOR the previous result with itself right shifted 9 bits.
    XOR the previous result with itself left shifted by 8 bits.

    A seed of 0 is not allowed, since it will
    just produce zeros. So interpret a 0 input
    as 16'h0100.

    If reset is high, random will be set to seed at next clock edge
    */
    //Do not modify above this line

    reg [15:0] new_random;

    always @(posedge clk) begin
        if (reset) begin
            if (seed == 0) random <= 16'h0100;
            else random <= seed;
        end
        else begin
            new_random = random;

            new_random = new_random ^ (new_random << 7);
            new_random = new_random ^ (new_random >> 9);
            new_random = new_random ^ (new_random << 8);

            random <= new_random;
        end
    end

endmodule