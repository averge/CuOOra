Class {
	#name : #Pregunta,
	#superclass : #Publicacion,
	#instVars : [
		'titulo',
		'descripcion',
		'respuestas',
		'topicos'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Pregunta class >> newQuestionWith: aTitle and: aDescripcion from: aUser for: someTopics [
	| question |
	question := self new.
	question titulo: aTitle.
	question descripcion: aDescripcion.
	question usuario: aUser.
	question agregarTopico: someTopics.
	^ question
]

{ #category : #'as yet unclassified' }
Pregunta >> agregarRespuesta: unaRespuesta [
	respuestas add: unaRespuesta
]

{ #category : #'as yet unclassified' }
Pregunta >> agregarTopico: someTopic [
	topicos addAll: someTopic asOrderedCollection
]

{ #category : #accessing }
Pregunta >> creacion [
	^ creacion
]

{ #category : #accessing }
Pregunta >> descripcion [
	^ descripcion
]

{ #category : #accessing }
Pregunta >> descripcion: anObject [
	descripcion := anObject
]

{ #category : #'as yet unclassified' }
Pregunta >> eliminarRespuestas [
	self eliminarReacciones.
	respuestas do: [ :respuesta | respuesta eliminarReacciones ].
	respuestas := OrderedCollection new
]

{ #category : #initialization }
Pregunta >> initialize [
	super initialize.
	respuestas := OrderedCollection new.
	topicos := OrderedCollection new
]

{ #category : #accessing }
Pregunta >> respuestas [
	^ respuestas sort: [ :res1 :res2 | res1 puntaje > res2 puntaje ]
]

{ #category : #accessing }
Pregunta >> titulo [
	^ titulo
]

{ #category : #accessing }
Pregunta >> titulo: anObject [
	titulo := anObject
]

{ #category : #accessing }
Pregunta >> topicos [
	^ topicos
]
