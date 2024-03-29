extends RigidBody2D

export var MIN_SPEED = 150 # Minimum speed range
export var MAX_SPEED = 250 # Maximum speed range
export var MAX_SCALE = .75 # Maximum scale
export var MIN_SCALE = .55 # Minimum scale
var mob_types = ["Flyer", "Swimmer", "Walker"]

# When a prefab/node is created and enters the scene tree
func _ready():
	$AnimatedSprite.scale.x = rand_range(MIN_SCALE, MAX_SCALE)
	$AnimatedSprite.scale.y = $AnimatedSprite.scale.x
	$CollisionShape2D.scale.x = $AnimatedSprite.scale.x
	$CollisionShape2D.scale.y = $AnimatedSprite.scale.x
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	$AnimatedSprite.play()
	$Tween.interpolate_property(self, "scale", self.scale, Vector2(0,0), 0.5,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

# Will be called when a Mob exits the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func destroy():
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()
