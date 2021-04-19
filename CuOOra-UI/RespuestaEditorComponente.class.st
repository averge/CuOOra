Class {
	#name : #RespuestaEditorComponente,
	#superclass : #HeaderComponent,
	#instVars : [
		'newTexto',
		'pregunta'
	],
	#category : #'CuOOra-UI'
}

{ #category : #'instance creation' }
RespuestaEditorComponente class >> newConPregunta:unaPregunta [
	^ self new
		pregunta: unaPregunta ;
		yourself
]

{ #category : #'as yet unclassified' }
RespuestaEditorComponente >> aceptar [
	newTexto ifEmpty: [ self newTexto: nil ].
	self answer
]

{ #category : #'as yet unclassified' }
RespuestaEditorComponente >> cancelar [
	newTexto := nil.
	self answer
]

{ #category : #accessing }
RespuestaEditorComponente >> newTexto [
	^ newTexto
]

{ #category : #accessing }
RespuestaEditorComponente >> newTexto: anObject [
	newTexto := anObject
]

{ #category : #accessing }
RespuestaEditorComponente >> pregunta: anObject [
	pregunta := anObject
]

{ #category : #'as yet unclassified' }
RespuestaEditorComponente >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	self session isLoggedIn
		ifFalse: [ ^ self ].
	aCanvas big: pregunta titulo.
	aCanvas break.
	aCanvas emphasis: pregunta descripcion.
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Ingrese su respuesta: '.
					aCanvas break.
					(aCanvas textArea on: #newTexto of: self)
						columns: 40;
						rows: 2 ].
			aCanvas button
				callback: [ self aceptar ];
				with: 'Aceptar'.
			aCanvas space.
			aCanvas button
				callback: [ self cancelar ];
				with: 'Cancelar' ]
]
