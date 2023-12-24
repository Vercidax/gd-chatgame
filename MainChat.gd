@tool
extends Control

const message_scene = preload("res://MessageScene.tscn")

@export var current_account: Account


@export var chat_size: float = 1.0 :
	set(value):
		if value > 0:
			print("check size: ", value)
			$MarginContainer.scale = Vector2(value, value)
			chat_size = value


@export var message_limit: int = 100


func send_message(account, message):
	print_debug("send_message called!: ", account, message)
	if account && !message.is_empty():
		
		#When message count goes over message limit remove child 0
		if $MarginContainer/ScrollContainer/ChatBox.get_child_count()+ 1 > message_limit:
			$MarginContainer/ScrollContainer/ChatBox.get_child(0).queue_free()
		
		
		#Clear text
		$MarginContainer/SendMessage.text = ""
		
		var message_copy = message_scene.instantiate()#Creates message scene copy.
		
		message_copy.set_data(account, message)#Sets message data, like account image, username.
		
		
		$MarginContainer/ScrollContainer/ChatBox.add_child(message_copy)


func _on_line_edit_text_submitted(new_text):
	send_message(current_account, new_text)
	current_account.toggle_character()

func _on_chat_size_text_submitted(new_text):
	chat_size = float(new_text)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://mainmenu.tscn") #goes to main menu

func _on_save_chat_pressed():
	save_game() #saves into custom data

func _on_loadchat_pressed():
	load_game() #loads from custom data
	
func save():
	var save_dict = { #the current setup for dictionary save probably need to change this
		"Image" : "some image thingy",
		"username" : "my name goes ehre",
		"description" : "Present Self"
	}
	return save_dict
	
func save_game(): #saving data into json string
	var save_game = FileAccess.open("user://savechat.save", FileAccess.WRITE)	
	
	var json_string = JSON.stringify(save())
	
	save_game.store_line(json_string)
	
func load_game(): #loading data from json string in save data
	if not FileAccess.file_exists("user://savechat.save"):
		return
	var save_game = FileAccess.open("user://savechat.save", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		print(node_data)
