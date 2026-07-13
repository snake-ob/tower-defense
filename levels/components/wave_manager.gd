extends Node
class_name WaveManager

@export_category("Wave Settings")
var wave_budget: int = 50
var wave_duration: float = 60.0

var current_budget: int = 0
var spawners: Node
var ref: Dictionary
var wave_timer: Timer
var wave_index: int = 0

var spawner_path: String = "res://levels/components/EnemySpawner.tscn"

var tick_rate: float = 1

func _ready() -> void:
	wave_timer = Timer.new()
	wave_timer.timeout.connect(_send_wave)
	add_child(wave_timer)

func _setup(p_ref):
	spawners = p_ref.spawners

func _setup_lvl(p_ref):
	ref = {'spawners': p_ref.spawners, 'enemies': p_ref.enemies, 'spawn_path': p_ref.spawn_path, 'centre': p_ref.centre}
	spawners = p_ref.spawners

func setup_wave(p_wave: WaveData):
	for spawner in spawners.get_children():
		spawner.queue_free()
	wave_budget = p_wave.wave_budget
	wave_duration = p_wave.wave_duration - 20 # Some time for the final enemeis to attack
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
	wave_index = 0
	_send_wave()
	# 4 waves, 3rd wave has 40% of budget, rest has 15%
	# wave_timer will start 
	
func _send_wave():
	var current_budget: int = round(wave_budget * 0.2)
	if wave_index == 3:
		current_budget = round(wave_budget * 0.4)

	_spend_budget(current_budget)
	wave_index += 1
	wave_timer.start(wave_duration/4)

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
	wave_timer.stop()
