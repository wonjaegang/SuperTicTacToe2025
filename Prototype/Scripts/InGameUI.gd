extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    var board_scene: PackedScene = preload("res://Prototype/Scenes/TicTacToeBoard.tscn")
    for boardIndex in range(9):
        var row = floor(boardIndex / 3)
        var column = boardIndex % 3
        var board = board_scene.instantiate()
        board.board_set_finished.connect(_on_board_set_finished.bind(row, column, board))              
        #$AspectRatioContainer$GridContainer.add_child(board)
       

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
func _on_board_set_finished(row:int, column:int, board:Panel):
    Global.turn = (Global.turn - 1) * -1 + 2  # 2 -> 1, 1 -> 2
