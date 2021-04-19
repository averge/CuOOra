Class {
	#name : #UserSistem,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'CuOOra-UI'
}

{ #category : #testing }
UserSistem >> isLoggedIn [
    ^ user isNil not
]

{ #category : #testing }
UserSistem >> login: aString [
    user := aString
]

{ #category : #testing }
UserSistem >> logout [
    user := nil
]

{ #category : #testing }
UserSistem >> user [
    ^ user
]

{ #category : #testing }
UserSistem >> user: anUser [
	user := anUser
]
