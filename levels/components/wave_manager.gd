extends Node
class_name WaveManager

@export_category("Wave Settings")
var wave_budget: int = 50
var wave_duration: float = 60.0

var current_budget: int = 0
var spawners: Node
var ref: Dictionary
var heartbeat_timer: Timer

var spawner_path: String = "res://levels/components/EnemySpawner.tscn"

# How often to check for spawns (0.5s creates a smooth flow)
var tick_rate: float = 0.5 

func _ready() -> void:
	heartbeat_timer = Timer.new()
	heartbeat_timer.wait_time = tick_rate
	heartbeat_timer.timeout.connect(_on_heartbeat)
	add_child(heartbeat_timer)

func _setup(p_ref):
	spawners = p_ref.spawners

func _setup_lvl(p_ref):
	ref = {'spawners': p_ref.spawners, 'enemies': p_ref.enemies, 'spawn_path': p_ref.spawn_path, 'centre': p_ref.centre}
	spawners = p_ref.spawners

func setup_wave(p_wave: WaveData):
	for spawner in spawners.get_children():
		spawner.queue_free()
	wave_budget = p_wave.wave_budget
	wave_duration = p_wave.wave_duration
	current_budget = wave_budget
	for spawner in p_wave.wave_enemies:
		var spawner_scene = load(spawner_path)
		var new_spawner = spawner_scene.instantiate()
		spawners.add_child(new_spawner)
		ref['enemy_scene'] = spawner.enemy_scene
		ref['point_cost'] = spawner.point_cost
		ref['spawning'] = spawner.spawning
		new_spawner.setup_spawner(ref)

func start_wave() -> void:
	heartbeat_timer.start()

func _on_heartbeat() -> void:
	# Calculate how much we should spend this tick to finish the budget by the end
	# (Remaining Budget / Remaining Time) * Tick Rate
	var remaining_time = heartbeat_timer.time_left # This logic is handled by LevelManager's timer
	# If we are at the end, spend everything left
	if heartbeat_timer.time_left < tick_rate:
		_spend_budget(current_budget)
		end_wave()
		return

	# Determine how much of the budget to spend this specific tick
	var budget_per_second = float(wave_budget) / wave_duration
	var amount_to_spend = int(budget_per_second * tick_rate)
	
	if amount_to_spend > 0:
		_spend_budget(amount_to_spend)

func _spend_budget(amount: int) -> void:
	var spent = 0
	
	# Try to spend the allocated amount
	while spent < amount and current_budget > 0:
		var affordable = _get_affordable_spawners(amount - spent)
		
		if affordable.is_empty():
			break
			
		var chosen = affordable.pick_random()
		chosen.spawn_enemy()
		
		spent += chosen.point_cost
		current_budget -= chosen.point_cost

func _get_affordable_spawners(max_cost: int) -> Array:
	var list = []
	for spawner in spawners.get_children():
		# Must be able to afford it AND it must be within the current tick's budget
		if spawner.point_cost <= max_cost and spawner.point_cost <= current_budget:
			list.append(spawner)
	return list

func end_wave() -> void:
	heartbeat_timer.stop()
