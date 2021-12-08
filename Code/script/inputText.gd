extends LineEdit

var ownerFocus = null
var isFocused = false
var canEdit = false

func _process(delta):
	if get_focus_owner() != null && get_focus_owner().get_class() == "LineEdit":
		canEdit = true
		isFocused = true
		self.show()
		if get_focus_owner().name != "Input":
			ownerFocus = get_focus_owner()
			self.grab_focus()
			self.set_text(ownerFocus.get_text())
			self.set_secret(ownerFocus.is_secret())
			self.set_secret_character(ownerFocus.get_secret_character())
			self.caret_position = ownerFocus.get_text().length()
		var height = get_viewport().size.y - OS.get_virtual_keyboard_height()
		height += 4
		set_global_position(Vector2(0, height))
		var position = Vector2(0,0)
		position.x = get_viewport().size.x
		set_size(position)
	elif ownerFocus != null && isFocused == true:
		canEdit = false
		self.hide()
		OS.hide_virtual_keyboard()
		isFocused = false
		self.clear()

func _on_Input_text_changed(new_text):
	if canEdit == true:
		print("text")
		print(ownerFocus.name)
		print(get_focus_owner().name)
		ownerFocus.set_text(self.get_text())
