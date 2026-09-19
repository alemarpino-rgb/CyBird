extends AnimatedSprite2D

var velocity_x = -10
const OSTACOLO_SCENE = preload("res://animated_sprite_2d.tscn")

# Usiamo una variabile di controllo per evitare che generi 60 sfondi al secondo 
# nello stesso identico istante in cui supera la coordinata
var gia_generato = false

func _process(delta: float) -> void:
	position.x += velocity_x * delta 
	
	# Controlla se la X è scesa sotto il valore limite (es. 367)
	if position.x <= 367.0 and not gia_generato:
		gia_generato = true # Blocca ulteriori generazioni da parte di QUESTO specifico sfondo
		
		var nuovo_ostacolo = OSTACOLO_SCENE.instantiate()
		nuovo_ostacolo.position = Vector2(1959, 364)
		
		# IMPORTANTE: Aggiunge il nuovo sfondo al genitore (la scena principale)
		# in modo che rimanga indipendente da questo pezzo di sfondo
		get_parent().add_child(nuovo_ostacolo)
