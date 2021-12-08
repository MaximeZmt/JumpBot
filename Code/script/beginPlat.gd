extends Node

var c = 1
var first = true
var level1 = [1,2,5,9,14]
var level2 = [3,4,12,13,15]
var level3 = [6,7,8,10,11]
var level = 1
var chunks = []
var chk

var chunck1
var chunck2
var chunck3
var chunck4
var chunck5
var chunck6
var chunck7
var chunck8
var chunck9
var chunck10
var chunck11
var chunck12
var chunck13
var chunck14
var chunck15

func _ready():
	get_tree().set_quit_on_go_back(false)
	chunck1 = load('res://chunck/chunck1.tscn')
	chunck2 = load('res://chunck/chunck2.tscn')
	chunck3 = load('res://chunck/chunck3.tscn')
	chunck4 = load('res://chunck/chunck4.tscn')
	chunck5 = load('res://chunck/chunck5.tscn')
	chunck6 = load('res://chunck/chunck6.tscn')
	chunck7 = load('res://chunck/chunck7.tscn')
	chunck8 = load('res://chunck/chunck8.tscn')
	chunck9 = load('res://chunck/chunck9.tscn')
	chunck10 = load('res://chunck/chunck10.tscn')
	chunck11 = load('res://chunck/chunck11.tscn')
	chunck12 = load('res://chunck/chunck12.tscn')
	chunck13 = load('res://chunck/chunck13.tscn')
	chunck14 = load('res://chunck/chunck14.tscn')
	chunck15 = load('res://chunck/chunck15.tscn')
	
	randomize()
	chunks = level1
	get_node("CanvasLayer/level").set_text("Level: 1")

func _physics_process(delta):
	var position = get_tree().get_root().get_node("Node/Player").get_global_position() 
	if ((position.x-c*1600)>-1000 or first):
		first = false
		#var randChk = randi()%8+1
		var randChk = chunks[randi()%chunks.size()]
		#randChk = 8 #to block a chunck
		#var stri = 'chunck/chunck'+str(randChk)+'.tscn'
		#var chk = load(stri)
		if randChk == 1:
			chk = chunck1
		elif randChk == 2: 
			chk = chunck2
		elif randChk == 3:
			chk = chunck3
		elif randChk == 4:
			chk = chunck4
		elif randChk == 5:
			chk = chunck5
		elif randChk == 6:
			chk = chunck6
		elif randChk == 7:
			chk = chunck7
		elif randChk == 8:
			chk = chunck8
		elif randChk == 9:
			chk = chunck9
		elif randChk == 10:
			chk = chunck10
		elif randChk == 11:
			chk = chunck11
		elif randChk == 12:
			chk = chunck12
		elif randChk == 13:
			chk = chunck13
		elif randChk == 14:
			chk = chunck14
		elif randChk == 15:
			chk = chunck15
		
		var i = chk.instance()
		i.position = Vector2(c*1600,0) # 80 (8*10) pixel per tile as there are 20 tiles per chunck
		c += 1
		add_child(i)


func _on_score_level(data):
	level = data

	if level == 1:
		chunks = level1
		get_node("CanvasLayer/level").set_text("Level: 1")
	elif level == 2:
		chunks = level1 + level2
		get_node("CanvasLayer/level").set_text("Level: 2")
	elif level == 3:
		chunks = level1 + level2 + level3
		get_node("CanvasLayer/level").set_text("Level: 3")