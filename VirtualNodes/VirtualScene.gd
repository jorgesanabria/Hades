class_name VirtualScene
extends Node2D

var virtual_childrem: Array[BaseVirtualNode] = []
var virtual_nodes_to_remove: Array[BaseVirtualNode] = []

func _process(delta):
	for child_to_remove in self.virtual_nodes_to_remove:
		if self.virtual_childrem.has(child_to_remove):
			self.virtual_childrem.remove_at(self.virtual_childrem.find(child_to_remove))
	self.virtual_nodes_to_remove.clear()		
	
	for child in self.virtual_childrem:
		child.update(delta, self)
	queue_redraw()

func _physics_process(delta):
	var i = 0;
	while i < self.virtual_childrem.size():
		var j = i + 1
		#print("i: " + str(i))
		while j < self.virtual_childrem.size():
			#print("j: " + str(j))
			self.virtual_childrem[i].fix_distance(self.virtual_childrem[j], self)
			j += 1
		i += 1

func _draw():
	for child in self.virtual_childrem:
		child.draw(self)

func add_virtual_child(child: BaseVirtualNode):
	self.virtual_childrem.append(child)

func queue_remove_virtual_child(child: BaseVirtualNode):
	if child in self.virtual_nodes_to_remove:
		return
		
	self.virtual_nodes_to_remove.append(child)
