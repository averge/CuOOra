Class {
	#name : #CuooraTest,
	#superclass : #TestCase,
	#instVars : [
		'xCuOOra',
		'xUsuario1',
		'xUsuario2',
		'xUsuario3',
		'xTopico1',
		'xTopico2',
		'xTopico3',
		'xPregunta1',
		'xPregunta2',
		'xPregunta3',
		'xTopicos1',
		'xTopicos2'
	],
	#category : #'CuOOra-Test'
}

{ #category : #running }
CuooraTest >> setUp [
	super setUp.
	xCuOOra := Cuoora new.
	self setUpUsuarios.
	self setUpTopicos.
	self setUpPreguntas.
	self setUpSeguidores
]

{ #category : #initialization }
CuooraTest >> setUpPreguntas [
	xPregunta1 := Pregunta newQuestionWith: 'Title1' and: 'Descripcion1' from: xUsuario1 for: xTopico3.
	xPregunta2 := Pregunta newQuestionWith: 'Title2' and: 'Descripcion2' from: xUsuario2 for: xTopicos1.
	xPregunta3 := Pregunta newQuestionWith: 'Title3' and: 'Descripcion3' from: xUsuario2 for: xTopicos2.
	xUsuario1 agregarPregunta:  xPregunta1.
	xUsuario2 agregarPregunta: xPregunta2.
	xUsuario2 agregarPregunta: xPregunta3
]

{ #category : #initialization }
CuooraTest >> setUpSeguidores [
	xUsuario1 seguir: xUsuario2.
	xUsuario1 seguir: xUsuario3.
	xUsuario1 serSeguido: xUsuario2.
	xUsuario2 seguir: xUsuario1.
	xUsuario2 seguir: xUsuario3.
	xUsuario2 serSeguido: xUsuario1.
	xUsuario3 serSeguido: xUsuario1.
	xUsuario3 serSeguido: xUsuario2
]

{ #category : #initialization }
CuooraTest >> setUpTopicos [
	xTopico1 := Topico newTopicWith: 'Comida' and: 'Recetas/Reviews'.
	xTopico2 := Topico newTopicWith: 'Musica' and: 'Covers/Acordes'.
	xTopico3 := Topico newTopicWith: 'Libros' and: 'Pdfs/Reviews'.
	xCuOOra agregarTopico: xTopico1.
	xCuOOra agregarTopico: xTopico2.
	xCuOOra agregarTopico: xTopico3.	
	xTopicos1 := OrderedCollection new.
	xTopicos2 := OrderedCollection new.
	xTopicos1 add: xTopico1.
	xTopicos1 add: xTopico2.
	xTopicos2 add: xTopico1.
	xTopicos2 add: xTopico2.
	xTopicos2 add: xTopico3.
	xUsuario1 agregarTopicoFavorito: xTopico1.
	xUsuario1 agregarTopicoFavorito: xTopico2.
	xUsuario1 agregarTopicoFavorito: xTopico3.
	xUsuario3 agregarTopicoFavorito: xTopico1.
]

{ #category : #initialization }
CuooraTest >> setUpUsuarios [
	xUsuario1 := Usuario newUserWith: 'Juan' and: 'j123456'. 
	xUsuario2 := Usuario newUserWith: 'Marcos' and: 'ElMarcos'.
	xUsuario3 := Usuario newUserWith: 'Mara' and: 'CuteMara123'.
	xCuOOra agregarUsuarioAUsuarios: xUsuario1.
	xCuOOra agregarUsuarioAUsuarios: xUsuario2.
	xCuOOra agregarUsuarioAUsuarios: xUsuario3.
]

{ #category : #initialization }
CuooraTest >> testAgregarTopico [
	| topicoNuevo |
	topicoNuevo := Topico newTopicWith: 'Titulo' and: 'Descripcion'.
	self assert: xCuOOra topicos size equals: 3.
	xCuOOra agregarTopico: topicoNuevo.
	self assert: xCuOOra topicos size equals: 4.
	self assert: (xCuOOra topicos includes: topicoNuevo)
]

{ #category : #initialization }
CuooraTest >> testAgregarUsuarioAUsuarios [
	| usuarioNuevo |
	usuarioNuevo := Usuario newUserWith: 'User1' and: 'Password1'.
	self assert: xCuOOra usuarios size equals: 3.
	xCuOOra agregarUsuarioAUsuarios: usuarioNuevo.
	self assert: xCuOOra usuarios size equals: 4.
	self assert: (xCuOOra usuarios includes: usuarioNuevo)
]

{ #category : #initialization }
CuooraTest >> testCrearTopicoDescripcion [
	| xTopico |
	self assert: xCuOOra topicos size equals: 3.
	xTopico := xCuOOra crearTopico: 'Topico2' Descripcion: 'Descripcion2'.
	self assert: (xCuOOra topicos includes: xTopico)
]

{ #category : #initialization }
CuooraTest >> testCrearUsuarioPassword [
	| xUsuario |
	self assert: xCuOOra usuarios size equals: 3.
	xUsuario := xCuOOra crearUsuario: 'Usuario2' password: 'Pass2'.
	self assert: (xCuOOra usuarios includes: xUsuario)
]

{ #category : #initialization }
CuooraTest >> testExisteUsuarioPassword [
	self assert: (xCuOOra existeUsuario: 'Juan' password: 'j123456') isNotEmpty.
	self assert: (xCuOOra existeUsuario: 'Usuario inexistente' password: 'pass') isEmpty
]

{ #category : #initialization }
CuooraTest >> testPreguntas [
	| xPreguntas |
	xPreguntas := xCuOOra preguntas.
	self assert: xPreguntas size equals: 3.
	self assert: (xPreguntas includes: xPregunta1).
	self assert: (xPreguntas includes: xPregunta2).
	self assert: (xPreguntas includes: xPregunta3)
]

{ #category : #initialization }
CuooraTest >> testPreguntasConTopico [
	| conTopico1 conTopico2 conTopico3 |
	conTopico1 := xCuOOra preguntasConTopico: xTopico1.
	conTopico2 := xCuOOra preguntasConTopico: xTopico2.
	conTopico3 := xCuOOra preguntasConTopico: xTopico3.
	self assert: conTopico1 size equals: 2.
	self assert: conTopico2 size equals: 2.
	self assert: conTopico3 size equals: 2.
	self assert: (conTopico1 includes: xPregunta2).
	self assert: (conTopico1 includes: xPregunta3).
	self assert: (conTopico2 includes: xPregunta2).
	self assert: (conTopico2 includes: xPregunta3).
	self assert: (conTopico3 includes: xPregunta1).
	self assert: (conTopico3 includes: xPregunta3)
]

{ #category : #initialization }
CuooraTest >> testPreguntasRelevantesPara [
	| xPR1 xPR2 xPR3 |
	xPR1 := xCuOOra preguntasRelevantesPara: xUsuario1.
	xPR2 := xCuOOra preguntasRelevantesPara: xUsuario2.
	xPR3 := xCuOOra preguntasRelevantesPara: xUsuario3.
	self assert: xPR1 size equals: 3.
	self assert: xPR2 size equals: 1.
	self assert: xPR3 size equals: 2.
	self assert: (xPR1 includes: xPregunta1).
	self assert: (xPR1 includes: xPregunta2).
	self assert: (xPR1 includes: xPregunta3).
	self assert: (xPR2 includes: xPregunta1).
	self assert: (xPR3 includes: xPregunta2).
	self assert: (xPR3 includes: xPregunta3)
]
