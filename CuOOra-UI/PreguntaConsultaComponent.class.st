Class {
	#name : #PreguntaConsultaComponent,
	#superclass : #PreguntaCommon,
	#instVars : [
		'pregunta',
		'sistema'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
PreguntaConsultaComponent class >> pregunta: aPregunta [
	^ self new
		pregunta: aPregunta;
		yourself
]

{ #category : #'as yet unclassified' }
PreguntaConsultaComponent >> crearRespuesta: unaPregunta [
	| editor us |
	editor := RespuestaEditorComponente newConPregunta: unaPregunta.
	self call: editor.
	us := self session user.
	editor newTexto
		ifNotNil: [us crearRespuesta: editor newTexto para: unaPregunta].
]

{ #category : #'as yet unclassified' }
PreguntaConsultaComponent >> infoRespuestas: aRespuesta on: aCanvas [
	aCanvas listItem
		with: [ aCanvas big: 'Respuesta de '.
			aCanvas anchor
				   callback: [ self consultarUsuario: aRespuesta usuario ];
				   with: [ aCanvas big: aRespuesta usuario userName ].
			aCanvas paragraph: aRespuesta texto.
			self likesYDislikes: aRespuesta con: aCanvas ]
]

{ #category : #initialization }
PreguntaConsultaComponent >> initialize [
	super initialize.
	sistema := Cuoora soleInstance.
]

{ #category : #accessing }
PreguntaConsultaComponent >> pregunta: anObject [
	pregunta := anObject
]

{ #category : #rendering }
PreguntaConsultaComponent >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	self session isLoggedIn
		ifFalse: [ ^ self ].
	self infoPreguntas: pregunta on: aCanvas.
	self verRespuestas: aCanvas.
	aCanvas anchor
		callback: [ self volver ];
		with: 'Volver'
]

{ #category : #'as yet unclassified' }
PreguntaConsultaComponent >> verRespuestas: aCanvas [
	aCanvas horizontalRule.
	pregunta respuestas isEmpty
		ifTrue: [ aCanvas paragraph: 'No hay respuestas' ]
		ifFalse: [ aCanvas
				unorderedList: [ pregunta respuestas do: [ :each | self infoRespuestas: each on: aCanvas ] ] ].
	aCanvas anchor
		callback: [ self crearRespuesta: pregunta ];
		with: [ aCanvas button: 'Crear Respuesta' ].
	aCanvas horizontalRule
]

{ #category : #'as yet unclassified' }
PreguntaConsultaComponent >> volver [
	pregunta := nil.
	self answer
]
