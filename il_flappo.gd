extends RigidBody2D

var JUMP_FORCE = -450.0 
var morto=false

func _ready() -> void:
	lock_rotation = true 

func _physics_process(_delta: float) -> void:
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("click")) and morto==false: 
		linear_velocity.y = 0
		
		apply_central_impulse(Vector2(0, JUMP_FORCE))

func _on_rigid_body_2d_colpito() -> void:
	morto=true
