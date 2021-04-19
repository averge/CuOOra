Class {
	#name : #PreguntaCommon,
	#superclass : #HeaderComponent,
	#category : #'CuOOra-UI'
}

{ #category : #'as yet unclassified' }
PreguntaCommon >> consultarPregunta: aPregunta [
	| view |
	view := PreguntaConsultaComponent pregunta: aPregunta.
	self call: view.
]

{ #category : #'as yet unclassified' }
PreguntaCommon >> consultarUsuario: unUsuario [
	| view |
	view := UserConsultaComponent usuario: unUsuario.
	self call: view
]

{ #category : #'as yet unclassified' }
PreguntaCommon >> infoPreguntas: aPregunta on: aCanvas [
	aCanvas listItem
		with: [ aCanvas anchor
				callback: [ self consultarPregunta: aPregunta ];
				with: [ aCanvas big: aPregunta titulo ].
			aCanvas break.
			aCanvas emphasis: aPregunta descripcion.
			aCanvas paragraph
				with: [ aCanvas small: 'Topicos: '.
					aPregunta topicos do: [ :t | aCanvas small: t nombre , ' ' ] ].
			aCanvas paragraph
				with: [ aCanvas text: 'Realizada por '.
					aCanvas anchor
						callback: [ self consultarUsuario: aPregunta usuario ];
						with: [ aCanvas text: aPregunta usuario userName ].
					aCanvas
						text:
							(''
								join:
									{' | '.
									aPregunta respuestas size.
									' respuestas'}).
					self likesYDislikes: aPregunta con: aCanvas ] ]
]

{ #category : #'as yet unclassified' }
PreguntaCommon >> likesYDislikes: aPublicacion con: aCanvas [
	aCanvas paragraph
		with: [ aCanvas text: aPublicacion likes size.
			aCanvas text: ' likes '.
			aCanvas anchor
				callback: [ aPublicacion darLike: self session user ];
				with: [ aCanvas text: '+' ].
			aCanvas text: ' | '.
			aCanvas text: aPublicacion dislikes size.
			aCanvas text: ' dislikes '.
			aCanvas anchor
				callback: [ aPublicacion darDislike: self session user ];
				with: [ aCanvas text: '+' ] ]
]
