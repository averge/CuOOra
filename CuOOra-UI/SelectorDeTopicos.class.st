Class {
	#name : #SelectorDeTopicos,
	#superclass : #HeaderComponent,
	#instVars : [
		'topicos',
		'newTopicos'
	],
	#category : #'CuOOra-UI'
}

{ #category : #'instance creation' }
SelectorDeTopicos class >> newCon:tops [
	^ self new
		topicos: tops;
		yourself
]

{ #category : #'as yet unclassified' }
SelectorDeTopicos >> aceptar [
	topicos ifNotEmpty: [ newTopicos removeLast ].
	self answer
]

{ #category : #'as yet unclassified' }
SelectorDeTopicos >> agregar: aTopico [
	self newTopicos add: aTopico.
	topicos := topicos reject: [ :top | top nombre = aTopico nombre ].
]

{ #category : #'as yet unclassified' }
SelectorDeTopicos >> cancelar [
	newTopicos := nil.
	self answer 
]

{ #category : #'as yet unclassified' }
SelectorDeTopicos >> initialize [
	super initialize.
	newTopicos := OrderedCollection new
]

{ #category : #'as yet unclassified' }
SelectorDeTopicos >> newTopicos [
	^ newTopicos
]

{ #category : #'as yet unclassified' }
SelectorDeTopicos >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	self session isLoggedIn
		ifFalse: [ ^ self ].
	aCanvas
		form: [ (topicos isEmpty and: newTopicos isEmpty)
				ifTrue: [ aCanvas paragraph: 'No existen topicos en CuOOra, cree uno primero' ]
				ifFalse: [ self seleccionDeTopicos: aCanvas ].
			aCanvas button
				callback: [ self cancelar ];
				with: 'Cancelar' ]
]

{ #category : #'as yet unclassified' }
SelectorDeTopicos >> seleccionDeTopicos: aCanvas [
	topicos isEmpty
		ifFalse: [ aCanvas text: 'Seleccione uno o mas topicos:  '.
			aCanvas break.
			aCanvas select
				list: topicos;
				labels: [ :each | each nombre ];
				callback: [ :value | self agregar: value ].
			aCanvas space.
			aCanvas button with: 'Agregar topico' ].
	aCanvas paragraph: 'Topicos seleccionados: '.
	aCanvas
		unorderedList: [ newTopicos do: [ :each | aCanvas listItem: each nombre ] ].
	newTopicos isEmpty
		ifFalse: [ aCanvas button
				callback: [ self aceptar ];
				with: 'Confirmar'.
			aCanvas space ]
		ifTrue: [ aCanvas paragraph
				with: [ aCanvas small: 'No hay topicos seleccionados' ] ].
]

{ #category : #accessing }
SelectorDeTopicos >> topicos [
	^ topicos
]

{ #category : #accessing }
SelectorDeTopicos >> topicos: anObject [
	topicos := anObject
]
