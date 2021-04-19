Class {
	#name : #Respuesta,
	#superclass : #Publicacion,
	#instVars : [
		'texto',
		'pregunta'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Respuesta class >> newAnswer: aText user: anUser for: aQuestion [
	| answer |
	answer := self new.
	answer texto: aText.
	answer usuario: anUser.
	answer pregunta: aQuestion.
	^ answer
]

{ #category : #initialization }
Respuesta >> initialize [
	super initialize.
]

{ #category : #accessing }
Respuesta >> pregunta [
	^ pregunta
]

{ #category : #accessing }
Respuesta >> pregunta: unaPregunta [
	pregunta := unaPregunta
]

{ #category : #accessing }
Respuesta >> texto [
	^ texto
]

{ #category : #accessing }
Respuesta >> texto: anObject [
	texto := anObject
]
