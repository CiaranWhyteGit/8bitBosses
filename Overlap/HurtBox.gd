extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	if main != null:
		main.add_child(effect)
		effect.global_position = global_position

func _on_Timer_timeout():
	self.invincible = false

func _on_HurtBox_invincibility_started():
	collisionShape.set_deferred("disabled", true)

func _on_HurtBox_invincibility_ended():
	collisionShape.disabled = false
