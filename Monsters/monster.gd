extends KinematicBody2D

export var speed = 192
export var v = Vector2(1, 0)
export var damage = 60
var velocity = Vector2.ZERO
var FLOOR_NORMAL = Vector2.UP
onready var sp = $Sprite
onready var sfx = $SFX
export var hp = 100
signal health(amount)


func _ready() -> void:
	velocity.x = v.x * speed
	velocity.y = v.y * speed

func _physics_process(delta: float) -> void:
	#var col = move_and_collide(velocity * delta)
	#if col:
	#	velocity = velocity.bounce(col.normal)
	if is_on_floor() or is_on_ceiling():
		velocity.y *= -1
	if is_on_wall():
		sp.flip_h = not sp.flip_h
		velocity.x *= -1

	move_and_slide(velocity, FLOOR_NORMAL)


func _on_BulletDetector_body_entered(body_id: int, body: Node, _discard, _discard2) -> void:
	if body.filename.ends_with("Bullet.tscn"):
		if "Enemy" in body.filename:
			return
		hit(body)
		
func hit(body):
	sfx.play()
	body.queue_free()
	hp -= body.get('damage')
	if hp <= 0:
		die()
	emit_signal('health', hp)

func die():
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
