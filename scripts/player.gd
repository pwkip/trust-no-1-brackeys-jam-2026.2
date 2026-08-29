extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var isAttacking = false
var isJumping = false
var isDying = false
var isHit = false

var cameraLimitTween

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if (isDying):
		velocity.x = 0
		move_and_slide()
		return
	if (isHit):
		move_and_slide()
		return
		
		
	if ((Input.is_action_just_pressed("attack")&&is_on_floor()) || isAttacking):
		isAttacking = true
		$AttackArea.position.x = -5 if $AnimatedSprite2D.flip_h else 5
		$AnimatedSprite2D.play("attack")
		$AttackArea.set_deferred("monitoring", true)
		print(get_global_transform_with_canvas())
		
		return

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if (direction == 1):
		$AnimatedSprite2D.flip_h = 0
	if (direction == -1):
		$AnimatedSprite2D.flip_h = 1

	if (is_on_floor() && velocity.y == 0):
		if (direction == 0):
			$AnimatedSprite2D.play('idle')
		else:
			$AnimatedSprite2D.play('run')
	else: if (is_on_floor() && Input.is_action_just_pressed("jump")):
		$jumpSound.play()
		$AnimatedSprite2D.play("jump") # trigger animation only during liftoff
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func die():
	if isDying:
		return
	isDying = true
	$deadSound.play()
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(1).timeout
	GameManager.reset()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ($AnimatedSprite2D.animation == "attack"):
		isAttacking = false
		$AttackArea.set_deferred("monitoring", false)


func _on_attack_area_area_entered(area: Area2D) -> void:
	var target = area if area.has_method("take_hit") else area.get_parent()
	if (target.has_method("take_hit")):
		target.take_hit()


func _on_underground_body_entered(body: Node2D) -> void:
	#$Camera2D.limit_bottom = 304
	set_camera_limit(304, 0.6)
		
func _on_underground_treshhold_body_exited(body: Node2D) -> void:
	set_camera_limit(80, 1.6)
	
func set_camera_limit(value: int, duration: float) -> void:
	if cameraLimitTween:
		cameraLimitTween.kill()
	cameraLimitTween = create_tween()
	cameraLimitTween.tween_property($Camera2D, "limit_bottom", value, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func take_hit():
	isHit = true
	$AnimatedSprite2D.play("hit")
	await $AnimatedSprite2D.animation_finished
	$hitSound.play()
	GameManager.subtract_heart()
	isHit = false
