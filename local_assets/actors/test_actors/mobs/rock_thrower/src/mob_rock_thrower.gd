extends Mob

@onready var state_machine: MobStateMachine = $MobStateMachine
@onready var animations: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
