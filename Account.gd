extends Resource
class_name Account

func toggle_character():
	if ActiveCharacter == 0:
		ActiveCharacter = 1
	else:
		ActiveCharacter = 0

@export var Characters: Array[Character] = []

@export var ActiveCharacter: int = 0
