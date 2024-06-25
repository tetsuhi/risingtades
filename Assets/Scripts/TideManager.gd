extends Node

const MAREA_INICIAL : int = 0

var mareaJugador : int = MAREA_INICIAL
var mareaOponente : int = MAREA_INICIAL
var marea_seleccionada : int 
var estadoMareaJugador : String
var estadoMareaOponente : String

func iniciarMareas():
	estadoMareaJugador = comprobarMarea(mareaJugador, estadoMareaJugador)
	estadoMareaOponente = comprobarMarea(mareaOponente, estadoMareaOponente)

func comprobarMarea(marea, estado):
	if marea >= -20 and marea < -16:
		estado = "muerta"
	elif marea >= -16 and marea < -8:
		estado = "baja"
	elif marea >= -8 and marea <= 8:
		estado = "inicial"
	elif marea > 8 and marea <= 16:
		estado = "alta"
	elif marea > 16 and marea <= 20:
		estado = "viva"
	else:
		print("Está fuera de los valores considerados.")
		return estado
	return estado

func update_tide(amount):
	if marea_seleccionada == 0:
		mareaJugador += amount
	else:
		mareaOponente += amount
