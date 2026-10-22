module main(
    input clk,
    input [3:0] btn,
    input [7:0] sw,
    output strobe,
    output data,
    output shift_clk
);
    /*
    Top module. The following modules will be used in this:
        -enigma
        -sevseg_disp
        -swap
        -debounce

    enigma will take inputs from the buttons and switches
        -btn[0] OR btn[1] will be the clock
        -btn[1] will be the reset
        -sw[7:0] will be the seed
        -sw[3:0] will be the input

    btn[0] and btn[1] must be debounced, since they are being used as a clock.
    OR the debounced btn[0] and debounced btn[1] together to make the clock
    for enigma. This way pressing btn[1] will load the seed without also
    having to press btn[0].

    Use the raw btn[1] as the reset, not the debounced btn[1]. The debounced
    signal changes at the same time as the clock, so enigma may not see the
    reset. The raw btn[1] will already be high when the clock edge happens.

    By default, the LEDs will be set up as follows:
        -The seven segment display will show the output of enigma
        -The decimal point on the 7seg will show the clock for enigma
        -led[7:4] will show the XOR key from the enigma module
        -led[3:0] will show the input
    Pressing btn[2] will enable the swap module, which will swap what
    shows up on led[3:0] and the seven segment display

    Pressing btn[3] will set led[7:0] to sw[7:0].
    */
    wire [7:0] seven_seg;
    reg [7:0] led;
    shift_reg sreg(led, seven_seg, clk, strobe, data, shift_clk);

    wire db_btn0, db_btn1;
    debounce db0(clk, btn[0], db_btn0);
    debounce db1(clk, btn[1], db_btn1);

    wire [3:0] enigma_out, enigma_key;
    enigma enigma1(
        .clk(db_btn0  | db_btn1),
        .reset(btn[1]),
        .seed(sw[7:0]),
        .in(sw[3:0]),
        .out(enigma_out),
        .key(enigma_key)
    );

    wire [3:0] sevensegd_in, led30_in;
    swap swap1(
        .en(btn[2]),
        .a(enigma_out),
        .b(sw[3:0]),    
        .x(sevensegd_in),
        .y(led30_in)
    );
    
    sevseg_disp disp(
        .in(sevensegd_in),
        .dp(db_btn0 | db_btn1),
        .segs(seven_seg)
    );
    
    always @(*) begin
        // if btn[3] is pressed, leds will show sw[7:0]
        if (btn[3]) led[7:0] = sw[7:0];
        else begin 
            // otherwise, [7:4] will show the key 
            led[7:4] = enigma_key;
            // and [3:0] will show the input or output depending on swap
            led[3:0] = led30_in;
        end
    end

endmodule