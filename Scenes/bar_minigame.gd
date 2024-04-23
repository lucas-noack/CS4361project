@tool
class_name BarMinigame
extends Control

signal arrow_bounced()
signal minigame_finished(succeeded: bool)

@export_category("Minigame Settings")
# Time in seconds that it takes for the arrow to make it from left to right.
@export_range(0.1, 20.0) var minigame_round_time: float = 1.0
# Variables to indicate where the success margin for the player is. (0.0-1.0)
@export var left_success_margin: float = 0.05:
	set = _set_left_success_margin
@export var right_success_margin: float = 0.95:
	set = _set_right_success_margin
# Allow arrow to bounce back and forth; if false, automatic failure when hitting the right side
@export var bounce_arrow: bool = false
# Start minigame on scene load
@export var auto_start: bool = false

@export_category("Visuals")
@export var arrow_texture: Texture2D:
	set = _set_arrow_texture
@export var fail_color: Color = Color.RED:
	set = _set_fail_color
@export var success_color: Color = Color.GREEN:
	set = _set_success_color

var arrow_position: float = 0.0:
	set = _set_arrow_position
var reverse_direction: bool = false
var minigame_enabled: bool = false

@onready var bar_texture: TextureRect = $BarTexture
@onready var arrow_align: MarginContainer = $ArrowAlign
@onready var arrow_slide: HSlider = $ArrowAlign/ArrowSlide


func _ready() -> void:
	reset_minigame()
	if auto_start:
		await get_tree().create_timer(1).timeout
		start_minigame()


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if minigame_enabled:
			arrow_position += delta * minigame_round_time * (-1 if reverse_direction else 1)
			if bounce_arrow:
				if arrow_position >= 1.0:
					arrow_bounced.emit()
					reverse_direction = true
				if arrow_position <= 0.0:
					arrow_bounced.emit()
					reverse_direction = false
			else:
				if arrow_position >= 1.0:
					end_minigame(false)
			if Input.is_action_just_pressed("Interact"):
				minigame_enabled = false
				if arrow_position > left_success_margin and arrow_position < right_success_margin:
					end_minigame(true)
				else:
					end_minigame(false)
		else:
			if Input.is_action_just_pressed("Interact"):
				start_minigame()


func start_minigame() -> void:
	minigame_enabled = true


func reset_minigame() -> void:
	arrow_position = 0.0
	minigame_enabled = false


# Function to handle case where left margin is > right margin
func check_success_margins() -> void:
	if left_success_margin < right_success_margin:
		bar_texture.texture.gradient.set_color(0, fail_color)
		bar_texture.texture.gradient.set_color(1, success_color)
		bar_texture.texture.gradient.set_color(2, fail_color)
	else:
		bar_texture.texture.gradient.set_color(0, success_color)
		bar_texture.texture.gradient.set_color(1, fail_color)
		bar_texture.texture.gradient.set_color(2, success_color)


func end_minigame(success: bool) -> void:
	reset_minigame()
	minigame_finished.emit(success)


func _set_arrow_position(pos: float) -> void:
	arrow_position = pos
	arrow_slide.value = pos


func _set_left_success_margin(amt: float) -> void:
	if not Engine.is_editor_hint():
		await ready # need to await ready otherwise a tool script freaks out
	if amt < right_success_margin and amt >= 0.0: # make sure margins don't overlap
		left_success_margin = amt
		bar_texture.texture.gradient.set_offset(1, amt)


func _set_right_success_margin(amt: float) -> void:
	if not Engine.is_editor_hint():
		await ready
	if left_success_margin < amt and amt <= 1.0:
		right_success_margin = amt
		bar_texture.texture.gradient.set_offset(2, amt)

# Set arrow texture and margins so that arrow actually aligns with the success/failure areas
func _set_arrow_texture(texture: Texture2D) -> void:
	if not Engine.is_editor_hint():
		await ready
	arrow_texture = texture
	arrow_slide.set("theme_override_icons/grabber", texture)
	arrow_slide.set("theme_override_icons/grabber_highlight", texture)
	arrow_slide.set("theme_override_icons/grabber_disabled", texture)
	arrow_align.set("theme_override_constants/margin_left", -texture.get_size().x / 2.0)
	arrow_align.set("theme_override_constants/margin_right", -texture.get_size().x / 2.0)
	arrow_align.set("theme_override_constants/margin_bottom", -texture.get_size().y / 2.0)


func _set_fail_color(color: Color) -> void:
	if not Engine.is_editor_hint():
		await ready
	fail_color = color
	bar_texture.texture.gradient.set_color(0, color)
	bar_texture.texture.gradient.set_color(2, color)


func _set_success_color(color: Color) -> void:
	if not Engine.is_editor_hint():
		await ready
	success_color = color
	bar_texture.texture.gradient.set_color(1, color)


func _on_resized() -> void:
	if not Engine.is_editor_hint():
		await ready
	bar_texture.texture.width = size.x
	bar_texture.texture.height = size.y
