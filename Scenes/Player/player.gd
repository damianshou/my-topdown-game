extends CharacterBody2D
class_name Player

@export var data: PlayerData
@onready var shadow: Sprite2D = $Visuals/Shadow

@onready var visuals: Node2D = $Visuals
@onready var anim_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent

var can_move := true
var movement: Vector2
var direction: Vector2

func _ready() -> void:
	# 初始化血量
	health_component.init_health(data.max_hp)

func _physics_process(delta: float) -> void:
	if not can_move:
		return
	direction = Input.get_vector("move_left","move_right","move_up","move_down");
	# 如果玩家按了方向建	
	if direction != Vector2.ZERO:
		movement = direction * data.move_speed;
		anim_sprite.play("move")
	else:
		movement = Vector2.ZERO
		anim_sprite.play("idle")

	# 移动玩家
	velocity = movement
	move_and_slide()
	rotate_player()
	
## 根据输入方向判断翻转
func rotate_player() -> void:
	if direction !=Vector2.ZERO:
		if direction.x >= 0.1:
			visuals.scale = Vector2(1.25,1.25)
		else:
			visuals.scale = Vector2(-1.25,1.25)

# 监听血量变化
func _on_health_component_on_unit_damaged(amount: float) -> void:
	EventBus.on_player_health_updated.emit(health_component.current_health,health_component.max_health)

# 监听死亡
func _on_health_component_on_unit_dead() -> void:
	queue_free()
# 监听治疗
func _on_health_component_on_unit_healed(amount: float) -> void:
	pass # Replace with function body.

## 测试血量
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		health_component.take_damage(1)
	
	
	
	
	
	
