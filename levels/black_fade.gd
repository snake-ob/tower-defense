extends ColorRect

var fading = false
var progress: float
var progress_rate: float = 0.01

func _ready():
	SignalBus.gameover.connect(_on_gameover)
	SignalBus.end_stage.connect(_on_end_stage)
	color.a = 0
	
func _process(delta):
	if not fading:
		return
	
	progress += progress_rate
		
	if progress < 0.33:
		color.a = 0.3
	elif progress < 0.66:
		color.a = 0.6
	elif progress < 0.90:
		color.a = 1

	else:
		color.a = 1
	
func _on_gameover():
	fading = true
	
func _on_end_stage():
	await get_tree().create_timer(2).timeout
	fading = true
