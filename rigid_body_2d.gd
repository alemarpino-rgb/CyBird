extends StaticBody2D
signal colpito
var velocity_x=-100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += velocity_x * delta 
	var camera = get_viewport().get_camera_2d()
	var bordo_sinistro = camera.get_screen_center_position().x - get_viewport_rect().size.x / 2
	if position.x < bordo_sinistro - 200:
		queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		print("Il giocatore ha perso!")
		colpito.emit()
