extends Node2D


func _on_ball_timer_timeout():
	$Ball.new_ball()

func _on_kill_zone_body_entered(body):
	$BallTimer.start()
