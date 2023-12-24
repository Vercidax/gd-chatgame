extends HBoxContainer


func set_data(account: Account, message: String):
	
	if !account.Characters[account.ActiveCharacter].Description.is_empty():
		$Background3/Description.text = account.Characters[account.ActiveCharacter].Description
	
	
	$AccountImage.texture = account.Characters[account.ActiveCharacter].CharacterImage
	$Background/Account.text = account.Characters[account.ActiveCharacter].Username+ ": "
	
	$"Written Message/Background2/Message".text = message
