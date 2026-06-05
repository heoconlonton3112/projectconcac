class_name State_Idle
extends State

func enter() -> void:
	# Gọi tên hoạt ảnh trùng với tên trạng thái cho dễ quản lý
	player.update_animation("Side")

func process(_delta: float) -> String: # Đuôi này phải giống hệt file cha
	if player.direction != Vector2.ZERO:
		return "Walk"
		
	player.velocity = Vector2.ZERO
	return "" # Trả về String rỗng nếu không đổi trạng thái
