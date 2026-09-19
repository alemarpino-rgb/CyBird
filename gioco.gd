extends Node2D

const OSTACOLO_SCENE = preload("res://rigid_body_2d.tscn")

@onready var mio_timer: Timer = $Timer 
const SPAWN_X = 1200.0 
var punteggio=0

func _on_timer_timeout() -> void:
	var nuovo_ostacolo = OSTACOLO_SCENE.instantiate()
	punteggio+=1
	$CanvasLayer/Label.text="Score: %d" % punteggio
	if mio_timer.wait_time > 0.1: 
		mio_timer.wait_time -= 0.01
		
	var altezza_casuale = randf_range(193.0, 523.0)
	
	nuovo_ostacolo.position = Vector2(SPAWN_X, altezza_casuale)
	
	nuovo_ostacolo.colpito.connect(_on_rigid_body_2d_colpito)
	
	add_child(nuovo_ostacolo)

func _on_rigid_body_2d_colpito() -> void:
	print("Ciso")
	shakera_schermo(0.1, 15.0) # Dura 0.4 secondi con una forza di 15 pixel
	await get_tree().create_timer(0.5).timeout
	$CanvasLayer/Perso.visible = true 
	$CanvasLayer/Button2.visible=true


func _on_button_2_pressed() -> void:
	get_tree().reload_current_scene()# shake, altrimenti il tempo si ferma!
	# Engine.time_scale = 0.0 

func shakera_schermo(durata: float, forza: float) -> void:
	# Crea un oggetto Tween per gestire l'animazione dello spostamento della camera
	var tween = create_tween()
	
	# Numero di scossoni che farà la telecamera durante la durata dell'effetto
	var passi = 10 
	var tempo_per_passo = durata / passi
	
	for i in range(passi):
		# Sceglie una direzione casuale (X e Y) basata sulla forza impostata
		var offset_casuale = Vector2(
			randf_range(-forza, forza),
			randf_range(-forza, forza)
		)
		# Sposta l'offset della telecamera verso il punto casuale
		tween.tween_property($Camera2D, "offset", offset_casuale, tempo_per_passo)
	
	# Alla fine dell'animazione, riporta la telecamera perfettamente al centro (0, 0)
	tween.tween_property($Camera2D, "offset", Vector2.ZERO, tempo_per_passo)
