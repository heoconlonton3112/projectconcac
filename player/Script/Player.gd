extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO

@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	state_machine.initialize(self)

func _process(_delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# SỬA LẠI LOGIC QUAY MẶT:
	if direction.x < 0:
		$Sprite2D.flip_h = true   # Khi đi sang TRÁI -> Bật lật hình để quay sang trái
	elif direction.x > 0:
		$Sprite2D.flip_h = false  # Khi đi sang PHẢI -> Tắt lật hình để quay về bên phải mặc định

func _physics_process(_delta: float) -> void:
	move_and_slide()

# ĐÃ SỬA LỖI: Chỉ chạy hoạt ảnh khi có sự thay đổi, giúp không bị reset frame liên tục
func update_animation(state_name: String) -> void:
	var anim_to_play = state_name
	
	# Nếu trạng thái là đi bộ ("walk"), chúng ta sẽ dựa vào vector direction để chọn đúng tên hoạt ảnh
	if state_name == "walk" and direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			anim_to_play = "Walk_Side"  # Đi ngang (Trái/Phải)
		elif direction.y > 0:
			anim_to_play = "Walk_Down"  # Đi xuống
		elif direction.y < 0:
			anim_to_play = "Walk_up"    # Đi lên (Lưu ý chữ u viết thường theo đúng ảnh chụp màn hình của bạn)

	# Chỉ gọi play khi tên hoạt ảnh thực tế có sự thay đổi
	if animation_player.current_animation != anim_to_play:
		if animation_player.has_animation(anim_to_play):
			animation_player.play(anim_to_play)
		else:
			print("Cảnh báo: Không tìm thấy animation tên là: ", anim_to_play)
	if animation_player.current_animation != state_name:
		animation_player.play(state_name)
