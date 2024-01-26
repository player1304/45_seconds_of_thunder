extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var sort_hs = [4,5,1,2,3]
	print(sort_hs)
	sort_hs.sort_custom(func(a,b): 	return a>b) # descending sort
	print(sort_hs)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
