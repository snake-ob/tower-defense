extends CharacterBody2D

@onready var ref: Ref = $Ref
var speed: int = 100

func _ready() -> void:
	pass		

func _physics_process(delta: float) -> void:
	move_to_target()
	move_and_slide()

func move_to_target():
	if not ref.target:
		return
		
	var current_pos = self.global_position
	var target_pos = ref.target.global_position
	
	var direction = target_pos - current_pos
	
	self.velocity = direction * speed
