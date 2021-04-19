Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'userName',
		'password',
		'preguntas',
		'respuestas',
		'topicosFavoritos',
		'sigue',
		'seguidores',
		'creacion'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Usuario class >> newUserWith: aUser and: aPass [
	| usuario |
	usuario := self new.
	usuario userName: aUser.
	usuario password: aPass.
	^ usuario
]

{ #category : #'as yet unclassified' }
Usuario >> agregarPregunta: unaPregunta [ 
	preguntas add: unaPregunta
]

{ #category : #'as yet unclassified' }
Usuario >> agregarTopicoFavorito: unTopico [
	(topicosFavoritos includes: unTopico)
		ifFalse: [ topicosFavoritos add: unTopico ]
]

{ #category : #'as yet unclassified' }
Usuario >> calcularPuntaje [
	| puntajeTotal |
	puntajeTotal := preguntas
		inject: 0
		into: [ :puntaje :pregunta | puntaje + pregunta puntaje ].
	puntajeTotal := puntajeTotal + (respuestas
		inject: 0
		into: [ :puntaje :respuesta | puntaje + respuesta puntaje ]).
	^ preguntas size * 20 + (respuestas size * 50) + puntajeTotal
]

{ #category : #accessing }
Usuario >> creacion [
	^ creacion
]

{ #category : #'as yet unclassified' }
Usuario >> crearPregunta: unTitulo con: unaDescripcion y: unTopico [
	| pregunta |
	pregunta := Pregunta
		newQuestionWith: unTitulo
		and: unaDescripcion
		from: self
		for: unTopico.
	self agregarPregunta: pregunta .
	^ pregunta
]

{ #category : #'as yet unclassified' }
Usuario >> crearRespuesta: aText para: unaPregunta [
	| respuesta |
	respuesta := Respuesta
		newAnswer: aText
		user: self
		for: unaPregunta.
	unaPregunta agregarRespuesta: respuesta.
	respuestas add: respuesta.
	^ respuesta
]

{ #category : #'as yet unclassified' }
Usuario >> darDislikeA: aPublication [

	^ aPublication darDislike: self.
]

{ #category : #'as yet unclassified' }
Usuario >> darLikeA: aPublication [

	^ aPublication darLike: self.
]

{ #category : #'as yet unclassified' }
Usuario >> eliminarPregunta: unaPregunta [
	unaPregunta respuestas
		do: [ :respuesta | respuestas remove: respuesta ].
	unaPregunta eliminarRespuestas.
	preguntas remove: unaPregunta.
	Smalltalk garbageCollect
]

{ #category : #initialization }
Usuario >> initialize [
	sigue := OrderedCollection new.
	seguidores := OrderedCollection new.
	topicosFavoritos := OrderedCollection new.
	preguntas := OrderedCollection new.
	respuestas := OrderedCollection new.
	creacion := DateAndTime now
]

{ #category : #accessing }
Usuario >> password [
	^ password
]

{ #category : #accessing }
Usuario >> password: anObject [
	password := anObject
]

{ #category : #accessing }
Usuario >> preguntas [
	^ preguntas
]

{ #category : #'as yet unclassified' }
Usuario >> preguntasDeSeguidos [
	| preguntasSeguidos |
	preguntasSeguidos := OrderedCollection new.
	sigue do: [ :seguido | preguntasSeguidos addAll: seguido preguntas ].
	^ preguntasSeguidos
]

{ #category : #accessing }
Usuario >> respuestas [
	^ respuestas
]

{ #category : #accessing }
Usuario >> seguidores [
	^ seguidores
]

{ #category : #'as yet unclassified' }
Usuario >> seguir: unUsuario [
	sigue add: unUsuario.
	unUsuario serSeguido: self
]

{ #category : #'as yet unclassified' }
Usuario >> serSeguido: unUsuario [
	seguidores add: unUsuario
]

{ #category : #accessing }
Usuario >> sigue [
	^ sigue
]

{ #category : #accessing }
Usuario >> topicosFavoritos [
	^ topicosFavoritos
]

{ #category : #accessing }
Usuario >> userName [
	^ userName
]

{ #category : #accessing }
Usuario >> userName: anObject [
	userName := anObject
]
