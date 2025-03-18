extends Panel

var state = [[0, 0, 0],
             [0, 0, 0],
             [0, 0, 0]]
signal board_set_finished

# Called when the node enters the scene tree for the first time.
func _ready():
    var grid_scene: PackedScene = preload("res://Prototype/Scenes/TicTacToeGrid.tscn")
    for gridIndex in range(9):
        var row = floor(gridIndex / 3)
        var column = gridIndex % 3
        var grid = grid_scene.instantiate()
        grid.grid_set_finished.connect(_on_grid_set_finished.bind(row, column, grid))              
        $GridContainer.add_child(grid)
        
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
func _on_grid_set_finished(row:int, column:int, grid:Button):
    state[row][column] = grid.state
    var winner = Global.check_board_winner(state)
    print(state, winner)
    if winner == 1:
        $Marker.texture = Global.marker_1
    elif winner == 2:
        $Marker.texture = Global.marker_2
    else:
        pass
    emit_signal("board_set_finished")
    
