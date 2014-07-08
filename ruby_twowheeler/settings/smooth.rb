$balancer.stop!

$balancer.loop_delay = 0.01
$balancer.angle_lowpass_delay = 0.0048
$balancer.pid = [2300.0, 5000.0, 0.0]
$balancer.target = -0.9
$balancer.motors_boost = 500
$balancer.motors_threshold = 100

$balancer.balance!

