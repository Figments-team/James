extends Node

var players = Array()

func getPlayer():
	if(players.size() > 0):
		return players.back()

func playOnce(path):
	players.append(AudioStreamPlayer.new())
	var player = players.back()
	self.add_child(player)
	player.stream = load(path)
	player.play()

func playLooped(path):
	players.append(AudioStreamPlayer.new())
	var player = players.back()
	self.add_child(player)
	player.stream = load(path)
	player.play()
