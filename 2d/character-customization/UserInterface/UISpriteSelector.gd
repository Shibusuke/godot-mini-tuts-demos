class_name UISpriteSelector
extends Control
# Scene with the necessary controls to select a texture for the customization

# Emitted every time the selected texture changes
signal sprite_changed(texture)
# We store all possible textures in the _sprites array, and the index of the 
# currently selected one in _index
var _sprites := []
# Every time we change the `_index` value, we also want to update the texture.
# In other words, the index and the texture are tied to one another. 
# Using a setter function makes it explicit that the process is tied to the 
# property.
var _index := 0 setget _set_index

onready var texture_rect: TextureRect = $TextureRect


# We define a setup function to fill the _sprites array with the corresponding
# textures, and select the first one by default
func setup(sprite_textures: Array) -> void:
	_sprites = sprite_textures
	_set_index(0)


# Connecting this functions to the pressed signal of the corresponding buttons
# to select next or previous texture.
func _on_PreviousButton_pressed() -> void:
	_set_index(_index - 1)


func _on_NextButton_pressed() -> void:
	_set_index(_index + 1)

# We use this function to update the _index value, and the selected texture
func _set_index(value: int) -> void:
	# We use `wrapi()` function so that when value exceeds the `_sprites.size()`
	# value, it starts from 0 again, and when it falls below 0, it starts from
	# `_sprites.size()-1`. This way, we can cycle through valid indices.
	_index = wrapi(value, 0, _sprites.size())
	var texture: StreamTexture = _sprites[_index]
	# Update the texture, to show the selected one
	texture_rect.texture = texture
	emit_signal("sprite_changed", texture)
