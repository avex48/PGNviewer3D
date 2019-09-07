extends Control

func _ready():
    self.hide()


#func _input(ev):
#    if ev is InputEventKey:
#        if ev.pressed and ev.scancode == KEY_F12: 
#                self.show()
#
                


func _on_Control_visibility_changed():
    if not self.is_visible_in_tree():
        self.show()
    pass # Replace with function body.
