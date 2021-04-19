Class {
	#name : #CuOOraHome,
	#superclass : #PreguntaCommon,
	#instVars : [
		'sistema'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'CuOOra-UI'
}

{ #category : #accessing }
CuOOraHome class >> initialize [
	"CuOOraHome initialize"

	| application cuoora juan diego pedro oo1 smalltalk tests t1 t2 p1 p2 |
	application := WAAdmin register: self asApplicationAt: #Cuoora.
	application preferenceAt: #sessionClass put: UserSistem.
	cuoora := Cuoora soleInstance.
	pedro := cuoora crearUsuario: 'pedro@cuoora.com' password: 'pedro@cuoora.com'.
	diego := cuoora crearUsuario: 'diego@cuoora.com' password: 'diego@cuoora.com'.
	juan := cuoora crearUsuario: 'juan@cuoora.com' password: 'juan@cuoora.com'.
	juan seguir: diego.
	pedro seguir: juan.
	oo1 := cuoora
		crearTopico: 'OO1'
		Descripcion: 'Preguntas relacionadas a la materia Objetos 1'.
	tests := cuoora
		crearTopico: 'Tests de unidad'
		Descripcion: 'Preguntas relacionadas a los tests de unidad (SUnit)'.
	smalltalk := cuoora
		crearTopico: 'SmallTalk'
		Descripcion: 'Preguntas relacionadas a el lenguaje de programacion smalltalk'.
	juan agregarTopicoFavorito: oo1.
	pedro agregarTopicoFavorito: smalltalk.
	diego agregarTopicoFavorito: tests .
	t1 := OrderedCollection new.
	t1 add: oo1.
	t1 add: tests.
	t2 := OrderedCollection new.
	t2 add: oo1.
	t2 add: smalltalk.
	p1 := Pregunta
		newQuestionWith: 'Para que sirve el metodo SetUp?'
		and: 'Cualquier informacion al respecto'
		from: pedro
		for: t1.
		pedro agregarPregunta: p1.
	p2 := Pregunta
		newQuestionWith: 'Que significa #messageNotUnderstood' 
		and: 'Me aparecio al tratar de llamar a un metodo propio en mi clase' 
		from: diego
		for: t2.
		diego agregarPregunta: p2.
	diego 
	crearRespuesta: 'Sirve para instancia los objetos que son evaluados por el test en un unico metodo y que se ejecute siempre antes de cada test' 
	para: 	p1.
	
	pedro crearRespuesta: 'Significa que el objetos que recibio el mensaje no encontro ningun metodo para ejecutar en respuesta' para: p2.
]

{ #category : #'as yet unclassified' }
CuOOraHome >> agregarTopicoFavorito [
	| temp |
	temp := TopicUserEditor topicos: sistema topicos.
	self call: temp.
	temp topicoSelected ifTrue:
		[self session user agregarTopicoFavorito: temp topicos].

]

{ #category : #'as yet unclassified' }
CuOOraHome >> crearPregunta [
	| editor |
	editor := PreguntaEditorComponente
		topico: sistema topicos
		usuario: self session user.
	self call: editor.
	(editor newTitulo isNil not and: editor newDescripcion isNil not)
		ifTrue: 
		[editor usuario crearPregunta: 
			editor newTitulo con: editor newDescripcion y: editor topicos ].
		
]

{ #category : #'as yet unclassified' }
CuOOraHome >> crearRespuesta: unaPregunta [
	| editor |
	editor := RespuestaEditorComponente newConPregunta: unaPregunta.
	self call: editor.
	editor newTexto
	ifNotNil: [self session user crearRespuesta: editor newTexto para: unaPregunta].
]

{ #category : #'as yet unclassified' }
CuOOraHome >> initialize [
	super initialize.
	sistema := Cuoora soleInstance.
]

{ #category : #'as yet unclassified' }
CuOOraHome >> login [
	| log |
	log := UserManejoComponente new.
	self call: log.
	log inUser ifNotNil: [ self session login: log loggedInUser ]
]

{ #category : #'as yet unclassified' }
CuOOraHome >> loginScreen: aCanvas [
	aCanvas break.
	aCanvas anchor
		callback: [ self login ];
		with: [ aCanvas button: 'Login' ].
	aCanvas space.
	aCanvas anchor
		callback: [ self newUser ];
		with: [ aCanvas button: 'Crear Usuario' ].
	aCanvas space.
	aCanvas anchor
		callback: [ self newTopic ];
		with: [ aCanvas button: 'Crear Topico' ]
]

{ #category : #'as yet unclassified' }
CuOOraHome >> newTopic [
	| editor |
	editor := TopicEditorComponente topico: Topico new.
	self call: editor.
	(editor topico isNil not and: editor newNombreTopico isNotEmpty)
		ifTrue: [ sistema agregarTopico: editor topico ]
]

{ #category : #'as yet unclassified' }
CuOOraHome >> newUser [
	| editor |
	editor := UserEditorComponente user: Usuario new.
	self call: editor.
	editor usuario ifNotNil: [ sistema agregarUsuarioAUsuarios: editor usuario ]
]

{ #category : #'as yet unclassified' }
CuOOraHome >> preguntas: aCanvas [
	| pRelevantes |
	pRelevantes := sistema preguntasRelevantesPara: self session user.
	aCanvas heading level2 with: 'Ultimas preguntas'.
	pRelevantes isEmpty
		ifTrue: [ aCanvas paragraph: 'No hay preguntas relevantes.' ]
		ifFalse: [ pRelevantes size <= 5
				ifTrue: [ aCanvas
						unorderedList: [ pRelevantes do: [ :each | self infoPreguntas: each on: aCanvas ] ] ]
				ifFalse: [ aCanvas
						unorderedList: [ (pRelevantes first: 5) do: [ :each | self infoPreguntas: each on: aCanvas ] ] ] ].
	aCanvas anchor
		callback: [ self crearPregunta ];
		with: [ aCanvas button: 'Crear Pregunta' ]
]

{ #category : #'as yet unclassified' }
CuOOraHome >> renderContentOn: aCanvas [
	self header: aCanvas session: self session.
	self session isLoggedIn
		ifFalse: [ self loginScreen: aCanvas.
			^ self ].
	self preguntas: aCanvas.
	self topicosFavoritos: aCanvas
]

{ #category : #'as yet unclassified' }
CuOOraHome >> topicosFavoritos: aCanvas [
	aCanvas horizontalRule.
	aCanvas heading level2 with: 'Mis topicos favoritos'.
	self session user topicosFavoritos isEmpty
		ifTrue: [ aCanvas paragraph: 'No hay topicos favoritos.' ]
		ifFalse: [ aCanvas
				unorderedList: [ self session user topicosFavoritos
						do: [ :each | 
							aCanvas listItem
								with: [ aCanvas
										paragraph:
											(''
												join:
													{each nombre.
													': '.
													each descripcion}) ] ] ] ].
	aCanvas anchor
		callback: [ self agregarTopicoFavorito ];
		with: [ aCanvas button: 'Agregar Topico Favorito' ]
]
