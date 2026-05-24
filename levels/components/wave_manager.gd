extends Node
class_name WaveManager


@export_category("Wave Settings")
@export var wave_budget: int = 50
@export var wave_duration: float = 60.0

var current_budget: int = 0
var trickle_timer: Timer
var burst_timer: Timer
var spawners: Array

var trickle_time: float = 2.5
var burst_frequency: int = 3

func _ready() -> void:
	current_budget = wave_budget
	_setup_timers()
	start_wave()

func _setup(p_ref):
	spawners = p_ref.spawners.get_children()

func _setup_timers() -> void:
	trickle_timer = Timer.new()
	trickle_timer.wait_time = trickle_time
	trickle_timer.timeout.connect(_on_trickle_timeout)
	add_child(trickle_timer)
	
	burst_timer = Timer.new()
	burst_timer.wait_time = wave_duration / burst_frequency
	burst_timer.timeout.connect(_on_burst_timeout)
	add_child(burst_timer)

func start_wave() -> void:
	trickle_timer.start()
	burst_timer.start()

func _on_trickle_timeout() -> void:
	if current_budget <= 0:
		end_wave()
		return
		
	var max_spend = clampi(current_budget, 1, 3) 
	_spend_budget(max_spend)

func _on_burst_timeout() -> void:
	if current_budget <= 0: return
	
	var burst_spend = int(wave_budget * 0.25)
	burst_spend = clampi(burst_spend, 0, current_budget)
	
	_spend_budget(burst_spend)

func _spend_budget(amount_to_spend: int) -> void:
	var spent = 0
	
	while spent < amount_to_spend and current_budget > 0:
		var affordable_enemies = _get_affordable_enemies(amount_to_spend - spent)

		if affordable_enemies.is_empty():
			break

		var chosen_spawner = affordable_enemies.pick_random()
		chosen_spawner.spawn_enemy()
		
		spent += chosen_spawner.point_cost
		current_budget -= chosen_spawner.point_cost

func _get_affordable_enemies(max_cost: int) -> Array[EnemySpawner]:
	var affordable_spawners: Array[EnemySpawner] = []
	for spawner in spawners:
		if spawner.point_cost <= max_cost and spawner.point_cost <= current_budget:
			affordable_spawners.append(spawner)
	return affordable_spawners

func end_wave() -> void:
	trickle_timer.stop()
	burst_timer.stop()
