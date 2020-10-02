extends Control
# This script builds the character cutsomizer GUI, with a `UISpriteSelector`
# for each customizable part.

# Emited every time the user changed the hat texture
signal hat_changed(texture)
# Same as above, but for the head texture
signal head_changed(texture)
# Same as above, but for the glasses texture
signal glasses_changed(texture)

# `DATA` dictionary the possible textures of each part of the character.
# Each key of the dictionary represents a customizable part.
const DATA := {
	"hat" :
	[
		preload("Sprites/hat1.png"),
		preload("Sprites/hat2.png"),
		preload("Sprites/hat3.png")
		],
	"glasses" : [
		preload("Sprites/sun-glasses1.png"),
		preload("Sprites/sun-glasses2.png"),
		preload("Sprites/sun-glasses3.png")
		],
	"head": [
		preload("Sprites/head1.png"),
		preload("Sprites/head2.png"),
		preload("Sprites/head3.png") ]
	}

const sprite_selector_scene: PackedScene = preload("UISpriteSelector.tscn")

onready var vbox_container: VBoxContainer = $Panel/VBoxContainer


func _ready() -> void:
	# We need an instance of `UISpriteSelector` for each customizable part
	for key in DATA:
		var textures: Array = DATA[key]
		var sprite_selector: UISpriteSelector = sprite_selector_scene.instance()
		vbox_container.add_child(sprite_selector)
		# After adding the `sprite_selector`, we add the corresponding textures
		# using `setup()` function
		sprite_selector.setup(textures)
		# We need to emit the corresponding signal when the user selects
		# a new texture in the `sprite_selector`. To do so, we connect the 
		# `sprite_changed` signal of the `sprite_selector` to the
		# `_on_SpriteSelector_sprite_changed`, and pass `key` as an extra 
		# parameter, to know which texture changed.
		sprite_selector.connect("sprite_changed", self, "_on_SpriteSelector_sprite_changed", [key])


func _on_SpriteSelector_sprite_changed(texture: StreamTexture, key: String) -> void:
	# When a texture changes, we emit the corresponding signal, to notify the 
	# character in the main scene.
	emit_signal(key + "_changed", texture)
