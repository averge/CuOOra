Class {
	#name : #Topico,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'descripcion'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Topico class >> newTopicWith: aName and: aDescripcion [
	| topico |
	topico := self new.
	topico nombre: aName.
	topico descripcion: aDescripcion.
	^ topico
]

{ #category : #accessing }
Topico >> descripcion [
	^ descripcion
]

{ #category : #accessing }
Topico >> descripcion: anObject [
	descripcion := anObject
]

{ #category : #accessing }
Topico >> nombre [
	^ nombre
]

{ #category : #accessing }
Topico >> nombre: anObject [
	nombre := anObject
]
