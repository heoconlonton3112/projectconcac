class_name State
extends Node

# Biến static dùng chung để điều khiển Player
static var player: CharacterBody2D

# Hàm này trả về TÊN của trạng thái tiếp theo dưới dạng String (Ví dụ: "Walk", "Idle", "Attack")
# Việc dùng String giúp các State không cần phải kéo thả hay liên kết trực tiếp với nhau.
func process(_delta: float) -> String:
	return ""

func physics_process(_delta: float) -> String:
	return ""

func handle_input(_event: InputEvent) -> String:
	return ""

func enter() -> void:
	pass

func exit() -> void:
	pass
