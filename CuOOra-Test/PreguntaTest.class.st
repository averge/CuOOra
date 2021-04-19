Class {
	#name : #PreguntaTest,
	#superclass : #TestCase,
	#instVars : [
		'xPregunta',
		'xUsuario1',
		'xUsuario2',
		'xUsuario3',
		'xRespuesta1',
		'xRespuesta2'
	],
	#category : #'CuOOra-Test'
}

{ #category : #running }
PreguntaTest >> setUp [
	| xUsuario xTopico1 xTopico2 xTopicos |
	super setUp.
	self setUpUsuarios.
	xUsuario := Usuario newUserWith: 'Marcos' and: 'ElMarcos'.
	xTopico1 := Topico newTopicWith: 'Comida' and: 'Recetas/Reviews'.
	xTopico2 := Topico newTopicWith: 'Musica' and: 'Covers/Acordes'.
	xTopicos := OrderedCollection new.
	xTopicos add: xTopico1.
	xTopicos add: xTopico2.
	xPregunta := Pregunta newQuestionWith: 'Titulo' and: 'Descripcion' from: xUsuario for: xTopicos.
	self setUpReacciones.
	self setUpRespuestas
]

{ #category : #running }
PreguntaTest >> setUpReacciones [
	xPregunta darLike: xUsuario1.
	xPregunta darDislike: xUsuario2.
	xPregunta darDislike: xUsuario3.
]

{ #category : #running }
PreguntaTest >> setUpRespuestas [
	
	xRespuesta1 := Respuesta newAnswer: 'Respuesta' user: xUsuario1 for: xPregunta.
	xRespuesta2 := Respuesta newAnswer: 'Respuesta' user: xUsuario2 for: xPregunta.
	xPregunta agregarRespuesta: xRespuesta1.
	xPregunta agregarRespuesta: xRespuesta2.
	xRespuesta1 darLike: xUsuario1 .
	xRespuesta1 darLike: xUsuario1 .
	xRespuesta1 darDislike: xUsuario2.
	xRespuesta2 darDislike: xUsuario2.
	xRespuesta2 darDislike: xUsuario3 .
]

{ #category : #running }
PreguntaTest >> setUpUsuarios [
	xUsuario1 := Usuario newUserWith: 'Juan' and: 'j123456'. 
	xUsuario2 := Usuario newUserWith: 'Pepe' and: 'p123456'.
	xUsuario3 := Usuario newUserWith: 'Lucas' and: 'l123456'.
]

{ #category : #running }
PreguntaTest >> testAgregarRespuesta [
	| xRespuesta |
	self assert: xPregunta respuestas size equals: 2.
	xRespuesta := Respuesta newAnswer: 'No' user: xUsuario1 for: xPregunta.
	xPregunta agregarRespuesta: xRespuesta.
	self assert: xPregunta respuestas size equals: 3
]

{ #category : #running }
PreguntaTest >> testAgregarTopico [
	| xTopico |
	xTopico := Topico newTopicWith: 'Titulo' and: 'Descripcion'.
	self assert: xPregunta topicos size equals: 2.
	xPregunta agregarTopico: xTopico.
	self assert: xPregunta topicos size equals: 3
]

{ #category : #running }
PreguntaTest >> testDarDislike [
	self assert: xPregunta likes size equals: 1.
	self assert: xPregunta dislikes size equals: 2.
	xPregunta darDislike: xUsuario1.
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes size equals: 3.
	xPregunta darDislike: xUsuario2.
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes size equals: 3
]

{ #category : #running }
PreguntaTest >> testDarLike [
	self assert: xPregunta likes size equals: 1.
	self assert: xPregunta dislikes size equals: 2.
	xPregunta darLike: xUsuario1.
	self assert: xPregunta likes size equals: 1.
	self assert: xPregunta dislikes size equals: 2.
	xPregunta darLike: xUsuario2.
	self assert: xPregunta likes size equals: 2.
	self assert: xPregunta dislikes size equals: 1
]

{ #category : #running }
PreguntaTest >> testEliminarReacciones [
	self assert: xPregunta likes size equals: 1.
	self assert: xPregunta dislikes size equals: 2.
	xPregunta eliminarReacciones.
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes isEmpty
]

{ #category : #running }
PreguntaTest >> testEliminarRespuestas [
	self assert: xPregunta respuestas size equals: 2.
	self assert: xPregunta likes size equals: 1.
	self assert: xPregunta dislikes size equals: 2.
	self
		assert:
			(xPregunta respuestas
				inject: 0
				into: [ :each :respuesta | each + respuesta likes size ])
		equals: 1.
	self
		assert:
			(xPregunta respuestas
				inject: 0
				into: [ :each :respuesta | each + respuesta dislikes size ])
		equals: 3.
	xPregunta eliminarRespuestas.
	self assert: xPregunta respuestas isEmpty.
	self assert: xPregunta likes isEmpty.
	self assert: xPregunta dislikes isEmpty.
	self
		assert:
			(xPregunta respuestas
				inject: 0
				into: [ :each :respuesta | each + respuesta likes size ])
		equals: 0.
	self
		assert:
			(xPregunta respuestas
				inject: 0
				into: [ :each :respuesta | each + respuesta dislikes size ])
		equals: 0
]

{ #category : #running }
PreguntaTest >> testPuntaje [
	self assert: xPregunta puntaje equals: -1.
	xPregunta dislikes removeAll.
	self assert: xPregunta puntaje equals: 1.
	xPregunta likes removeAll.
	self assert: xPregunta puntaje equals: 0

]

{ #category : #running }
PreguntaTest >> testRespuestas [
	self assert: xPregunta respuestas size equals: 2.
	self assert: (xPregunta respuestas asArray at: 1) equals: xRespuesta1
]
