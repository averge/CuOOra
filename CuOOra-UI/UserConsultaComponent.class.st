Class {
	#name : #UserConsultaComponent,
	#superclass : #PreguntaCommon,
	#instVars : [
		'usuario'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
UserConsultaComponent class >> usuario: unUsuario [
	^ self new usuario: unUsuario
]

{ #category : #'as yet unclassified' }
UserConsultaComponent >> follow [
	self session user seguir: usuario
]

{ #category : #'as yet unclassified' }
UserConsultaComponent >> preguntas: aCanvas [
	aCanvas heading level2 with: 'Preguntas de ' , usuario userName.
	usuario preguntas isEmpty
		ifTrue: [ aCanvas paragraph: 'El usuario no ha hecho ninguna pregunta todavia.' ]
		ifFalse: [ aCanvas
				unorderedList: [ usuario preguntas do: [ :each | self infoPreguntas: each on: aCanvas ] ] ]
]

{ #category : #'as yet unclassified' }
UserConsultaComponent >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	self session isLoggedIn
		ifFalse: [ ^ self ].
	self preguntas: aCanvas.
	aCanvas horizontalRule.
	((self session user sigue includes: usuario) or: (self session user == usuario))
		ifFalse: [ aCanvas anchor
				callback: [ self follow ];
				with: 'Seguir' ].
	aCanvas space.
	aCanvas anchor
		callback: [ self volver ];
		with: 'Volver'
]

{ #category : #accessing }
UserConsultaComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
UserConsultaComponent >> usuario: anObject [
	usuario := anObject
]

{ #category : #'as yet unclassified' }
UserConsultaComponent >> volver [
	usuario := nil.
	self answer
]
