extends RigidBody2D

const weapon_types = [
	{	sprite = preload("res://art/weapons/bullet.png"),
		collision_box = Vector2(1.98084, 5.54624),
		visibility_box_scale = Vector2(0.410078, 0.37075),
		speed = 200, spin = false, on_contact = "blood-spill"},
	{	sprite = preload("res://art/weapons/dagger.png"),
		collision_box = Vector2(2.98819, 15),
		visibility_box_scale = Vector2(1, 1),
		speed = 150, spin = false, on_contact = "blood-spill"},
	{	sprite = preload("res://art/weapons/granade.png"),
		collision_box = Vector2(6.9659, 11.0234),
		visibility_box_scale = Vector2(1.37081, 0.735134),
		speed = 100, spin = true, on_contact = "explosion"},
	{	sprite = preload("res://art/weapons/missile.png"),
		collision_box = Vector2(4.31724, 18.7046),
		visibility_box_scale = Vector2(1.71514, 1.24721),
		speed = 120, spin = false, on_contact = "explosion"}
]

export var speed = 150
var on_contact = null


# Called when the node enters the scene tree for the first time.
func init():
	# select a random weapon type
	var weapon_type = weapon_types[randi() % 4]
	
	# apply the chosen weapon type
	$Sprite.set_texture(weapon_type.sprite)
	$CollisionShape2D.get_shape().set_extents(weapon_type.collision_box)
	$VisibilityNotifier2D.set_scale(weapon_type.visibility_box_scale)
	speed = weapon_type.speed
	angular_velocity = 10 if weapon_type.spin else 0
	on_contact = weapon_type.on_contact


func _on_VisibilityNotifier2D_screen_exited():
	# Delete object if it leaves the screeen
	queue_free()


func on_contact():
	if $OnContactAnimation.visible:
		return
	
	$OnContactAnimation.animation = on_contact
	$OnContactAnimation.frame = 0
	
	$Sprite.hide()
	$OnContactAnimation.show()
	
	$OnContactAnimation.rotation -= PI
	linear_velocity = Vector2(0, 0)
	
	$OnContactAnimation.play()
		
	yield($OnContactAnimation, "animation_finished")
	
	queue_free()
