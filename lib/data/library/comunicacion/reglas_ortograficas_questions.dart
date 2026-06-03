import 'package:learn/models/question.dart';

final List<Question> reglasOrtograficasQuestions = [
  // Nivel Fácil - Pregunta 1
  Question(
    id: 'ort_rae_q1',
    topicId: 'eo_pnp_reglas_ortograficas_01',
    text: r'''Según las reglas generales de acentuación y ortografía, ¿cuál de las siguientes opciones presenta una palabra correctamente escrita y que constituye una excepción a la regla de los verbos terminados en "-bir"?''',
    options: [
      r'''Prohivir''',
      r'''Hervir''',
      r'''Sucumbir''',
      r'''Percivir''',
      r'''Concebir''',
    ],
    correctAnswer: 1,
    explanation: r'''La regla ortográfica indica que los verbos terminados en "-bir" se escriben con "b" (como concebir, sucumbir, recibir), siendo las únicas tres excepciones en el español los verbos "hervir", "servir" y "vivir".''',
  ),

  // Nivel Fácil - Pregunta 2
  Question(
    id: 'ort_rae_q2',
    topicId: 'eo_pnp_reglas_ortograficas_01',
    text: r'''De acuerdo con la normativa vigente de la RAE respecto al alfabeto español, ¿cuál es la afirmación correcta?''',
    options: [
      r'''El abecedario consta de 29 letras, incluyendo la "ch" y la "ll".''',
      r'''La letra "y" debe denominarse oficialmente "y griega".''',
      r'''El abecedario español actual está conformado únicamente por 27 letras, excluyendo los dígrafos "ch" y "ll".''',
      r'''Las mayúsculas están exentas de llevar tilde ortográfica en documentos oficiales.''',
      r'''La letra "v" debe denominarse obligatoriamente "ve corta".''',
    ],
    correctAnswer: 2,
    explanation: r'''En 2010, la RAE eliminó oficialmente la "ch" y la "ll" del alfabeto al considerarlos dígrafos (conjunto de dos letras que representan un solo fonema), reduciendo el abecedario a 27 letras. Además, las mayúsculas siempre se tildan y la "y" se denomina "ye".''',
  ),

  // Nivel Medio - Pregunta 1
  Question(
    id: 'ort_rae_q3',
    topicId: 'eo_pnp_reglas_ortograficas_01',
    text: r'''Identifique la oración que presenta un uso correcto de la tilde diacrítica según las normas vigentes de la RAE.''',
    options: [
      r'''El té te lo sirvió él a tí en la mañana.''',
      r'''Él te dio el té a ti para que te relajes.''',
      r'''El te dió el té a ti rápidamente.''',
      r'''Tú hermano me dijo que sí vendría hoy.''',
      r'''Quiero mas azúcar en mi café, mas no hay.''',
    ],
    correctAnswer: 1,
    explanation: r'''"Él" (pronombre) y "té" (bebida) llevan tilde diacrítica, mientras que los pronombres átonos "te" y "ti" nunca llevan tilde. "Dio" es un monosílabo que jamás se tilda.''',
  ),

  // Nivel Medio - Pregunta 2
  Question(
    id: 'ort_rae_q4',
    topicId: 'eo_pnp_reglas_ortograficas_01',
    text: r'''¿En qué oración se ha aplicado correctamente la normativa de la RAE respecto a la conjunción "o" y los adverbios de tiempo/inclusión?''',
    options: [
      r'''Asistieron a la reunión 20 ó 30 oficiales de la policía.''',
      r'''Aun no se han publicado los resultados del examen de admisión.''',
      r'''Aún los postulantes lesionados decidieron continuar con la prueba.''',
      r'''Se incautaron 5 o 6 cajas, pero aún faltan revisar los almacenes.''',
      r'''El cadete dijo que sólo asistirían 4 ó 5 personas al evento.''',
    ],
    correctAnswer: 3,
    explanation: r'''La conjunción "o" entre números ya no lleva tilde (5 o 6). "Aún" lleva tilde porque equivale a "todavía". Las opciones B y C confunden los usos de "aún/aun".''',
  ),

  // Nivel Difícil - Pregunta 1
  Question(
    id: 'ort_rae_q5',
    topicId: 'eo_pnp_reglas_ortograficas_01',
    text: r'''Basándose en las reformas ortográficas de la RAE de 2010 respecto al uso de prefijos y acentuación, señale la oración correcta.''',
    options: [
      r'''El ex-comandante afirmó que aquél oficial actuó sólo por instinto.''',
      r'''El ex primer ministro declaró que este documento es confidencial.''',
      r'''El ex presidente llegó rápidamente al lugar de los hechos.''',
      r'''Sólo tú conoces el verdadero motivo por el cual renunció el ex-director.''',
      r'''Ése cadete resolvió el examen muy agilmente.''',
    ],
    correctAnswer: 1,
    explanation: r'''El prefijo "ex" se escribe separado porque la base léxica es pluriverbal ("primer ministro"). "Este" (demostrativo) no lleva tilde por norma general. La A, C y D fallan en la escritura del prefijo "ex" o en la tildación injustificada de "sólo" y "aquél/ése".''',
  ),

  // Nivel Difícil - Pregunta 2
  Question(
    id: 'ort_rae_q6',
    topicId: 'eo_pnp_reglas_ortograficas_01',
    text: r'''Identifique la oración que emplea correctamente la normativa sobre palabras terminadas en "-mente" y monosílabos.''',
    options: [
      r'''El oficial se acercó sigilosamente, vió al sospechoso y actuó rapidamente.''',
      r'''Ella resolvió el enigma hábilmente y le dió la respuesta al instructor.''',
      r'''Entró sutilmente a la habitación, mas no encontró evidencia alguna.''',
      r'''Felizmente, el ex-ministro logró escapar ileso del atentado.''',
      r'''Él actuó cortésmente y fué reconocido por todos sus superiores.''',
    ],
    correctAnswer: 2,
    explanation: r'''"Sutilmente" no lleva tilde porque "sutil" no la lleva (aguda terminada en l). "Mas" está correctamente usado sin tilde al equivaler a "pero". Las otras opciones fallan al tildar monosílabos que nunca se tildan ("vió", "dió", "fué") o fallan en las reglas de "-mente" (rápidamente sí lleva) o el prefijo "ex-".''',
  ),

  // Nivel Extremo - Pregunta 1
  Question(
    id: 'ort_rae_q7',
    topicId: 'eo_pnp_reglas_ortograficas_01',
    text: r'''Considere las reglas de acentuación en palabras terminadas en doble consonante y en monosílabos con diptongos ortográficos. ¿Qué oración está escrita con impecable rigor ortográfico según la RAE?''',
    options: [
      r'''El joven cadete desarrolló gran fuerza en sus bíceps tras usar aquellos robots de entrenamiento.''',
      r'''El truhán elaboró un guión espectacular, pero los actores no quisieron ensayar.''',
      r'''Los robots limpiadores recogieron los cómics que estaban tirados en el suelo, y el jóven los guardó.''',
      r'''Hubo una explosión y un ión cargado generó interferencia en la radio.''',
      r'''El médico utilizó los fórceps hábilmente y el paciente vió la luz del día.''',
    ],
    correctAnswer: 0,
    explanation: r""""Bíceps" se tilda porque es grave terminada en 's' precedida de consonante. "Robots" no se tilda porque es aguda terminada en 's' precedida de consonante. La opción B y D tildan "truhán", "guión" e "ión", lo cual es incorrecto porque son monosílabos. La opción C tilda incorrectamente "jóven" (palabra grave terminada en 'n' no se tilda). La E tilda el monosílabo "vió".""",
  ),

  // Nivel Extremo - Pregunta 2
  Question(
    id: 'ort_rae_q8',
    topicId: 'eo_pnp_reglas_ortograficas_01',
    text: r'''Con base en la tildación de palabras con pronombres enclíticos y las actualizaciones normativas de la RAE, indique la oración que presenta correcta escritura.''',
    options: [
      r'''Llevatelo rápido antes de que el ex-general pida el informe final de la operación.''',
      r'''Entrégaselo a primera hora; el examen físico solo lo evaluarán hoy.''',
      r'''Cómetelo todo, mas no olvides dejar el guion sobre la mesa del comedor.''',
      r'''Dáselo a el para que comprenda el porqué de la decisión del tribunal.''',
      r'''Devuelveselo a su dueño; aquél hombre no sabía las reglas del juego.''',
    ],
    correctAnswer: 2,
    explanation: r'''"Cómetelo" es sobresdrújula y siempre se tilda. "Mas" equivale a "pero" (sin tilde). "Guion" es monosílabo ortográfico y no lleva tilde. La A falla en "Llevatelo" (falta tilde: Llévatelo) y en el guion de "ex-general". La B falla en "Entrégaselo" (falta tilde). La D falla en no tildar "él" (pronombre). La E falla en "Devuelveselo" (falta tilde: Devuélveselo) y tilda incorrectamente "aquél".''',
  ),
];