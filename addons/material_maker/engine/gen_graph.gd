tool
extends MMGenBase
class_name MMGenGraph

var connections = null

func get_port_source(gen_name: String, input_index: int) -> OutputPort:
	for c in connections:
		if c.to == gen_name and c.to_port == input_index:
			return OutputPort.new(get_node(c.from), c.from_port)
	return null

func connect_children(from, from_port : int, to, to_port : int):
	# disconnect target
	while true:
		var remove = -1
		for i in connections.size():
			if connections[i].to == to.name and connections[i].to_port == to_port:
				remove = i
				break
		if remove == -1:
			break
		connections.remove(remove)
	# create new connection
	connections.append({from=from.name, from_port=from_port, to=to.name, to_port=to_port})
	return true

func disconnect_children(from, from_port : int, to, to_port : int):
	while true:
		var remove = -1
		for i in connections.size():
			if connections[i].from == from.name and connections[i].from_port == from_port and connections[i].to == to.name and connections[i].to_port == to_port:
				remove = i
				break
		if remove == -1:
			break
		connections.remove(remove)
	return true