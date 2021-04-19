Class {
	#name : #HeaderComponent,
	#superclass : #WAComponent,
	#instVars : [
		'session'
	],
	#category : #'CuOOra-UI'
}

{ #category : #'as yet unclassified' }
HeaderComponent >> header: aCanvas session: aSession [
	aCanvas span
		style: 'font-size: 30px;';
		with: 'CuOOra'.
	aSession isLoggedIn
		ifTrue: [ aCanvas span
				style: 'float: right;';
				with: [ aCanvas strong: aSession user userName.
					aCanvas space.
					aCanvas anchor
						callback: [ self logout: aSession ];
						with: 'Log out' ] ].
	aCanvas horizontalRule
]

{ #category : #'as yet unclassified' }
HeaderComponent >> logout: aSession [
	aSession logout.
	self answer
]
