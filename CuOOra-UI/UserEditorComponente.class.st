Class {
	#name : #UserEditorComponente,
	#superclass : #HeaderComponent,
	#instVars : [
		'usuario',
		'newNombre',
		'newPass'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
UserEditorComponente class >> user: anUser [
	^ self new
		usuario: anUser;
		yourself
]

{ #category : #'as yet unclassified' }
UserEditorComponente >> aceptar [
	| sis |
	sis := Cuoora soleInstance.
	self newNombre isNotEmpty
		ifTrue: [ usuario := sis crearUsuario: newNombre password: newPass ].
	self answer
]

{ #category : #'as yet unclassified' }
UserEditorComponente >> cancelar [
	usuario := nil.
	self answer
]

{ #category : #accessing }
UserEditorComponente >> newNombre [
	^ newNombre
]

{ #category : #accessing }
UserEditorComponente >> newNombre: anObject [
	newNombre := anObject
]

{ #category : #accessing }
UserEditorComponente >> newPass [
	^ newPass
]

{ #category : #accessing }
UserEditorComponente >> newPass: anObject [
	newPass := anObject
]

{ #category : #rendering }
UserEditorComponente >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Nombre de usuario: '.
					aCanvas break.
					aCanvas textInput on: #newNombre of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Password: '.
					aCanvas break.
					aCanvas textInput on: #newPass of: self ].
			aCanvas button
				callback: [ self aceptar ];
				with: 'Guardar'.
			aCanvas space.
			aCanvas button
				callback: [ self cancelar ];
				with: 'Cancelar' ]
]

{ #category : #accessing }
UserEditorComponente >> usuario [
	^ usuario
]

{ #category : #accessing }
UserEditorComponente >> usuario: anObject [
	usuario := anObject
]
