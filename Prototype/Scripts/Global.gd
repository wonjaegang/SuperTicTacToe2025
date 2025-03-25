extends Node

var marker_1 = load("res://Prototype/Resources/RedMarker.png")
var marker_2 = load("res://Prototype/Resources/BlueMarker.png")

var userTrun = true
var turn = 1

func check_board_winner(board: Array) -> int:
    """
    3 by 3 보드 승자 확인
    """
    # 행 검사
    for row in board:
        if row[0] != 0 and row[0] == row[1] and row[1] == row[2]:
            return row[0]
    
    # 열 검사
    for i in range(3):
        if board[0][i] != 0 and board[0][i] == board[1][i] and board[1][i] == board[2][i]:
            return board[0][i]
    
    # 대각선 검사 (좌측 상단 -> 우측 하단)
    if board[0][0] != 0 and board[0][0] == board[1][1] and board[1][1] == board[2][2]:
        return board[0][0]
    
    # 대각선 검사 (우측 상단 -> 좌측 하단)
    if board[0][2] != 0 and board[0][2] == board[1][1] and board[1][1] == board[2][0]:
        return board[0][2]
    
    # 승리 조건이 없으면 0 리턴
    return 0
