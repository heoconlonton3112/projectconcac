class_name State_Walk
extends State

@export var move_speed: float = 120.0

func enter() -> void:
	player.update_animation("walk")

func process(_delta: float) -> String:
	# Nếu thả tay không bấm nút nữa -> Trả về chữ "Idle" để đứng yên
	if player.direction == Vector2.ZERO:
		return "Idle"
		
	player.velocity = player.direction * move_speed
	player.update_animation("walk")
	return ""
