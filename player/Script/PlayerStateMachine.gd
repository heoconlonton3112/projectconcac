class_name PlayerStateMachine
extends Node

# Dùng Dictionary (Từ điển) để lưu trữ trạng thái theo dạng: {"Idle": Node, "Walk": Node}
var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

# Khởi tạo tự động, sau này thêm bao nhiêu nút con (Action mới) nó cũng tự nhận hết
func initialize(player_ref: CharacterBody2D) -> void:
	states.clear()
	
	for child in get_children():
		if child is State:
			# Lấy tên của nút (Ví dụ: "Idle", "Walk") làm chìa khóa khóa để gọi
			states[child.name] = child
			
	if get_child_count() > 0:
		State.player = player_ref
		# Chọn nút con đầu tiên làm trạng thái mặc định lúc vào game
		change_state(get_child(0).name) 
		process_mode = Node.PROCESS_MODE_INHERIT

# Thay đổi trạng thái bằng Tên (String)
func change_state(new_state_name: String) -> void:
	if new_state_name == "" or not states.has(new_state_name):
		return
		
	var new_state = states[new_state_name]
	if new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
		
	current_state = new_state
	current_state.enter()

# Nhận tên trạng thái mới từ các file con và thực hiện chuyển đổi
func _process(delta: float) -> void:
	var next_state_name = current_state.process(delta)
	if next_state_name != "":
		change_state(next_state_name)

func _physics_process(delta: float) -> void:
	var next_state_name = current_state.physics_process(delta)
	if next_state_name != "":
		change_state(next_state_name)

func _unhandled_input(event: InputEvent) -> void:
	var next_state_name = current_state.handle_input(event)
	if next_state_name != "":
		change_state(next_state_name)
