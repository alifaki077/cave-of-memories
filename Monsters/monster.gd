extends KinematicBody2D

export var speed = 192
export var v = Vector2(1, 0)
var velocity = Vector2.ZERO
var FLOOR_NORMAL = Vector2.UP
onready var sp = $Sprite

func _ready() -> void:
	velocity.x = v.x * speed
	velocity.y = v.y * speed

func _physics_process(delta: float) -> void:
	
	if is_on_floor() or is_on_ceiling():
		velocity.y *= -1
	if is_on_wall():
		sp.flip_h = not sp.flip_h
		velocity.x *= -1

	move_and_slide(velocity, FLOOR_NORMAL)


func _on_BulletDetector_body_entered(body: Node) -> void:
	if body.filename.ends_with('Bullet.tscn'):
		body.queue_free()
		die()

func die():
	queue_free()