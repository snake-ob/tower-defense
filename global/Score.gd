extends Node

signal score_updated

var scores: Dictionary ={
	
	'king_taken': {'title': 'Poor King', 'value': -100, 'count': 0},
	'player_death': {'title': 'You Died', 'value': -200, 'count': 0},
	'coin_collected': {'title': 'Fat Wallet', 'value': 1, 'count': 0},
	'enemy_killed': {'title': 'Slayer', 'value': 2, 'count': 0},
	'boss_killed': {'title': 'Boss Cobbler', 'value': 300, 'count': 0},
	'wall_built': {'title': 'Big Builder', 'value': 10, 'count': 0},
	'item_used': {'title': 'Item User', 'value': 5, 'count': 0},
	'turret_purchased': {'title': 'Tower Power', 'value': 50, 'count': 0},
	'item_purchased': {'title': 'Big Shopper', 'value': 10, 'count': 0}
}
	

func update(event: String):
	if not event in scores:
		print("EVENT '", event, "' NOT FOUND IN SCORE SYSTEM")
		return
	scores[event].count += 1
	score_updated.emit()

func reset_scores():
	for event_key in scores:
		scores[event_key].count = 0

func debug_scores():
	for event_key in scores:
		scores[event_key].count = randi_range(0, 10)

func get_total():
	var total = 0
	for event_key in scores:
		var event = scores[event_key]
		var value = event.value * event.count
		total += value
	return total
	
func get_letter_grade() -> String:
	var total = get_total()
	var grade: String
	
	if total <= -500:
		grade = "D"
	elif total <= -400:
		grade = "C-"
	elif total <= -200:
		grade = "C"
	elif total <= -100:
		grade = "C+"
	elif total <= 0:
		grade = "B-"
	elif total <= 150:
		grade = "B"
	elif total <= 300:
		grade = "B+"
	elif total <= 500:
		grade = "A-"
	elif total <= 750:
		grade = "A"
	elif total <= 1250:
		grade = "A+"
	else:
		grade = "S"
	
	return grade
