extends TileMap

var distance = -4000 #min -1600

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	var p = get_tree().get_root().get_node("Node/Player").get_global_position()
	var s = self.get_global_position()
	if ((s.x-p.x)< distance):
		queue_free()
	pass