extends KinematicBody2D

export (int) var acceleration = 0
export (int) var speedMax = 0
export (int) var jump = 0   
export (int) var maxJump = 0
export (int) var addJump = 0
export (int) var gravity = 0

var x = 0
var y = 0

var pressed = false
var released = false
var velocity = Vector2()
var isJumping = false
var isSpacePress = false
var hasRelease = true
var speedLock = false

#Powerup timers
var directionTimer = 0
var directionTimerToggle = false
var jumpTimer = 0
var jumpTimerToggle = false
var speedTimer = 0
var speedTimerToggle = false

signal dead
signal powerup_over
signal jump

func _ready():
	jump = jump * -1
	maxJump = maxJump * -1
	addJump = addJump * -1
	get_tree().set_pause(false)
	pass

func get_Input():
	if pressed and hasRelease:
		isSpacePress = true
		pressed = false
	if released:
		isSpacePress = false
		hasRelease = true
		released = false
	if isSpacePress and is_on_floor() and hasRelease:
		hasRelease = false
		isJumping = true
		velocity.y += jump
		emit_signal("jump")
	if isSpacePress and velocity.y>maxJump:
		velocity.y += addJump
	pass

func _physics_process(delta):
	get_Input()
	velocity.y += gravity * delta
	if (velocity.x<speedMax and speedLock==false):
		velocity.x += acceleration * delta
	else:
		speedLock = true
		velocity.x = speedMax
	if is_on_floor():
		get_node("AnimatedSprite").play("landingAnim")
	else:
		get_node("AnimatedSprite").play("jumpAnim")
	if isJumping and is_on_floor():
		isJumping = false
	
	velocity = move_and_slide(velocity, Vector2(0,-1))
	x += velocity.x
	y += velocity.y
	
	if (y>45000): # pour perte was 20000
		emit_signal("dead")
		get_tree().set_pause(true)
		
		velocity.x = 0
		velocity.y = 0
		jump = 0
		acceleration = 0
		gravity = 0
		addJump = 0
	
	if directionTimer == 180:
		directionTimerToggle = false
		speedMax *= -1
		get_node("AnimatedSprite").set_flip_h(false)
		directionTimer = 0
		emit_signal("powerup_over", 1)
	
	if jumpTimer == 300:
		jumpTimerToggle = false
		maxJump /= 1.5
		addJump /= 1.5
		jumpTimer = 0
		emit_signal("powerup_over", 2)
		
	if speedTimer == 300:
		speedTimerToggle =false
		speedMax /= 1.2
		speedTimer = 0
		emit_signal("powerup_over", 3)
		
	if directionTimerToggle == true:
		directionTimer += 1
	
	if jumpTimerToggle == true:
		jumpTimer += 1
		
	if speedTimerToggle == true:
		speedTimer += 1

func _on_TouchScreenButton_pressed():
	pressed = true

func _on_TouchScreenButton_released():
	released = true

func _on_powerup(powerup_id):
	if (powerup_id==0): #test physique saut *2
		velocity.y = -1000
	elif (powerup_id == 1):
		speedMax *= -1
		get_node("AnimatedSprite").set_flip_h(true)
		directionTimer = 0
		directionTimerToggle = true
	elif (powerup_id == 2):
		maxJump *= 1.5
		addJump *= 1.5
		jumpTimer = 0
		jumpTimerToggle = true
	elif (powerup_id == 3):
		speedMax *= 1.2
		speedTimer = 0
		speedTimerToggle = true
		