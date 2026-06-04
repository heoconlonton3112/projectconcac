extends CharacterBody2D

@export var speed = 150.0
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D

# Biến để máy tính nhớ hướng nhìn cuối cùng
var last_direction = "Down"

func _physics_process(_delta):
	# 1. Lấy hướng di chuyển
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# 2. Áp dụng di chuyển
	velocity = direction.normalized() * speed
	move_and_slide()

	# 3. Xử lý Animation dựa trên file bạn đã làm
	if direction != Vector2.ZERO:
		# Khi đang đi
		if direction.y > 0:
			anim.play("Walk_Down")
			last_direction = "Down"
		elif direction.y < 0:
			anim.play("Walk_up") # Lưu ý: chữ 'u' thường theo file tscn của bạn
			last_direction = "Up"
		elif direction.x != 0:
			anim.play("Walk_Side")
			last_direction = "Side"
			sprite.flip_h = (direction.x < 0) # Lật hình nếu đi sang trái
	else:
		# Khi đứng yên (Idle)
		anim.play(last_direction)
