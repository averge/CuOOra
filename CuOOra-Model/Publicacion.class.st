Class {
	#name : #Publicacion,
	#superclass : #Object,
	#instVars : [
		'likes',
		'dislikes',
		'creacion',
		'usuario'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'as yet unclassified' }
Publicacion >> darDislike: unUser [
	| reaction oldReaction |
	reaction := Reaccion newWith: unUser.
	dislikes
		detect: [ :reaccion | reaccion usuario = unUser ]
		ifNone: [ dislikes add: reaction ].
	oldReaction := likes
		select: [ :reaccion | reaccion usuario = unUser ].
	oldReaction isEmpty
		ifFalse: [ likes remove: oldReaction first ].
	^ reaction
]

{ #category : #'as yet unclassified' }
Publicacion >> darLike: unUser [
	| reaction oldReaction |
	reaction := Reaccion newWith: unUser.
	likes
		detect: [ :reaccion | reaccion usuario = unUser ]
		ifNone: [ likes add: reaction ].
	oldReaction := dislikes
		select: [ :reaccion | reaccion usuario = unUser ].
	oldReaction isEmpty
		ifFalse: [ dislikes remove: oldReaction first ].
	^ reaction
]

{ #category : #accessing }
Publicacion >> dislikes [
	^ dislikes
]

{ #category : #'as yet unclassified' }
Publicacion >> eliminarReacciones [

	likes := OrderedCollection new.
	dislikes := OrderedCollection new.
]

{ #category : #initialization }
Publicacion >> initialize [
	creacion := DateAndTime now.
	likes := OrderedCollection new.
	dislikes := OrderedCollection new
]

{ #category : #accessing }
Publicacion >> likes [
	^ likes
]

{ #category : #'as yet unclassified' }
Publicacion >> puntaje [
	^ likes size - dislikes size
]

{ #category : #accessing }
Publicacion >> usuario [
	^ usuario
]

{ #category : #accessing }
Publicacion >> usuario: anObject [
	usuario := anObject
]
