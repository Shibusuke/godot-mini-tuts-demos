extends KinematicBody2D

export var speed := 300.0


func _physics_process(delta) -> void:
	var direction := calculate_move_direction()
	move_and_slide(direction * speed)
	
func _input(event):
	if event.is_action_pressed("ui_down"):
		$Viewport/LightSprite.scale *= 0.75


func calculate_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
