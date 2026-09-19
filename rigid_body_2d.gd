extends StaticBody2D
signal colpito
var velocity_x=-100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += velocity_x * delta 
	if position.x<=-100:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		print("Il giocatore ha perso!")
		colpito.emit()
