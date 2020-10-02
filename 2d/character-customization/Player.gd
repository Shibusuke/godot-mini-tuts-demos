extends KinematicBody2D
# Character script with some basic movement, and the functions needed to update
# the sprites of the customizable parts.
export var speed := 300.0

onready var body := $Body
# We store references to each customizable sprite, for later use
onready var hat := $Body/Hat
onready var glasses := $Body/Glasses
onready var head := $Body/Head


# Basic movement is handled here, just for demostration purposes.
func _physics_process(_delta) -> void:
	var direction := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	move_and_slide(direction * speed)

	if direction.x != 0:
		body.scale.x = sign(direction.x)

# This functions changes the `glasses.texture`. Needs to be connected to the
# `glasses_changed` signal of the `UICharacterCustomizer`
func _on_CharacterCustomizer_glasses_changed(texture) -> void:
	glasses.texture = texture


# Same as previous funciton, but for the `hat`.
func _on_CharacterCustomizer_hat_changed(texture) -> void:
	hat.texture = texture


# Same as previous function, but for the `head`.
func _on_CharacterCustomizer_head_changed(texture) -> void:
	head.texture = texture
