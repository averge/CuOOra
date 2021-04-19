Class {
	#name : #UserManejoComponente,
	#superclass : #HeaderComponent,
	#instVars : [
		'sistema',
		'inUser',
		'inPassword',
		'loggedInUser'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
UserManejoComponente >> inPassword [
	^ inPassword
]

{ #category : #accessing }
UserManejoComponente >> inPassword: anObject [
	inPassword := anObject
]

{ #category : #accessing }
UserManejoComponente >> inUser [
	^ inUser
]

{ #category : #accessing }
UserManejoComponente >> inUser: anObject [
	inUser := anObject
]

{ #category : #initialization }
UserManejoComponente >> initialize [
	super initialize.
	sistema := Cuoora soleInstance
]

{ #category : #accessing }
UserManejoComponente >> loggedInUser [
	^ loggedInUser
]

{ #category : #initialization }
UserManejoComponente >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Usuario: '.
					aCanvas break.
					aCanvas textInput on: #inUser of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Password: '.
					aCanvas break.
					aCanvas textInput on: #inPassword of: self ].
			aCanvas button
				callback: [ self validar ];
				with: 'Iniciar sesion' ]
]

{ #category : #'as yet unclassified' }
UserManejoComponente >> validar [
	| us |
	us := sistema existeUsuario: inUser password: inPassword.
	loggedInUser := us isEmpty
		ifTrue: [ nil ]
		ifFalse: [ us first ].
	self answer
]
