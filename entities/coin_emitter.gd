extends StaticBody2D
class_name CoinEmitter

var coin_path: String = "res://entities/Coin.tscn"
var death_time: float = 3.0

func stagger_drop(count: int) -> void:
	var max_delay = death_time/count
	for i in range(count):
		var delay = randf_range(0.0, max_delay)
		await get_tree().create_timer(delay).timeout
		
		emit_drop()
	queue_free()

func emit_drop():
	var coin_scene = load(coin_path)
	var new_coin = coin_scene.instantiate()
	new_coin.global_position = global_position
	SignalBus.spawned.emit(new_coin)
