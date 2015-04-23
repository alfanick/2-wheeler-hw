#ifndef APP_BALANCER_BALANCER_H_
#define APP_BALANCER_BALANCER_H_

#ifndef APP_VERSION
#define APP_VERSION "DVLPMNT"
#endif

interface balancer_i {
  void stop(int reason);
  void balance(int reason);

  void move_start(unsigned left, unsigned right);
  void move_stop();

  void get_pid(int K[3]);
  void set_pid(int K[3]);

  int get_pid_lowpass();
  void set_pid_lowpass(int a);

  void get_rpm(int r[2]);

  [[notification]]
  slave void next();

  [[clears_notification]]
  int get_angle(int raw);

  unsigned get_loop_time();

  void set_target(int angle);
  int get_target();

  void set_lowpass(int a);
  int get_lowpass();

  void set_loop_delay(int a);
  int get_loop_delay();

  void set_speed_threshold(int a);
  int get_speed_threshold();

  void set_speed_boost(int a);
  int get_speed_boost();
};
typedef interface balancer_i client balancer_client;

#endif

/* vim: set ft=xc: */
