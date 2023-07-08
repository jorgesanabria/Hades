extends Node

const MAX_ENEMY_COUNT = 6
const MAX_GHOST_COUNT = 6

var enemy_count = 0
var ghost_count = 0

var enemies_elimitated = 0


var indice_oleada = 0
var energia_requerida = 100
var energia_acumulada = 0
var maximo_enemigos_en_pantalla = 6
var maximo_enemigos_por_oleada = 24
var enemigos_en_la_oleada = 0
var enemigos_cada_3_segundos = 1
var enemigos_muertos = 0

func start():
	indice_oleada += 1
	energia_requerida = 100 * indice_oleada
	energia_acumulada = 0
	maximo_enemigos_en_pantalla = 6 * indice_oleada
	maximo_enemigos_por_oleada = 6 * indice_oleada
	enemigos_en_la_oleada = 0
	enemigos_cada_3_segundos = 1 * indice_oleada
	enemigos_muertos = 0
	
	print("indice oleada: " + str(indice_oleada))
	#print("indice oleada:")

func is_some_killed_enemy() -> bool: 
	return self.enemigos_muertos > 0

func add_enemies():
	self.maximo_enemigos_en_pantalla += self.enemigos_cada_3_segundos

func add_killed_enemy():
	self.enemigos_muertos += 1
	
func add_acumulated_energy():
	self.energia_acumulada += 5

func is_max_energy() -> bool:
	return self.energia_acumulada >= energia_requerida

func is_max_killed_enemies() -> bool:
	return self.enemigos_muertos >= self.maximo_enemigos_por_oleada
	
