Class {
	#name : #TopicUserEditor,
	#superclass : #HeaderComponent,
	#instVars : [
		'topicos',
		'topicoSelected'
	],
	#category : #'CuOOra-UI'
}

{ #category : #'as yet unclassified' }
TopicUserEditor class >> topicos:unTopico [
	^ self new
		topicos: unTopico ;
		yourself
]

{ #category : #'as yet unclassified' }
TopicUserEditor >> aceptar [
	topicoSelected := true.
	self answer
]

{ #category : #'as yet unclassified' }
TopicUserEditor >> cancelar [
	topicoSelected := false.
	topicos := nil.
	self answer
]

{ #category : #initialization }
TopicUserEditor >> initialize [
	super initialize.
	topicoSelected := false
]

{ #category : #rendering }
TopicUserEditor >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	self session isLoggedIn
		ifFalse: [ ^ self ].
	aCanvas
		form: [ aCanvas select
				list: topicos;
				labels: [ :each | each nombre ];
				callback: [ :value | topicos := value ].
			aCanvas space.
			aCanvas button
				callback: [ self aceptar ];
				with: 'Agregar Topico'.
			aCanvas space.
			aCanvas button
				callback: [ self cancelar ];
				with: 'Volver' ]
]

{ #category : #accessing }
TopicUserEditor >> topicoSelected [
	^ topicoSelected
]

{ #category : #accessing }
TopicUserEditor >> topicos [
	^ topicos
]

{ #category : #accessing }
TopicUserEditor >> topicos: anObject [
	topicos := anObject
]
