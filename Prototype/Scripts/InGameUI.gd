extends Control

var turnTime = 10
var remainingTime = turnTime
var winner
var state = [[0, 0, 0],
             [0, 0, 0],
             [0, 0, 0]]
var GameOverUI = preload("res://Prototype/GameOverUI.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    # 턴 랜덤 지정, 초기화를 위해 턴 바꾸기 1회 진행
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    Global.turn = rng.randi_range(1, 2)
    changePlayerTurn()
    
    # 보드 생성
    var board_scene: PackedScene = preload("res://Prototype/Scenes/TicTacToeBoard.tscn")
    for boardIndex in range(9):
        var row = floor(boardIndex / 3)
        var column = boardIndex % 3
        var board = board_scene.instantiate()
        board.board_set_finished.connect(_on_board_set_finished.bind(row, column, board))              
        $AspectRatioContainer/GridContainer.add_child(board)
       

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    # 게임이 진행 중일 시 타이머 감소
    if not winner:
        var turnTimer
        if Global.turn == 1:
            turnTimer = $PlayerTimer_1
        elif Global.turn == 2:
            turnTimer = $PlayerTimer_2
        else:
            return
        remainingTime -= delta
        if remainingTime < 0:
            remainingTime = 0
            changePlayerTurn()
            winner = Global.turn
            displayWinner()
            
        turnTimer.get_node("ProgressBar").value = remainingTime
    
func _on_board_set_finished(row:int, column:int, board:Panel):
    """
    보드에서 턴 종료 시
    """
    state[row][column] = board.winner
    winner = Global.check_board_winner(state)
    
    if winner:
        displayWinner()        
          
    changePlayerTurn()
    
func displayWinner():
    var gameOverUI = GameOverUI.instantiate()
    gameOverUI.get_node('WinnerLabel').text = 'Player ' + str(winner) + ' Win!'
    add_child(gameOverUI) 
    
func changePlayerTurn():
    var currentTurnTimer
    var nextTurnTimer
    if Global.turn == 1:
        currentTurnTimer = $PlayerTimer_1
        nextTurnTimer = $PlayerTimer_2
    elif Global.turn == 2:
        currentTurnTimer = $PlayerTimer_2
        nextTurnTimer = $PlayerTimer_1
    else:
        return
        
    currentTurnTimer.get_node('ProgressBar').value = turnTime
    currentTurnTimer.get_node('Mask').visible = true
    nextTurnTimer.get_node('Mask').visible = false
    
    remainingTime = turnTime
    Global.turn = (Global.turn - 1) * -1 + 2  # 2 -> 1, 1 -> 2
    
    
    
    
    
