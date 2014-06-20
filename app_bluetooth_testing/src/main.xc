#include "../../platform.h"

#define DEBUG_PRINT_ENABLE 1

#include <print.h>
#include <debug_print.h>
#include <uart_fast_tx.h>
#include <uart_fast_rx.h>


in port p_rx = BLUETOOTH_RECEIVE;
out port p_tx = BLUETOOTH_TRANSMIT;
const clock ref_clk = XS1_CLKBLK_REF;
// 10416
void logic(streaming chanend bin, streaming chanend bout) {
  timer t; unsigned time;

  t :> time;

  while (1) {
    select {
      case bin :> unsigned char letter:

        if (letter =='\r')
          printchar('\n');
          else
        printchar(letter);
        break;

      case t when timerafter(time) :> void:
        time += 1000 * XS1_TIMER_KHZ;

        bout <: '.';

        break;
    }
  }
}

int main() {
  streaming chan bluetooth_in, bluetooth_out;

  par {
    on tile[0]: {
      uart_rx_fast_init(p_rx, ref_clk);
      uart_rx_fast(p_rx, bluetooth_in, 10416);
    }

    on tile[0]: {
      uart_tx_fast_init(p_tx, ref_clk);
      uart_tx_fast(p_tx, bluetooth_out, 10416);
    }

    on tile[0]: logic(bluetooth_in, bluetooth_out);
  }

  return 0;
}
