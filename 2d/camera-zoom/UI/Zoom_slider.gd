class_name ZoomSlider
extends Control

onready var zoom_camera: ZoomingCamera2D = get_node(
	"/root/ZoomingCameraDemo/Player/ZoomingCamera2D"
)
onready var zoom_vslider: VSlider = $VSlider


func _ready() -> void:
	zoom_camera.connect("zoom_level_changed", self, "_on_zoom_level_changed")
	_on_zoom_level_changed(zoom_camera.zoom_level)


func _on_zoom_level_changed(new_value: float) -> void:
	zoom_vslider.value = range_lerp(new_value, zoom_camera.min_zoom, zoom_camera.max_zoom, 100, 1)


func _on_VSlider_value_changed(new_value: float) -> void:
	zoom_camera.set_zoom_level(
		range_lerp(new_value, 100, 1, zoom_camera.min_zoom, zoom_camera.max_zoom)
	)
