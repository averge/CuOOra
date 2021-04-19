Class {
	#name : #PreguntaEditorComponente,
	#superclass : #HeaderComponent,
	#instVars : [
		'newTitulo',
		'newDescripcion',
		'topicos',
		'usuario',
		'topicosSeleccionados'
	],
	#category : #'CuOOra-UI'
}

{ #category : #'as yet unclassified' }
PreguntaEditorComponente class >> topico: unTop usuario: unUs [
	^ self new
		topicos: unTop;
		usuario: unUs;
		yourself
]

{ #category : #'as yet unclassified' }
PreguntaEditorComponente >> cancelar [
	newTitulo := nil.
	newDescripcion := nil.
	self answer
]

{ #category : #'as yet unclassified' }
PreguntaEditorComponente >> configTopicos [
	| editor |
	editor := SelectorDeTopicos newCon: topicos.
	self call: editor.
	editor newTopicos
		ifNotNil: [ self topicos: editor newTopicos ]
		ifNil: [ self newTitulo: nil ].
		newTitulo ifEmpty: [ self newTitulo: nil ].
		newDescripcion ifEmpty: [ self newDescripcion: nil ].
	self answer
]

{ #category : #initialization }
PreguntaEditorComponente >> initialize [
	super initialize.
	topicos := OrderedCollection new
]

{ #category : #accessing }
PreguntaEditorComponente >> newDescripcion [
	^ newDescripcion
]

{ #category : #accessing }
PreguntaEditorComponente >> newDescripcion: anObject [
	newDescripcion := anObject
]

{ #category : #accessing }
PreguntaEditorComponente >> newTitulo [
	^ newTitulo
]

{ #category : #accessing }
PreguntaEditorComponente >> newTitulo: anObject [
	newTitulo := anObject
]

{ #category : #rendering }
PreguntaEditorComponente >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	self session isLoggedIn
		ifFalse: [ ^ self ].
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Titulo: '.
					aCanvas break.
					aCanvas textInput on: #newTitulo of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Descripcion: '.
					aCanvas break.
					(aCanvas textArea on: #newDescripcion of: self)
						columns: 40;
						rows: 2 ].
			aCanvas button
				callback: [ self configTopicos. ];
				with: 'Seleccionar topicos'.
			aCanvas space.
			aCanvas button
				callback: [ self cancelar ];
				with: 'Cancelar' ]
]

{ #category : #accessing }
PreguntaEditorComponente >> topicos [
	^ topicos
]

{ #category : #accessing }
PreguntaEditorComponente >> topicos: anObject [
	topicos := anObject
]

{ #category : #accessing }
PreguntaEditorComponente >> usuario [
	^ usuario
]

{ #category : #accessing }
PreguntaEditorComponente >> usuario: anObject [
	usuario := anObject
]
