extends KinematicBody2D

export var speed = 400
var v = Vector2(1, 0)
var velocity = Vector2.ZERO
export var damage = 100

func init(x: int, y: int) -> void:
	v.x = x
	v.y = y

func _physics_process(delta: float) -> void:
	velocity.x = v.x * speed
	velocity.y = v.y * speed
	var col = move_and_collide(velocity * delta)

	if col:
		var t = Timer.new()
		t.set_wait_time(0.1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		queue_free()
