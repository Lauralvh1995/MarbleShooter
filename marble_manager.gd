extends Node2D

@export var marble_array : Array[Marble]
@export var track : Path2D

func add_marble_from_spawn(marble : Marble):
	marble_array.append(marble)
	marble.marble_entered.connect(add_marble_from_shot)
	_update_labels()

func add_marble_from_shot(color: String, marble : Marble, direction : float):
	# instantiate a new marble with color X
	var marble_to_be_spawned = GlobalVariables.trackMarble.instantiate()
	track.call_deferred("add_child",marble_to_be_spawned)
	marble_to_be_spawned.set_color(color)
	# determine spawn point
	var hit_marble_index = marble_array.find(marble)
	var offset : float
	var new_index : int
	if direction >= 0:
		#in front
		new_index = hit_marble_index
		offset = track.curve.get_closest_offset(marble.position)+50
		#50 is marble's diameter in px
	else:
		#behind
		new_index = hit_marble_index+1
		offset = track.curve.get_closest_offset(marble.position)
		
	for i in range(0, new_index):
		marble_array[i].progress += 50
	#50 is marble's diameter in px
	marble_array.insert(new_index, marble_to_be_spawned)
	marble_to_be_spawned.progress = offset
	print(marble_to_be_spawned.position)
	# initiate match from newly spawned marble
	marble_to_be_spawned.marble_entered.connect(add_marble_from_shot)
	_match_marbles(marble_to_be_spawned)
	_update_labels()

func _match_marbles(marble: Marble):
	print("matching is not implemented yet")
	_update_labels()
	#TODO: Implement matching
	pass

func _update_labels():
	for index in marble_array:
		var marble = index as Marble
		marble.set_debug_text(str(marble_array.find(marble)))
