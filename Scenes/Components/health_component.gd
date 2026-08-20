extends Node2D
class_name HealthComponent
## 单位受击信号 amount 表示受到伤害的数值
signal on_unit_damaged(amount: float)
## 单位回血信号 amount 表示回血的数值
signal on_unit_healed(amount: float)
## 单位死亡信号
signal on_unit_dead

# 当前生命
var current_health: float
# 最大生命
var max_health: float

func init_health(value: float) ->void:
	current_health = value;
	max_health = value;

# 受到伤害
func take_damage(value: float) -> void:
	if current_health > 0:
		current_health -= value
		on_unit_damaged.emit(value)
		
		if current_health <= 0:
			die()
			
func die() -> void:
	on_unit_dead.emit()

func heal(value: float) -> void:
	if current_health >= max_health:
		return
	current_health = min(max_health,current_health + value)
	on_unit_healed.emit(value)
	
