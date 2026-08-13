extends VBoxContainer
class_name ScoreBox

var scores: Dictionary
var score_line_path: String = "res://UI/ScoreLine.tscn"

func _ready():
	Score.debug_scores()
	scores = Score.scores
	await get_tree().process_frame
	add_scores()

func add_scores():
	var score_line_scene = load(score_line_path)

	for event_key in scores:
		if scores[event_key].count == 0:
			return
		var score_line: ScoreLine = score_line_scene.instantiate()
		score_line.event = scores[event_key].title
		score_line.score = scores[event_key].value * scores[event_key].count
		add_child(score_line)
