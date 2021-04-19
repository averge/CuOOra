Class {
	#name : #Cuoora,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'CuOOra-Model'
}

{ #category : #removing }
Cuoora class >> removeSoleInstance [
	soleInstance := nil
]

{ #category : #accessing }
Cuoora class >> soleInstance [
	soleInstance ifNil: [ soleInstance := self new ].
	^ soleInstance
]

{ #category : #'as yet unclassified' }
Cuoora >> agregarTopico: unTopico [
	| topicoUnico |
	topicoUnico := topicos select: [ :t | t nombre = unTopico nombre ].
	topicoUnico ifEmpty: [ topicos add: unTopico ]
]

{ #category : #'as yet unclassified' }
Cuoora >> agregarUsuarioAUsuarios: unUsuario [
	| usuarioUnico |
	usuarioUnico := usuarios select: [ :u | u userName = unUsuario userName ].
	usuarioUnico ifEmpty: [ usuarios add: unUsuario ]
]

{ #category : #'as yet unclassified' }
Cuoora >> crearTopico: aName Descripcion: aDescripcion [
	| topic |
	topic := Topico newTopicWith: aName and: aDescripcion.
	self agregarTopico: topic.
	^ topic
]

{ #category : #'as yet unclassified' }
Cuoora >> crearUsuario: aUser password: aPass [
	| nuevoUsuario |
	nuevoUsuario := Usuario newUserWith: aUser and: aPass.
	self agregarUsuarioAUsuarios: nuevoUsuario.
	^nuevoUsuario 
	
]

{ #category : #'as yet unclassified' }
Cuoora >> existeUsuario: anUser password: aPassword [
	| usuario |
	usuario := self usuarios select: [ :usu | usu userName = anUser and: usu password = aPassword ].
	^ usuario
]

{ #category : #initialization }
Cuoora >> initialize [
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new
]

{ #category : #accessing }
Cuoora >> preguntas [
	"Retorna todas las preguntas que existen recorriendo todas las preguntas de todos los usuarios."
   | xPreguntas |
	xPreguntas := Set new.
	usuarios do: [ :usuario | xPreguntas addAll: usuario preguntas ].
	^ xPreguntas
]

{ #category : #accessing }
Cuoora >> preguntasConTopico: unTopico [
	^ self preguntas
		select: [ :pregunta | pregunta topicos includes: unTopico ]
]

{ #category : #accessing }
Cuoora >> preguntasRelevantesPara: unUser [
	| xPreguntasRelevantes |
	xPreguntasRelevantes := Set new.
	unUser topicosFavoritos
		do: [ :topico | xPreguntasRelevantes addAll: (self preguntasConTopico: topico) ].
	xPreguntasRelevantes addAll: unUser preguntasDeSeguidos.
	^ xPreguntasRelevantes asOrderedCollection sort: [ :p1 :p2 | p1 creacion > p2 creacion ]
]

{ #category : #accessing }
Cuoora >> topicos [
	^ topicos
]

{ #category : #accessing }
Cuoora >> usuarios [
	^ usuarios
]
