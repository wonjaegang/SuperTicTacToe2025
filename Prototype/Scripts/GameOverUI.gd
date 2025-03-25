extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    $PlayAgainButton.pressed.connect(get_tree().change_scene_to_file.bind("res://Prototype/InGameUI.tscn"))
    $BackToHomeButton.pressed.connect(get_tree().change_scene_to_file.bind("res://Prototype/HomeUI.tscn"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
