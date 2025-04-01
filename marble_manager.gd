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
	var match_start_index = marble_array.find(marble)
	var matched_marbles_array : Array[Marble]
	matched_marbles_array.append(marble)
	
	var first_marble_outside_match : Marble
	var last_marble_outside_match : Marble
	#for loop for matching forward
	for i in range(match_start_index+1,marble_array.size()-1 ):
		if marble_array[i].own_color == marble.own_color:
			print(marble_array[i].own_color)
			matched_marbles_array.append(marble_array[i])
		else:
			if i < marble_array.size():
				last_marble_outside_match = marble_array[i]
			break
	#for loop matching backward
	for i in range(match_start_index-1, -1, -1):
		if marble_array[i].own_color == marble.own_color:
			matched_marbles_array.append(marble_array[i])
		else:
			if i >= 0:
				first_marble_outside_match = marble_array[i]
			break
	
	#check if match is big enough
	if matched_marbles_array.size() >= GlobalVariables.min_match_size:
		print("MATCH!")
		for i in matched_marbles_array:
			#delete matched marbles
			marble_array.erase(i)
			i.queue_free()
		if first_marble_outside_match && last_marble_outside_match:
			_gap_check(first_marble_outside_match, last_marble_outside_match)
	_update_labels()

func _update_labels():
	for index in marble_array:
		var marble = index as Marble
		marble.set_debug_text(str(marble_array.find(marble)))

func _gap_check(before_gap: Marble, after_gap : Marble):
	print("GAP CHECK")
	for i in range(marble_array.find(before_gap), -1, -1):
		marble_array[i].stop()
	if before_gap.own_color == after_gap.own_color:
		for i in range(marble_array.find(before_gap), -1, -1):
			marble_array[i].start_rollback()
