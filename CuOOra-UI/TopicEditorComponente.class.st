Class {
	#name : #TopicEditorComponente,
	#superclass : #HeaderComponent,
	#instVars : [
		'topico',
		'newNombreTopico',
		'newDescripcion'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
TopicEditorComponente class >> topico: aTopic [
	^ self new
		topico: aTopic;
		yourself
]

{ #category : #'as yet unclassified' }
TopicEditorComponente >> aceptar [
	topico nombre: newNombreTopico.
	topico descripcion: newDescripcion.
	self answer
]

{ #category : #'as yet unclassified' }
TopicEditorComponente >> cancelar [
	topico := nil.
	self answer
]

{ #category : #accessing }
TopicEditorComponente >> newDescripcion [
	^ newDescripcion
]

{ #category : #accessing }
TopicEditorComponente >> newDescripcion: anObject [
	newDescripcion := anObject
]

{ #category : #accessing }
TopicEditorComponente >> newNombreTopico [
	^ newNombreTopico
]

{ #category : #accessing }
TopicEditorComponente >> newNombreTopico: anObject [
	newNombreTopico := anObject
]

{ #category : #rendering }
TopicEditorComponente >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Nombre de topico: '.
					aCanvas break.
					aCanvas textInput on: #newNombreTopico of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Descripcion: '.
					aCanvas break.
					(aCanvas textArea on: #newDescripcion of: self)
						columns: 40;
						rows: 2 ].
			aCanvas button
				callback: [ self aceptar ];
				with: 'Guardar'.
			aCanvas space.
			aCanvas button
				callback: [ self cancelar ];
				with: 'Cancelar' ]
]

{ #category : #accessing }
TopicEditorComponente >> topico [
	^ topico
]

{ #category : #accessing }
TopicEditorComponente >> topico: anObject [
	topico := anObject
]
