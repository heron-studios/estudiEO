import 'package:learn/models/question.dart';

final List<Question> oracionGramaticalQuestions = [
  // Nivel Fácil - Pregunta 1
  Question(
    id: 'ora_gram_q1',
    topicId: 'eo_pnp_oracion_gramatical_01',
    text: r'''Tomando en cuenta la normativa para hallar el sujeto de una oración mediante la concordancia, ¿cuál es el sujeto en la oración "Me gustan las asignaturas de matemáticas"?''',
    options: [
      r'''Me''',
      r'''las asignaturas de matemáticas''',
      r'''gustan''',
      r'''me gustan''',
      r'''de matemáticas''',
    ],
    correctAnswer: 1,
    explanation: r'''Para reconocer el sujeto debemos realizar al verbo la pregunta ¿qué? o ¿quiénes?. Al preguntar "¿qué me gustan?", la respuesta es "las asignaturas de matemáticas". Además, si cambiamos el verbo a singular ("gusta"), obligatoriamente cambia el sujeto ("la asignatura"), lo que comprueba la concordancia.''',
  ),

  // Nivel Fácil - Pregunta 2
  Question(
    id: 'ora_gram_q2',
    topicId: 'eo_pnp_oracion_gramatical_01',
    text: r'''Según la estructura sintáctica, ¿qué alternativa representa una oración unimembre típica en los exámenes de admisión?''',
    options: [
      r'''Si estudias, triunfarás.''',
      r'''Estudio en la Escuela de Oficiales.''',
      r'''El clima nublado es mi favorito.''',
      r'''¡Villarreal! ¡Villarreal!''',
      r'''¿Dónde estudias?''',
    ],
    correctAnswer: 3,
    explanation: r'''Las oraciones unimembres son las que cuentan con un solo miembro, ya que no es posible dividirlas lógicamente en sujeto y predicado. Las interjecciones u onomatopeyas (como ¡Villarreal! ¡Villarreal! o ¡Ay!) funcionan como oraciones unimembres de sentido completo.''',
  ),

  // Nivel Medio - Pregunta 1
  Question(
    id: 'ora_gram_q3',
    topicId: 'eo_pnp_oracion_gramatical_01',
    text: r'''En la comunicación diaria, la modalidad oracional revela la intención del emisor. ¿Qué tipo de oración, según la actitud del hablante, es "Ojalá apruebe el examen de admisión mañana"?''',
    options: [
      r'''Imperativa''',
      r'''Enunciativa''',
      r'''Desiderativa''',
      r'''Dubitativa''',
      r'''Exclamativa''',
    ],
    correctAnswer: 2,
    explanation: r'''Las oraciones desiderativas manifiestan explícitamente un deseo del hablante. La presencia del término "ojalá" siempre indica el deseo de que un hecho ocurra, descartando la duda (dubitativa) o la orden (imperativa).''',
  ),

  // Nivel Medio - Pregunta 2
  Question(
    id: 'ora_gram_q4',
    topicId: 'eo_pnp_oracion_gramatical_01',
    text: r'''Identifique a qué clase, según la actitud del emisor, pertenece la siguiente oración: "Debe de tener cuidado con el arma de reglamento durante la guardia".''',
    options: [
      r'''Interrogativa indirecta''',
      r'''Dubitativa''',
      r'''Imperativa o exhortativa''',
      r'''Desiderativa''',
      r'''Enunciativa afirmativa''',
    ],
    correctAnswer: 1,
    explanation: r'''Aunque parece dar una indicación, la estructura "deber de + infinitivo" (ej. Debes de tener el pelo ardiendo o debe de tener cuidado) expresa gramaticalmente una duda, suposición o probabilidad por parte del hablante, lo que la clasifica estrictamente como una oración dubitativa. (Nota: "deber + infinitivo" sin "de" expresa obligación/imperativa).''',
  ),

  // Nivel Difícil - Pregunta 1
  Question(
    id: 'ora_gram_q5',
    topicId: 'eo_pnp_oracion_gramatical_01',
    text: r'''Lea atentamente la siguiente oración: "El valiente oficial de tránsito, mi instructor, detuvo al delincuente". ¿Qué función sintáctica exacta cumple la estructura "mi instructor" dentro del sujeto?''',
    options: [
      r'''Núcleo del sujeto''',
      r'''Modificador directo''',
      r'''Modificador indirecto''',
      r'''Objeto directo''',
      r'''Aposición''',
    ],
    correctAnswer: 4,
    explanation: r'''Toda frase nominal que va entre comas dentro del sujeto y que sirve para explicar, detallar o repetir quién es exactamente el núcleo (en este caso, oficial = mi instructor), cumple la función de Aposición explicativa.''',
  ),

  // Nivel Difícil - Pregunta 2
  Question(
    id: 'ora_gram_q6',
    topicId: 'eo_pnp_oracion_gramatical_01',
    text: r'''Analice sintácticamente la oración: "El ataque a Libia fue duramente condenado por todos los parlamentarios". Seleccione la clasificación correcta y completa que le corresponde al sujeto de dicha oración.''',
    options: [
      r'''Simple - activo - complejo''',
      r'''Simple - pasivo - complejo''',
      r'''Compuesto - pasivo - complejo''',
      r'''Simple - pasivo - incomplejo''',
      r'''Compuesto - activo - incomplejo''',
    ],
    correctAnswer: 1,
    explanation: r'''El sujeto es "El ataque a Libia". Es Simple porque tiene un solo núcleo ("ataque"); es Pasivo porque la oración está en voz pasiva y el sujeto recibe la acción ("fue condenado"); y es Complejo porque posee modificadores que lo acompañan (el MD "El" y el MI "a Libia").''',
  ),

  // Nivel Extremo - Pregunta 1
  Question(
    id: 'ora_gram_q7',
    topicId: 'eo_pnp_oracion_gramatical_01',
    text: r'''En la oración "Inés compró chocolates para su enamorado el día sábado", determine qué función sintáctica exacta cumple la estructura "para su enamorado".''',
    options: [
      r'''Objeto directo''',
      r'''Circunstancial de finalidad''',
      r'''Atributo''',
      r'''Objeto indirecto''',
      r'''Complemento agente''',
    ],
    correctAnswer: 3,
    explanation: r'''El objeto indirecto señala al beneficiario o destinatario de la acción verbal. Se reconoce preguntando "¿para quién compró (los chocolates)?" y su prueba absoluta es la sustitución por el pronombre "le": Inés le compró chocolates el día sábado.''',
  ),

  // Nivel Extremo - Pregunta 2
  Question(
    id: 'ora_gram_q8',
    topicId: 'eo_pnp_oracion_gramatical_01',
    text: r'''Identifique el elemento sintáctico denominado "Complemento Agente" dentro de la siguiente oración de estructura compleja: "El cobarde atentado, que dejó grandes pérdidas, fue condenado por la opinión pública".''',
    options: [
      r'''El cobarde atentado.''',
      r'''fue condenado.''',
      r'''que dejó grandes pérdidas.''',
      r'''por la opinión pública.''',
      r'''grandes pérdidas.''',
    ],
    correctAnswer: 3,
    explanation: r'''El complemento agente solo existe en oraciones en voz pasiva y señala a quien ejecuta verdaderamente la acción verbal sobre el sujeto paciente ("El cobarde atentado"). Se caracteriza estructuralmente por estar precedido de manera obligatoria por la preposición "por", en este caso, "por la opinión pública".''',
  ),
];