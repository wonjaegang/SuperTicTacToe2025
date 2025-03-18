extends Button

var state = 0
signal grid_set_finished

func _on_pressed():
    """
    Grid 클릭 시, 현재 turn 으로 상태/아이콘 변경, 턴 종료 시그널 호출
    이미 변경되었을 시 조기리턴.
    """
    if not Global.userTrun:
        return        
    if state:
        return
        
    state = Global.turn
    var marker
    if Global.turn == 1:
        marker = Global.marker_1   
    else:
        marker = Global.marker_2
    $Marker.texture = marker
    emit_signal("grid_set_finished")
    
        
