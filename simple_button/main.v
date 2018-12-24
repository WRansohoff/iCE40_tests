`default_nettype none
module main(
  input  BTN,
  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5,
  );

  always
    begin
      LED1 <= ~BTN;
      LED2 <= ~BTN;
      LED3 <= ~BTN;
      LED4 <= ~BTN;
      LED5 <=  BTN;
    end
endmodule
