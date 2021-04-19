Class {
	#name : #Reaccion,
	#superclass : #Object,
	#instVars : [
		'usuario',
		'creacion'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Reaccion class >> newWith: aUser [
	^ self new usuario: aUser
]

{ #category : #initialization }
Reaccion >> initialize [
	creacion := DateAndTime now
]

{ #category : #accessing }
Reaccion >> usuario [
	^ usuario
]

{ #category : #accessing }
Reaccion >> usuario: anObject [
	usuario := anObject
]
