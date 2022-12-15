extends Node2D

onready var board_grid = $BoardGrid
onready var grid_sprite = $Board/Grid
onready var tp = $Pawns/Sprite

var selected_piece: Piece = null

class Piece:
	var id: int
	var type: String
	var node: Node
	var i: int = 0
	var j: int = 0
	var pos = Vector2(0, 0)
	
	func _init(node, i, j):
		self.node = node
		self.i = i
		self.j = j

var pieces: Array = []

var board = [
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
	[null, null, null, null, null, null, null, null],
]

func calc(i: int, j: int):
	var board_start = grid_sprite.global_position - grid_sprite.texture.get_size() / 2
	var board_size = grid_sprite.texture.get_size() * 2
	var cell_size = board_size.x / 8
	return Vector2((i-1.0) * cell_size + cell_size/2.0, (j-1.0) * cell_size + cell_size/2.0) - board_size / 2

func _ready():
	for j in range (1, 9):
		for i in range(1, 9):
			var tb = TextureButton.new()
			tb.connect("pressed", self, "_tile_click", [i, j])
			tb.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			tb.size_flags_vertical = Control.SIZE_EXPAND_FILL
			board_grid.add_child(tb)
	pass
	
	var test_p = Piece.new(tp, 1, 1)
	test_p.pos = calc(1, 1)
	board[0][0] = test_p
	pieces.append(test_p)

func _tile_click(i: int, j: int):
	print(i, " ", j, " ", selected_piece)
	if (selected_piece == null):
		selected_piece = board[i-1][j-1]
		if (selected_piece != null):
			selected_piece.node.get_material().set_shader_param("is_on", true)
	else:
		if (i != selected_piece.i || j != selected_piece.j):
			board[i - 1][j - 1] = board[selected_piece.i - 1][selected_piece.j - 1]
			board[selected_piece.i - 1][selected_piece.j - 1] = null
		selected_piece.i = i
		selected_piece.j = j
		selected_piece.pos = calc(i, j)
		selected_piece.node.get_material().set_shader_param("is_on", false)
		selected_piece = null

func _process(delta):
	for p in pieces:
		p.node.position = lerp(p.node.position, p.pos, 0.5 * delta * 25)
