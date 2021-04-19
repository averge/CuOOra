Class {
	#name : #UsuarioTest,
	#superclass : #TestCase,
	#instVars : [
		'xUsuario',
		'xTopico',
		'xUsuario2',
		'xUsuario3',
		'xUsuario1',
		'xPregunta',
		'xRespuesta1'
	],
	#category : #'CuOOra-Test'
}

{ #category : #initialization }
UsuarioTest >> setUp [
	super setUp.
	xUsuario := Usuario newUserWith: 'Juan' and: 'j123456'.
	xUsuario1 := Usuario newUserWith: 'ElOtro' and: 'asdasd'.
	xUsuario2 := Usuario newUserWith: 'Pepe' and: 'p123456'.
	xUsuario3 := Usuario newUserWith: 'Lucas' and: 'l123456'.
	self setUpPreguntasYRespuestas.
	self setUpSeguidores
]

{ #category : #initialization }
UsuarioTest >> setUpPreguntasYRespuestas [
	| xPregunta2 xRespuesta2 |
	xPregunta := Pregunta
		newQuestionWith: 'Title1'
		and: 'Descripcion1'
		from: xUsuario
		for: xTopico.
	xPregunta2 := Pregunta
		newQuestionWith: 'Title2'
		and: 'Descripcion2'
		from: xUsuario2
		for: xTopico.
	xUsuario agregarPregunta: xPregunta.
	xUsuario2 agregarPregunta: xPregunta2.
	xRespuesta1 := Respuesta
		newAnswer: 'Respuesta'
		user: xUsuario
		for: xPregunta.
	xRespuesta2 := Respuesta
		newAnswer: 'Respuesta'
		user: xUsuario2
		for: xPregunta2.
	xUsuario respuestas add: xRespuesta1.
	xUsuario2 respuestas add: xRespuesta2.
	xPregunta agregarRespuesta: xRespuesta1.
	xPregunta2 agregarRespuesta: xRespuesta2.
	xPregunta
		darDislike: (Usuario newUserWith: 'user1' and: 'password1').
	xPregunta
		darDislike: (Usuario newUserWith: 'user1' and: 'password1').
	xPregunta
		darDislike: (Usuario newUserWith: 'user1' and: 'password1').
	xPregunta
		darDislike: (Usuario newUserWith: 'user1' and: 'password1').
	xPregunta2 darLike: (Usuario newUserWith: 'user1' and: 'password1').
	xPregunta2 darLike: (Usuario newUserWith: 'user1' and: 'password1').
	xPregunta2 darLike: (Usuario newUserWith: 'user1' and: 'password1').
	xRespuesta1 darLike: (Usuario newUserWith: 'user1' and: 'password1').
	xRespuesta2
		darDislike: (Usuario newUserWith: 'user1' and: 'password1')
]

{ #category : #initialization }
UsuarioTest >> setUpSeguidores [
	xUsuario seguir: xUsuario2.
	xUsuario seguir: xUsuario3.
	xUsuario2 seguir: xUsuario.
	xUsuario2 seguir: xUsuario3.
	
]

{ #category : #initialization }
UsuarioTest >> testAgregarTopicoFavorito [
	self assert: xUsuario topicosFavoritos isEmpty.
	xTopico := Topico newTopicWith: 'Comida' and: 'Recetas/Reviews'.
	xUsuario agregarTopicoFavorito: xTopico.
	self assert: xUsuario topicosFavoritos size equals: 1.
	self assert: (xUsuario topicosFavoritos includes: xTopico)
]

{ #category : #initialization }
UsuarioTest >> testCalcularPuntaje [
	| puntaje |
	self assert: xUsuario preguntas size equals: 1.
	self assert: xUsuario respuestas size equals: 1.
	self assert: xUsuario preguntas first puntaje equals: -4.
	self assert: xUsuario respuestas first puntaje equals: 1.
	puntaje := xUsuario calcularPuntaje.
	self assert: puntaje equals: 67
]

{ #category : #initialization }
UsuarioTest >> testCrearPreguntaConY [
	self assert: xUsuario preguntas size equals: 1.
	xUsuario crearPregunta: 'asd' con: 'asd' y: xTopico.
	self assert: xUsuario preguntas size equals: 2
]

{ #category : #initialization }
UsuarioTest >> testCrearRespuestaPara [
	self assert: xUsuario respuestas size equals: 1.
	self assert: xPregunta respuestas size equals: 1.
	xUsuario crearRespuesta: 'asdasd' para: xPregunta.
	self assert: xUsuario respuestas size equals: 2.
	self assert: xPregunta respuestas size equals: 2
]

{ #category : #initialization }
UsuarioTest >> testDarDislikeA [
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes size equals: 4.
	xPregunta darLike: xUsuario.
	self assert: xPregunta likes size equals: 1.
	self assert: xPregunta dislikes size equals: 4.
	xUsuario darDislikeA: xPregunta.
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes size equals: 5.
	xUsuario darDislikeA: xPregunta.
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes size equals: 5
]

{ #category : #initialization }
UsuarioTest >> testDarLikeA [
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes size equals: 4.
	xPregunta darDislike: xUsuario.
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes size equals: 5.
	xUsuario darLikeA: xPregunta.
	self assert: xPregunta likes size equals: 1.
	self assert: xPregunta dislikes size equals: 4.
	xUsuario darLikeA: xPregunta.
	self assert: xPregunta likes size equals: 1.
	self assert: xPregunta dislikes size equals: 4
]

{ #category : #initialization }
UsuarioTest >> testEliminarPregunta [
	self assert: xUsuario preguntas size equals: 1.
	self assert: xUsuario preguntas first respuestas size equals: 1.
	self assert: xUsuario preguntas first likes isEmpty.
	self assert: xUsuario preguntas first dislikes size equals: 4.
	self
		assert: xUsuario preguntas first respuestas first likes size
		equals: 1.
	self
		assert: xUsuario preguntas first respuestas first dislikes isEmpty.
	xUsuario eliminarPregunta: xPregunta.
	self assert: xUsuario preguntas isEmpty.
	self assert: xPregunta respuestas isEmpty.
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes isEmpty.
	self assert: xRespuesta1 likes isEmpty.
	self assert: xRespuesta1 dislikes isEmpty
]

{ #category : #initialization }
UsuarioTest >> testPreguntasDeSeguidos [
	self assert: xUsuario preguntasDeSeguidos size equals: 1.
	xUsuario3 crearPregunta: 'Asd' con: 'Asd' y: xTopico.
	self assert: xUsuario preguntasDeSeguidos size equals: 2.
	xUsuario1 crearPregunta: 'asd' con: 'asd' y: xTopico.
	self assert: xUsuario preguntasDeSeguidos size equals: 2
]

{ #category : #initialization }
UsuarioTest >> testSeguir [
	self assert: xUsuario sigue size equals: 2.
	self assert: xUsuario1 seguidores isEmpty.
	xUsuario seguir: xUsuario1.
	self assert: xUsuario sigue size equals: 3.
	self assert: xUsuario1 seguidores size equals: 1
]

{ #category : #initialization }
UsuarioTest >> testSerSeguido [
	self assert: xUsuario seguidores size equals: 1.
	xUsuario serSeguido: xUsuario1.
	self assert: xUsuario seguidores size equals: 2
]
