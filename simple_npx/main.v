`default_nettype none
module main(
  input  clk,
  output leds,
  );

  // Neopixel state machine.
  reg [2:0] state;
  reg [1:0] npxc;
  reg [12:0] lpxc;
  reg [7:0] bits;
  reg [7:0] led_num;
  reg [24:0] test_color;
  assign test_color = 24'b000111110000000000111111;
  // Process the state machine at each 12MHz clock edge.
  always@(posedge clk)
    begin
      // Process the state machine; states 0-3 are the four WS2812B 'ticks',
      // each consisting of 83.33 * 4 ~= 333.33 nanoseconds. Four of those
      // ticks are then ~1333.33 nanoseconds long, and we can get close to
      // the ideal 1250ns period.
      // A '1' is 3 high periods followed by 1 low period (999.99/333.33 ns)
      // A '0' is 1 high period followed by 3 low periods (333.33/999.99 ns)
      if (state == 0 || state == 1 || state == 2 || state == 3)
        begin
          npxc = npxc + 1;
          if (npxc == 0)
            begin
              state = state + 1;
            end
        end
      if (state == 4)
        begin
          bits = bits + 1;
	  if (bits == 24)
            begin
              bits = 0;
              state = state + 1;
            end
          else
            begin
              state = 0;
            end
        end
      if (state == 5)
        begin
          led_num = led_num + 1;
          if (led_num == 96)
            begin
              led_num = 0;
              state = state + 1;
            end
          else
            begin
              state = 0;
            end
        end
      if (state == 6)
        begin
          lpxc = lpxc + 1;
          if (lpxc == 0)
            begin
              state = 0;
            end
        end
      // Set the correct pin state.
      if (test_color & (1 << bits))
        begin
        if (state == 0 || state == 1 || state == 2)
          begin
            leds <= 1;
          end
        else if (state == 3 || state == 6)
          begin
            leds <= 0;
          end
        end
      else
        begin
        if (state == 0)
          begin
            leds <= 1;
          end
        else if (state == 1 || state == 2 || state == 3 || state == 6)
          begin
            leds <= 0;
          end
      end
    end
endmodule
