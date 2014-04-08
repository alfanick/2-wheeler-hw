#include <xs1.h>
#include <platform.h>
#include <print.h>
#include <timer.h>

void led_timer(chanend c, unsigned delay) {
  timer t;
  unsigned time;
  const unsigned delay_ticks = delay * XS1_TIMER_KHZ;
  unsigned state = 0;

  t :> time;

  while (1) {
    select {
      case t when timerafter(time + delay_ticks) :> void:
        c <: state;
        state = !state;
        time += delay_ticks;
        break;
    }
  }
}

void led_sender(chanend c, out port o) {
  unsigned state;

  while (1) {
    c :> state;
    o <: ~(state << 11);

    printstrln(state ? "ON" : "OFF");
  }
}

out port led_port = XS1_PORT_32A;

int main() {
  chan led_status;

  par {
    on tile[0]: led_timer(led_status, 1000);
    on tile[0]: led_sender(led_status, led_port);
  }

  return 0;
}
