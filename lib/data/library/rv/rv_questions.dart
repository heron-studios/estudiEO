import 'package:learn/models/question.dart';
import 'sinonimos_ext_10q_questions.dart';
import 'antonimos_ext_10q_questions.dart';

final List<Question> razonamientoVerbalQuestions = [
  ...sinonimosExt10qQuestions,
  ...antonimosExt10qQuestions,
  Question(
    id: 'rv_q1',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinónimo exacto de la premisa:
PROLIJO''',
    options: [
      r'''Abundancia''',
      r'''Extenso''',
      r'''Cuidado''',
      r'''Minucioso''',
    ],
    correctAnswer: 3,
    explanation:
        r"""D es correcta (adjetivo equivalente). C (Cuidado) y A (Abundancia) son 'Transgresiones Morfológicas' por ser sustantivos. B (Extenso) es una 'Asociación Contextual Errónea'.""",
  ),
  Question(
    id: 'rv_q2',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinónimo exacto de la premisa:
INCÓLUME''',
    options: [r'''Sanar''', r'''Ileso''', r'''Herida''', r'''Invulnerable'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. A (Sanar) es transgresión morfológica (verbo). D (Invulnerable) es asociación errónea (que no puede ser herido, distinto a incólume: que no ha recibido daño).''',
  ),
  Question(
    id: 'rv_q3',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinónimo exacto de la premisa:
ABJURAR''',
    options: [
      r'''Renuncia''',
      r'''Juramento''',
      r'''Retractarse''',
      r'''Absolver''',
    ],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. A (Renuncia) transgrede la categoría gramatical. D (Absolver) es paronimia o falso amigo fonético.''',
  ),
  Question(
    id: 'rv_q4',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinónimo exacto de la premisa:
HOSTIL''',
    options: [r'''Enemistad''', r'''Adverso''', r'''Bélico''', r'''Amistoso'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. A (Enemistad) es un sustantivo (transgresión morfológica). C (Bélico) es asociación contextual exagerada. D es oposición polar.''',
  ),
  Question(
    id: 'rv_q5',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinónimo exacto de la premisa:
INHERENTE''',
    options: [
      r'''Intrínseco''',
      r'''Adherencia''',
      r'''Propio''',
      r'''Externo''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. B (Adherencia) es transgresión de categoría gramatical. C (Propio) es sinónimo relativo pero menos exacto gramaticalmente.''',
  ),
  Question(
    id: 'rv_q6',
    topicId: 'rv_sinonimos',
    text:
        r'''El perfume de las flores silvestres inundaba el campo, desprendiendo una suave y agradable _______ que deleitaba a los caminantes.''',
    options: [
      r'''fragancia''',
      r'''pestilencia''',
      r'''emanación''',
      r'''corrupción''',
    ],
    correctAnswer: 0,
    explanation:
        r"""El contexto describe un olor agradable provocado por flores, por lo que 'fragancia' es la palabra con el matiz preciso. 'Emanación' es neutra y 'pestilencia' denota mal olor.""",
  ),
  Question(
    id: 'rv_q7',
    topicId: 'rv_sinonimos',
    text:
        r'''El testigo presentó un informe _______, que merecía plena confianza y crédito por estar respaldado por pruebas irrefutables.''',
    options: [
      r'''verosímil''',
      r'''fidedigno''',
      r'''auténtico''',
      r'''tangible''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Fidedigno' califica la información o testimonio que es digno de fe y crédito. Aunque 'verosímil' indica apariencia de verdad, 'fidedigno' asegura que el crédito es merecido.""",
  ),
  Question(
    id: 'rv_q8',
    topicId: 'rv_sinonimos',
    text:
        r'''Decidieron _______ los planos originales de la casa para añadir una habitación, realizando pequeños cambios sin perder la estructura base.''',
    options: [
      r'''transformar''',
      r'''alterar''',
      r'''modificar''',
      r'''trastocar''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Modificar' significa variar parcialmente algo sin alterar su naturaleza o esencia. 'Transformar' se refiere a un cambio de forma más profundo y 'alterar' tiene matiz negativo.""",
  ),
  Question(
    id: 'rv_q9',
    topicId: 'rv_sinonimos',
    text:
        r'''Su gran _______ para las matemáticas le permitió resolver el complejo problema geométrico en pocos minutos.''',
    options: [
      r'''actitud''',
      r'''aptitud''',
      r'''talante''',
      r'''disposición''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Aptitud' es la capacidad o idoneidad para realizar una actividad de forma competente, a diferencia de 'actitud', que es la postura o ánimo frente a una situación.""",
  ),
  Question(
    id: 'rv_q10',
    topicId: 'rv_sinonimos',
    text:
        r'''El discurso del director fue _______; aunque duró pocos minutos, contuvo toda la información esencial de forma clara y directa.''',
    options: [r'''efímero''', r'''fugaz''', r'''corto''', r'''conciso'''],
    correctAnswer: 3,
    explanation:
        r"""'Conciso' describe aquello que es breve pero exacto y con el contenido preciso. 'Corto' solo hace referencia a la duración del tiempo, no a la densidad del mensaje.""",
  ),
  Question(
    id: 'rv_q11',
    topicId: 'rv_sinonimos',
    text:
        r'''Aquella persona que carece de lo necesario para el sustento diario se encuentra en una situación de _______ extrema.''',
    options: [
      r'''indigencia''',
      r'''modestia''',
      r'''austeridad''',
      r'''sencillez''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'Indigencia' es la carencia absoluta de recursos para alimentarse y vestirse. 'Modestia' o 'austeridad' implican moderación voluntaria, no privación forzada.""",
  ),
  Question(
    id: 'rv_q12',
    topicId: 'rv_sinonimos',
    text:
        r'''Habiendo heredado una gran fortuna, se dedicó a _______ su dinero en lujos innecesarios y fiestas costosas hasta quedar en la ruina.''',
    options: [
      r'''gastar''',
      r'''dilapidar''',
      r'''distribuir''',
      r'''financiar''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Dilapidar' denota malgastar los bienes propios de forma descontrolada e insensata, mientras que 'gastar' es un verbo neutro que no implica despilfarro dañino.""",
  ),
  Question(
    id: 'rv_q13',
    topicId: 'rv_sinonimos',
    text:
        r'''La ceremonia de graduación tuvo un carácter _______, marcado por la formalidad, el protocolo y la alta investidura de las autoridades presentes.''',
    options: [r'''severo''', r'''solemne''', r'''trágico''', r'''funesto'''],
    correctAnswer: 1,
    explanation:
        r"""'Solemne' califica a los actos acompañados de requisitos formales excepcionales y dignidad. 'Severo' denota excesivo rigor o seriedad adusta.""",
  ),
  Question(
    id: 'rv_q14',
    topicId: 'rv_sinonimos',
    text:
        r'''Desde niño sentía una profunda _______ por los insectos, lo que le provocaba un rechazo inmediato y la necesidad de alejarse rápidamente de ellos.''',
    options: [
      r'''antipatía''',
      r'''aversión''',
      r'''hostilidad''',
      r'''rencor''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Aversión' expresa una repugnancia o rechazo visceral contra algo físico o abstracto. 'Antipatía' es menos intensa y suele aplicarse al trato social.""",
  ),
  Question(
    id: 'rv_q15',
    topicId: 'rv_sinonimos',
    text:
        r'''El náufrago elevó una desesperada _______ al cielo, implorando con humildad y fervor que alguien acudiera en su rescate.''',
    options: [
      r'''demanda''',
      r'''exigencia''',
      r'''súplica''',
      r'''interpelación''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Súplica' es un ruego cargado de sumisión y humildad. Es la expresión precisa ante una súplica desesperada, muy diferente de la imposición de una 'demanda'.""",
  ),
  Question(
    id: 'rv_q16',
    topicId: 'rv_sinonimos',
    text:
        r'''Las autoridades sanitarias implementaron campañas intensivas con el objetivo de _______ definitivamente la malaria de la región, y no solo disminuir sus casos.''',
    options: [r'''atenuar''', r'''mitigar''', r'''paliar''', r'''erradicar'''],
    correctAnswer: 3,
    explanation:
        r"""'Erradicar' significa arrancar de raíz o eliminar completamente un mal. 'Mitigar', 'paliar' o 'atenuar' solo implican suavizar o moderar sus efectos.""",
  ),
  Question(
    id: 'rv_q17',
    topicId: 'rv_sinonimos',
    text:
        r'''En un Estado de derecho, es fundamental _______ las leyes vigentes, reconociendo su autoridad legítima y ajustando nuestra conducta a ellas voluntariamente.''',
    options: [
      r'''acatar''',
      r'''tolerar''',
      r'''sobrellevar''',
      r'''admitir''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'Acatar' implica aceptar voluntaria y respetuosamente la autoridad de una norma. 'Tolerar' significa soportar algo molesto, lo cual no califica la adhesión a la ley.""",
  ),
  Question(
    id: 'rv_q18',
    topicId: 'rv_sinonimos',
    text:
        r'''Sin decirlo directamente, el expositor dejó _______ que el proyecto carecía de viabilidad económica debido a sus altos costos ocultos.''',
    options: [
      r'''insinuar''',
      r'''exclamar''',
      r'''aseverar''',
      r'''promulgar''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'Insinuar' significa dar a entender algo de manera muy sutil e indirecta, cumpliendo con la premisa 'sin decirlo directamente'. 'Aseverar' es afirmar categóricamente.""",
  ),
  Question(
    id: 'rv_q19',
    topicId: 'rv_sinonimos',
    text:
        r'''El psicólogo logró _______ al joven de que abandonara su peligroso pasatiempo, logrando que comprendiera el riesgo que corría su vida.''',
    options: [
      r'''inducir''',
      r'''instigar''',
      r'''disuadir''',
      r'''compeler''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Disuadir' es inducir a alguien a desistir de un propósito o acción (abandonar). 'Inducir' o 'instigar' significan motivar a alguien a hacer algo.""",
  ),
  Question(
    id: 'rv_q20',
    topicId: 'rv_sinonimos',
    text:
        r'''A pesar de su avanzada edad, el abuelo se mantenía _______; su mente procesaba la información con asombrosa claridad y coherencia.''',
    options: [r'''perspicaz''', r'''lúcido''', r'''erudito''', r'''sagaz'''],
    correctAnswer: 1,
    explanation:
        r"""'Lúcido' define a quien mantiene las facultades mentales claras y despiertas. 'Erudito' se asocia al conocimiento acumulado y 'sagaz' a la astucia.""",
  ),
  Question(
    id: 'rv_q21',
    topicId: 'rv_sinonimos',
    text:
        r'''La propuesta del comité ambientalista resultó _______, pues presentaba soluciones realistas que podían ser implementadas con el presupuesto existente.''',
    options: [
      r'''plausible''',
      r'''utópica''',
      r'''quimérica''',
      r'''elogiable''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'Plausible' califica a la propuesta admisible y justificada por ser realizable. 'Utópica' o 'quimérica' significan ilusorias o imposibles.""",
  ),
  Question(
    id: 'rv_q22',
    topicId: 'rv_sinonimos',
    text:
        r'''El candidato desmintió el _______ publicado en la prensa, argumentando que la acusación de desvío de fondos era una invención malintencionada sin sustento.''',
    options: [r'''infundio''', r'''descuido''', r'''equívoco''', r'''lapsus'''],
    correctAnswer: 0,
    explanation:
        r"""Un 'infundio' es una mentira sin fundamento inventada con mala intención. 'Equívoco' y 'lapsus' son errores no maliciosos ni planificados.""",
  ),
  Question(
    id: 'rv_q23',
    topicId: 'rv_sinonimos',
    text:
        r'''El juez se mostró _______ ante el delito de corrupción, aplicando la máxima pena posible sin dejarse conmover por las disculpas del acusado.''',
    options: [
      r'''implacable''',
      r'''indulgente''',
      r'''tolerante''',
      r'''compasivo''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'Implacable' significa que no puede ser suavizado o perdonado, manteniendo firme el castigo. 'Indulgente' y 'compasivo' son sus antónimos directos.""",
  ),
  Question(
    id: 'rv_q24',
    topicId: 'rv_sinonimos',
    text:
        r'''El Congreso de la República decidió _______ el artículo de la ley tributaria que gravaba las exportaciones de productos agrícolas tradicionales.''',
    options: [r'''rescindir''', r'''derogar''', r'''abolir''', r'''revocar'''],
    correctAnswer: 1,
    explanation:
        r"""'Derogar' es abolir o anular una ley o parte de ella. 'Rescindir' se aplica a contratos o convenios y 'revocar' a mandatos o permisos.""",
  ),
  Question(
    id: 'rv_q25',
    topicId: 'rv_sinonimos',
    text:
        r'''El recepcionista del hotel fue muy _______, atendiendo de inmediato y de manera muy afable cada una de las solicitudes de los huéspedes.''',
    options: [
      r'''solícito''',
      r'''sumiso''',
      r'''condescendiente''',
      r'''obsequioso''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'Solícito' describe a quien actúa con presteza, diligencia y afabilidad. 'Sumiso' y 'obsequioso' implican un servilismo excesivo o subordinación.""",
  ),
  Question(
    id: 'rv_q26',
    topicId: 'rv_sinonimos',
    text:
        r'''El arquero cometió un grave _______ al soltar el balón en el último minuto del partido, lo que costó la derrota de su equipo.''',
    options: [r'''yerro''', r'''defecto''', r'''descuido''', r'''lapsus'''],
    correctAnswer: 0,
    explanation:
        r"""Un 'yerro' es un error o fallo cometido por descuido al realizar una acción práctica. Es más adecuado para la acción del juego que 'defecto' o 'lapsus'.""",
  ),
  Question(
    id: 'rv_q27',
    topicId: 'rv_sinonimos',
    text:
        r'''El coleccionista analizó la pintura para verificar que se tratara de un lienzo _______ del autor y no de una copia posterior de gran factura.''',
    options: [r'''genuino''', r'''fidedigno''', r'''verídico''', r'''legal'''],
    correctAnswer: 0,
    explanation:
        r"""'Genuino' se refiere a aquello que conserva su origen y autoría real sin ser falso. 'Fidedigno' califica testimonios veraces y 'verídico' hechos comprobables.""",
  ),
  Question(
    id: 'rv_q28',
    topicId: 'rv_sinonimos',
    text:
        r"""El uso de la expresión 'daños colaterales' para referirse a la muerte de civiles es un claro _______ utilizado para suavizar una dura realidad social.""",
    options: [
      r'''eufemismo''',
      r'''pleonasmo''',
      r'''neologismo''',
      r'''arcaísmo''',
    ],
    correctAnswer: 0,
    explanation:
        r"""Un 'eufemismo' es la manifestación de ideas con palabras decorosas para evitar la crudeza o dureza de la realidad. El 'pleonasmo' es una redundancia.""",
  ),
  Question(
    id: 'rv_q29',
    topicId: 'rv_sinonimos',
    text:
        r'''El conferencista prefirió _______ los temas espinosos que dividían al auditorio, centrándose exclusivamente en los puntos de acuerdo.''',
    options: [r'''eludir''', r'''esquivar''', r'''soslayar''', r'''omitir'''],
    correctAnswer: 2,
    explanation:
        r"""'Soslayar' significa pasar por alto una dificultad o tema delicado de forma elegante o disimulada. 'Eludir' tiene una connotación más tosca de evasión.""",
  ),
  Question(
    id: 'rv_q30',
    topicId: 'rv_sinonimos',
    text:
        r'''Su _______ le impidió asumir la defensa de sus compañeros ante la injusticia del jefe, demostrando una falta total de valor y firmeza de ánimo.''',
    options: [
      r'''abulia''',
      r'''pusilanimidad''',
      r'''apatía''',
      r'''displicencia''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Pusilanimidad' es la cobardía o la falta de ánimo y valor para enfrentar situaciones difíciles. 'Abulia' es la falta de voluntad o motivación.""",
  ),
  Question(
    id: 'rv_q31',
    topicId: 'rv_sinonimos',
    text:
        r'''La falta de consenso provocó una honda _______ entre los miembros de la junta directiva, dividiéndolos en dos bandos irreconciliables.''',
    options: [
      r'''divergencia''',
      r'''disensión''',
      r'''discusión''',
      r'''polémica''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Disensión' es la diferencia de opiniones que desemboca en contienda o división de un grupo. 'Divergencia' es la mera discrepancia sin ruptura.""",
  ),
  Question(
    id: 'rv_q32',
    topicId: 'rv_sinonimos',
    text:
        r'''Tras cancelar todas las deudas del mes, la empresa destinó el _______ financiero a la cuenta de ahorros para contingencias futuras.''',
    options: [
      r'''remanente''',
      r'''residuo''',
      r'''desecho''',
      r'''superávit''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'Remanente' es lo sobrante de una cantidad monetaria tras cubrir los gastos. 'Residuo' y 'desecho' se usan para despojos materiales inútiles.""",
  ),
  Question(
    id: 'rv_q33',
    topicId: 'rv_sinonimos',
    text:
        r'''El crítico literario no escatimó palabras para _______ públicamente la nueva novela del autor, tachándola de plagiaria y de nulo valor artístico.''',
    options: [
      r'''vituperar''',
      r'''amonestar''',
      r'''apercibir''',
      r'''reprochar''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'Vituperar' significa desaprobar o censurar severamente y de forma pública a alguien o algo. Es más severo e insultante que 'reprochar'.""",
  ),
  Question(
    id: 'rv_q34',
    topicId: 'rv_sinonimos',
    text:
        r'''El informe era de carácter _______; presentaba de forma gráfica y panorámica los datos esenciales de la investigación para su rápida comprensión.''',
    options: [r'''sucinto''', r'''sinóptico''', r'''reducido''', r'''breve'''],
    correctAnswer: 1,
    explanation:
        r"""'Sinóptico' se refiere a la presentación gráfica y general que permite ver las partes de un conjunto de un vistazo. 'Sucinto' es breve pero en redacción.""",
  ),
  Question(
    id: 'rv_q35',
    topicId: 'rv_sinonimos',
    text:
        r'''La inhalación continua de gases de combustión interna tiene un efecto _______ en las células pulmonares, destruyendo los tejidos de forma silenciosa y letal.''',
    options: [
      r'''perjudicial''',
      r'''deletéreo''',
      r'''contraproducente''',
      r'''desfavorable''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Deletéreo' es el término científico para sustancias venenosas o mortíferas para los seres vivos, lo que encaja con la destrucción letal de tejidos.""",
  ),
  Question(
    id: 'rv_q36',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ABATIDO''',
    options: [r'''Desalentado''', r'''Altivo''', r'''Inmune''', r'''Veloz'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Desalentado" conserva la relacion lexical solicitada para "ABATIDO".''',
  ),
  Question(
    id: 'rv_q37',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ABOLIR''',
    options: [r'''Promulgar''', r'''Derogar''', r'''Afirmar''', r'''Omitir'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Derogar" conserva la relacion lexical solicitada para "ABOLIR".''',
  ),
  Question(
    id: 'rv_q38',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ABRUPTO''',
    options: [r'''Liso''', r'''Tardio''', r'''Escarpado''', r'''Docil'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Escarpado" conserva la relacion lexical solicitada para "ABRUPTO".''',
  ),
  Question(
    id: 'rv_q39',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ACERBO''',
    options: [r'''Dulce''', r'''Breve''', r'''Calido''', r'''Aspero'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Aspero" conserva la relacion lexical solicitada para "ACERBO".''',
  ),
  Question(
    id: 'rv_q40',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ACUCIOSO''',
    options: [
      r'''Diligente''',
      r'''Negligente''',
      r'''Confuso''',
      r'''Efimero''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Diligente" conserva la relacion lexical solicitada para "ACUCIOSO".''',
  ),
  Question(
    id: 'rv_q41',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ADUSTO''',
    options: [r'''Jovial''', r'''Severo''', r'''Fragil''', r'''Remoto'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Severo" conserva la relacion lexical solicitada para "ADUSTO".''',
  ),
  Question(
    id: 'rv_q42',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
AFABLE''',
    options: [r'''Arido''', r'''Tosco''', r'''Cordial''', r'''Incierto'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Cordial" conserva la relacion lexical solicitada para "AFABLE".''',
  ),
  Question(
    id: 'rv_q43',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ALTRUISTA''',
    options: [
      r'''Egoista''',
      r'''Taciturno''',
      r'''Parcial''',
      r'''Generoso''',
    ],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Generoso" conserva la relacion lexical solicitada para "ALTRUISTA".''',
  ),
  Question(
    id: 'rv_q44',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ANACRONICO''',
    options: [
      r'''Extemporaneo''',
      r'''Vigente''',
      r'''Exacto''',
      r'''Proximo''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Extemporaneo" conserva la relacion lexical solicitada para "ANACRONICO".''',
  ),
  Question(
    id: 'rv_q45',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ANODINO''',
    options: [
      r'''Relevante''',
      r'''Insustancial''',
      r'''Hostil''',
      r'''Fecundo''',
    ],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Insustancial" conserva la relacion lexical solicitada para "ANODINO".''',
  ),
  Question(
    id: 'rv_q46',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
APATICO''',
    options: [
      r'''Entusiasta''',
      r'''Sagaz''',
      r'''Indiferente''',
      r'''Perenne''',
    ],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Indiferente" conserva la relacion lexical solicitada para "APATICO".''',
  ),
  Question(
    id: 'rv_q47',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
APOCRIFO''',
    options: [r'''Autentico''', r'''Limpio''', r'''Rapido''', r'''Falso'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Falso" conserva la relacion lexical solicitada para "APOCRIFO".''',
  ),
  Question(
    id: 'rv_q48',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ARBITRARIO''',
    options: [r'''Caprichoso''', r'''Justo''', r'''Necesario''', r'''Pulcro'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Caprichoso" conserva la relacion lexical solicitada para "ARBITRARIO".''',
  ),
  Question(
    id: 'rv_q49',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ARCAICO''',
    options: [r'''Moderno''', r'''Antiguo''', r'''Audaz''', r'''Leve'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Antiguo" conserva la relacion lexical solicitada para "ARCAICO".''',
  ),
  Question(
    id: 'rv_q50',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ARDUO''',
    options: [r'''Sencillo''', r'''Hondo''', r'''Dificil''', r'''Fugaz'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Dificil" conserva la relacion lexical solicitada para "ARDUO".''',
  ),
  Question(
    id: 'rv_q51',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
AVIESO''',
    options: [r'''Recto''', r'''Suave''', r'''Cauto''', r'''Malintencionado'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Malintencionado" conserva la relacion lexical solicitada para "AVIESO".''',
  ),
  Question(
    id: 'rv_q52',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
AZAROSO''',
    options: [r'''Aleatorio''', r'''Seguro''', r'''Previsto''', r'''Manso'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Aleatorio" conserva la relacion lexical solicitada para "AZAROSO".''',
  ),
  Question(
    id: 'rv_q53',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
BELIGERANTE''',
    options: [r'''Pacifico''', r'''Combativo''', r'''Neutral''', r'''Tenue'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Combativo" conserva la relacion lexical solicitada para "BELIGERANTE".''',
  ),
  Question(
    id: 'rv_q54',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
BENEVOLENTE''',
    options: [r'''Cruel''', r'''Rigido''', r'''Bondadoso''', r'''Soberbio'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Bondadoso" conserva la relacion lexical solicitada para "BENEVOLENTE".''',
  ),
  Question(
    id: 'rv_q55',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
BIZARRO''',
    options: [r'''Extrano''', r'''Debil''', r'''Comun''', r'''Valiente'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Valiente" conserva la relacion lexical solicitada para "BIZARRO".''',
  ),
  Question(
    id: 'rv_q56',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
CAUTO''',
    options: [r'''Prudente''', r'''Temerario''', r'''Altivo''', r'''Sombrio'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Prudente" conserva la relacion lexical solicitada para "CAUTO".''',
  ),
  Question(
    id: 'rv_q57',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
CELERIDAD''',
    options: [r'''Lentitud''', r'''Rapidez''', r'''Silencio''', r'''Firmeza'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Rapidez" conserva la relacion lexical solicitada para "CELERIDAD".''',
  ),
  Question(
    id: 'rv_q58',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
CIRCUNSPECTO''',
    options: [
      r'''Impulsivo''',
      r'''Locuaz''',
      r'''Reservado''',
      r'''Ingenuo''',
    ],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Reservado" conserva la relacion lexical solicitada para "CIRCUNSPECTO".''',
  ),
  Question(
    id: 'rv_q59',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
COERCITIVO''',
    options: [
      r'''Voluntario''',
      r'''Amable''',
      r'''Debil''',
      r'''Impositivo''',
    ],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Impositivo" conserva la relacion lexical solicitada para "COERCITIVO".''',
  ),
  Question(
    id: 'rv_q60',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
COETANEO''',
    options: [
      r'''Contemporaneo''',
      r'''Posterior''',
      r'''Antiguo''',
      r'''Ajeno''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Contemporaneo" conserva la relacion lexical solicitada para "COETANEO".''',
  ),
  Question(
    id: 'rv_q61',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
CONCISO''',
    options: [r'''Extenso''', r'''Breve''', r'''Dudoso''', r'''Turbio'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Breve" conserva la relacion lexical solicitada para "CONCISO".''',
  ),
  Question(
    id: 'rv_q62',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
CONSUETUDINARIO''',
    options: [r'''Inusual''', r'''Legal''', r'''Habitual''', r'''Reciente'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Habitual" conserva la relacion lexical solicitada para "CONSUETUDINARIO".''',
  ),
  Question(
    id: 'rv_q63',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
CONVICTO''',
    options: [r'''Inocente''', r'''Libre''', r'''Tenaz''', r'''Culpable'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Culpable" conserva la relacion lexical solicitada para "CONVICTO".''',
  ),
  Question(
    id: 'rv_q64',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
DEFERENTE''',
    options: [
      r'''Respetuoso''',
      r'''Descortes''',
      r'''Ligero''',
      r'''Secreto''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Respetuoso" conserva la relacion lexical solicitada para "DEFERENTE".''',
  ),
  Question(
    id: 'rv_q65',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
DELEZNABLE''',
    options: [
      r'''Admirable''',
      r'''Despreciable''',
      r'''Solido''',
      r'''Fertil''',
    ],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Despreciable" conserva la relacion lexical solicitada para "DELEZNABLE".''',
  ),
  Question(
    id: 'rv_q66',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
DENUEDO''',
    options: [r'''Temor''', r'''Pereza''', r'''Valor''', r'''Ruido'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Valor" conserva la relacion lexical solicitada para "DENUEDO".''',
  ),
  Question(
    id: 'rv_q67',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
DILIGENTE''',
    options: [r'''Moroso''', r'''Inutil''', r'''Feroz''', r'''Cuidadoso'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Cuidadoso" conserva la relacion lexical solicitada para "DILIGENTE".''',
  ),
  Question(
    id: 'rv_q68',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
DISPLICENTE''',
    options: [r'''Desdenoso''', r'''Atento''', r'''Simple''', r'''Firme'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Desdenoso" conserva la relacion lexical solicitada para "DISPLICENTE".''',
  ),
  Question(
    id: 'rv_q69',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ECUANIME''',
    options: [r'''Parcial''', r'''Imparcial''', r'''Ansioso''', r'''Somero'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Imparcial" conserva la relacion lexical solicitada para "ECUANIME".''',
  ),
  Question(
    id: 'rv_q70',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
EFIMERO''',
    options: [
      r'''Duradero''',
      r'''Profundo''',
      r'''Pasajero''',
      r'''Cercano''',
    ],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Pasajero" conserva la relacion lexical solicitada para "EFIMERO".''',
  ),
  Question(
    id: 'rv_q71',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ELUDIR''',
    options: [r'''Afrontar''', r'''Unir''', r'''Ordenar''', r'''Evitar'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Evitar" conserva la relacion lexical solicitada para "ELUDIR".''',
  ),
  Question(
    id: 'rv_q72',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ENCOMIAR''',
    options: [r'''Elogiar''', r'''Criticar''', r'''Ocultar''', r'''Perder'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Elogiar" conserva la relacion lexical solicitada para "ENCOMIAR".''',
  ),
  Question(
    id: 'rv_q73',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ENERVAR''',
    options: [
      r'''Fortalecer''',
      r'''Debilitar''',
      r'''Calmar''',
      r'''Dividir''',
    ],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Debilitar" conserva la relacion lexical solicitada para "ENERVAR".''',
  ),
  Question(
    id: 'rv_q74',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ESOTERICO''',
    options: [r'''Evidente''', r'''Comun''', r'''Oculto''', r'''Externo'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Oculto" conserva la relacion lexical solicitada para "ESOTERICO".''',
  ),
  Question(
    id: 'rv_q75',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
ESPURIO''',
    options: [r'''Legitimo''', r'''Claro''', r'''Sano''', r'''Falso'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Falso" conserva la relacion lexical solicitada para "ESPURIO".''',
  ),
  Question(
    id: 'rv_q76',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
EXECRABLE''',
    options: [r'''Abominable''', r'''Loable''', r'''Comun''', r'''Fugaz'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Abominable" conserva la relacion lexical solicitada para "EXECRABLE".''',
  ),
  Question(
    id: 'rv_q77',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
EXIGUO''',
    options: [r'''Abundante''', r'''Escaso''', r'''Amplio''', r'''Intenso'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Escaso" conserva la relacion lexical solicitada para "EXIGUO".''',
  ),
  Question(
    id: 'rv_q78',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
EXIMIO''',
    options: [r'''Mediocre''', r'''Oculto''', r'''Ilustre''', r'''Reciente'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Ilustre" conserva la relacion lexical solicitada para "EXIMIO".''',
  ),
  Question(
    id: 'rv_q79',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
FACUNDO''',
    options: [r'''Taciturno''', r'''Breve''', r'''Tosco''', r'''Elocuente'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Elocuente" conserva la relacion lexical solicitada para "FACUNDO".''',
  ),
  Question(
    id: 'rv_q80',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
FALAZ''',
    options: [r'''Enganoso''', r'''Veraz''', r'''Sereno''', r'''Util'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Enganoso" conserva la relacion lexical solicitada para "FALAZ".''',
  ),
  Question(
    id: 'rv_q81',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
FATUO''',
    options: [r'''Humilde''', r'''Presuntuoso''', r'''Triste''', r'''Debil'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Presuntuoso" conserva la relacion lexical solicitada para "FATUO".''',
  ),
  Question(
    id: 'rv_q82',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
FECUNDO''',
    options: [r'''Esteril''', r'''Arido''', r'''Fertil''', r'''Ligero'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Fertil" conserva la relacion lexical solicitada para "FECUNDO".''',
  ),
  Question(
    id: 'rv_q83',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
FELONIA''',
    options: [r'''Lealtad''', r'''Perdon''', r'''Auxilio''', r'''Traicion'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Traicion" conserva la relacion lexical solicitada para "FELONIA".''',
  ),
  Question(
    id: 'rv_q84',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
FRUGAL''',
    options: [r'''Sobrio''', r'''Excesivo''', r'''Lujoso''', r'''Tardio'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Sobrio" conserva la relacion lexical solicitada para "FRUGAL".''',
  ),
  Question(
    id: 'rv_q85',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
FURTIVO''',
    options: [r'''Publico''', r'''Clandestino''', r'''Ruidoso''', r'''Lento'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Clandestino" conserva la relacion lexical solicitada para "FURTIVO".''',
  ),
  Question(
    id: 'rv_q86',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
GREGARIO''',
    options: [r'''Solitario''', r'''Firme''', r'''Sociable''', r'''Dificil'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Sociable" conserva la relacion lexical solicitada para "GREGARIO".''',
  ),
  Question(
    id: 'rv_q87',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
HEDIONDO''',
    options: [r'''Aromatico''', r'''Limpio''', r'''Suave''', r'''Fetido'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Fetido" conserva la relacion lexical solicitada para "HEDIONDO".''',
  ),
  Question(
    id: 'rv_q88',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
HIERATICO''',
    options: [r'''Solemne''', r'''Informal''', r'''Dinamico''', r'''Jovial'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Solemne" conserva la relacion lexical solicitada para "HIERATICO".''',
  ),
  Question(
    id: 'rv_q89',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
IGNARO''',
    options: [r'''Sabio''', r'''Ignorante''', r'''Diestro''', r'''Claro'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Ignorante" conserva la relacion lexical solicitada para "IGNARO".''',
  ),
  Question(
    id: 'rv_q90',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
IMPAVIDO''',
    options: [r'''Atemorizado''', r'''Rapido''', r'''Sereno''', r'''Altivo'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Sereno" conserva la relacion lexical solicitada para "IMPAVIDO".''',
  ),
  Question(
    id: 'rv_q91',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
IMPIO''',
    options: [r'''Piadoso''', r'''Leal''', r'''Prudente''', r'''Irreligioso'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Irreligioso" conserva la relacion lexical solicitada para "IMPIO".''',
  ),
  Question(
    id: 'rv_q92',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INANE''',
    options: [r'''Vano''', r'''Util''', r'''Fuerte''', r'''Denso'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Vano" conserva la relacion lexical solicitada para "INANE".''',
  ),
  Question(
    id: 'rv_q93',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INCONCUSO''',
    options: [r'''Dudoso''', r'''Indiscutible''', r'''Fragil''', r'''Breve'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Indiscutible" conserva la relacion lexical solicitada para "INCONCUSO".''',
  ),
  Question(
    id: 'rv_q94',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INEFABLE''',
    options: [
      r'''Explicable''',
      r'''Comun''',
      r'''Indescriptible''',
      r'''Audible''',
    ],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Indescriptible" conserva la relacion lexical solicitada para "INEFABLE".''',
  ),
  Question(
    id: 'rv_q95',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INEXORABLE''',
    options: [r'''Flexible''', r'''Dudoso''', r'''Amable''', r'''Implacable'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Implacable" conserva la relacion lexical solicitada para "INEXORABLE".''',
  ),
  Question(
    id: 'rv_q96',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INICUO''',
    options: [r'''Injusto''', r'''Equitativo''', r'''Claro''', r'''Ligero'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Injusto" conserva la relacion lexical solicitada para "INICUO".''',
  ),
  Question(
    id: 'rv_q97',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INOPIA''',
    options: [r'''Riqueza''', r'''Pobreza''', r'''Ruido''', r'''Templanza'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Pobreza" conserva la relacion lexical solicitada para "INOPIA".''',
  ),
  Question(
    id: 'rv_q98',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INSIPIENTE''',
    options: [r'''Sabio''', r'''Alegre''', r'''Necio''', r'''Diligente'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Necio" conserva la relacion lexical solicitada para "INSIPIENTE".''',
  ),
  Question(
    id: 'rv_q99',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INSOLITO''',
    options: [r'''Habitual''', r'''Claro''', r'''Cercano''', r'''Inusual'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Inusual" conserva la relacion lexical solicitada para "INSOLITO".''',
  ),
  Question(
    id: 'rv_q100',
    topicId: 'rv_sinonimos',
    text: r'''Identifique el sinonimo exacto de la premisa:
INTEMPESTIVO''',
    options: [r'''Inoportuno''', r'''Oportuno''', r'''Regular''', r'''Firme'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Inoportuno" conserva la relacion lexical solicitada para "INTEMPESTIVO".''',
  ),
  Question(
    id: 'rv_q101',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ABYECTO''',
    options: [
      r'''despreciable''',
      r'''noble''',
      r'''efímero''',
      r'''cauto''',
      r'''sagaz''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Abyecto refiere a algo vil, ruin o despreciable en extremo, oponiéndose a lo noble o digno.''',
  ),
  Question(
    id: 'rv_q102',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: PUSILÁNIME''',
    options: [
      r'''sagaz''',
      r'''cobarde''',
      r'''cauto''',
      r'''audaz''',
      r'''valiente''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Pusilánime denota falta de valor, cobardía o apocamiento ante situaciones difíciles.''',
  ),
  Question(
    id: 'rv_q103',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: INMARCESIBLE''',
    options: [
      r'''pasajero''',
      r'''apócrifio''',
      r'''efímero''',
      r'''abatido''',
      r'''inmarchitable''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Inmarcesible refiere a aquello que no se puede marchitar, es decir, eterno o perdurable.''',
  ),
  Question(
    id: 'rv_q104',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: OSTRACISMO''',
    options: [
      r'''reunión''',
      r'''destierro''',
      r'''acogida''',
      r'''aprobación''',
      r'''indulgencia''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El ostracismo representa la exclusión o destierro de la vida pública o social de un individuo.''',
  ),
  Question(
    id: 'rv_q105',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ABATIDO''',
    options: [
      r'''desalentado''',
      r'''erguido''',
      r'''alegre''',
      r'''activo''',
      r'''fuerte''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Abatido describe a alguien decaído en ánimo, desalentado o físicamente cansado.''',
  ),
  Question(
    id: 'rv_q106',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ABOLIR''',
    options: [
      r'''derogar''',
      r'''promulgar''',
      r'''establecer''',
      r'''aprobar''',
      r'''crear''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Abolir significa dejar sin vigencia o derogar una ley, precepto o costumbre.''',
  ),
  Question(
    id: 'rv_q107',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ACUCIOSO''',
    options: [
      r'''lento''',
      r'''negligente''',
      r'''apático''',
      r'''diligente''',
      r'''distraído''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Acuicioso refiere a una persona diligente, presurosa o muy cuidadosa en sus labores.''',
  ),
  Question(
    id: 'rv_q108',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ANACRÓNICO''',
    options: [
      r'''oportuno''',
      r'''extemporáneo''',
      r'''actual''',
      r'''moderno''',
      r'''vigente''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Anacrónico representa algo que no corresponde a la época actual, siendo extemporáneo o incongruente.''',
  ),
  Question(
    id: 'rv_q109',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: APÓCRIFO''',
    options: [
      r'''original''',
      r'''verdadero''',
      r'''genuíno''',
      r'''auténtico''',
      r'''falso''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Apócrifo designa a obras o hechos falsos o de dudosa autenticidad, no reconocidos oficialmente.''',
  ),
  Question(
    id: 'rv_q110',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: CAUTO''',
    options: [
      r'''prudente''',
      r'''arriesgado''',
      r'''temerario''',
      r'''imprudente''',
      r'''alocado''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Cauto es sinónimo de prudente, reservado o precavido frente a peligros potenciales.''',
  ),
  Question(
    id: 'rv_q111',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: EFÍMERO''',
    options: [
      r'''constante''',
      r'''permanente''',
      r'''duradero''',
      r'''pasajero''',
      r'''eterno''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Efímero alude a aquello que es de corta duración, pasajero o fugaz.''',
  ),
  Question(
    id: 'rv_q112',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: FECUNDO''',
    options: [
      r'''infecundo''',
      r'''fértil''',
      r'''seco''',
      r'''estéril''',
      r'''árido''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Fecundo indica productividad, capacidad de reproducirse o fertilidad intelectual/material.''',
  ),
  Question(
    id: 'rv_q113',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: INEFABLE''',
    options: [
      r'''indescriptible''',
      r'''decible''',
      r'''común''',
      r'''explicable''',
      r'''expresable''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Inefable califica a lo que no se puede explicar o describir con palabras debido a su grandeza.''',
  ),
  Question(
    id: 'rv_q114',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: SAGAZ''',
    options: [
      r'''torpe''',
      r'''necio''',
      r'''perspicaz''',
      r'''lento''',
      r'''ingenuo''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Sagaz describe a alguien perspicaz, astuto o hábil para descubrir cosas o evitar engaños.''',
  ),
  Question(
    id: 'rv_q115',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: FUGACIDAD''',
    options: [
      r'''perpetuidad''',
      r'''brevedad''',
      r'''duración''',
      r'''lentitud''',
      r'''eternidad''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Fugacidad representa la cualidad de durar muy poco tiempo, caracterizada por la brevedad.''',
  ),
  Question(
    id: 'rv_q116',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: VAPULEAR''',
    options: [
      r'''acariciar''',
      r'''proteger''',
      r'''elogiar''',
      r'''alabar''',
      r'''golpear''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Vapulear consiste en golpear repetidamente o reprender con dureza a una persona o idea.''',
  ),
  Question(
    id: 'rv_q117',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: PERPLEJO''',
    options: [
      r'''seguro''',
      r'''decidido''',
      r'''resuelto''',
      r'''convencido''',
      r'''dudoso''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Perplejo es quien se encuentra dudoso, desconcertado o incapaz de tomar una decisión.''',
  ),
  Question(
    id: 'rv_q118',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ENIGMÁTICO''',
    options: [
      r'''manifiesto''',
      r'''claro''',
      r'''misterioso''',
      r'''evidente''',
      r'''obvio''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Enigmático es aquello que contiene un enigma, resultando misterioso o difícil de descifrar.''',
  ),
  Question(
    id: 'rv_q119',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: PROLIJO''',
    options: [
      r'''sucinto''',
      r'''detallado''',
      r'''rápido''',
      r'''breve''',
      r'''corto''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Prolijo describe un trabajo detallado, minucioso y que a veces llega a ser excesivamente largo.''',
  ),
  Question(
    id: 'rv_q120',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: CONCISO''',
    options: [
      r'''redundante''',
      r'''prolijo''',
      r'''sucinto''',
      r'''extenso''',
      r'''largo''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Conciso alude a expresarse con pocas y precisas palabras, siendo sucinto y directo.''',
  ),
  Question(
    id: 'rv_q121',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ALTIVO''',
    options: [
      r'''orgulloso''',
      r'''sumiso''',
      r'''sencillo''',
      r'''humilde''',
      r'''modesto''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Altivo describe a la persona orgullosa, soberbia o que se cree superior a los demás.''',
  ),
  Question(
    id: 'rv_q122',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: SUMISO''',
    options: [
      r'''indómito''',
      r'''rebelde''',
      r'''obediente''',
      r'''terco''',
      r'''altivo''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Sumiso es quien se somete dócilmente a la voluntad de otros, resultando obediente.''',
  ),
  Question(
    id: 'rv_q123',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: GÉNESIS''',
    options: [
      r'''origen''',
      r'''extinción''',
      r'''conclusión''',
      r'''final''',
      r'''término''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Génesis alude al origen, principio o nacimiento de una cosa o proceso.''',
  ),
  Question(
    id: 'rv_q124',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ENCONIO''',
    options: [
      r'''afecto''',
      r'''rencor''',
      r'''simpatía''',
      r'''cariño''',
      r'''indulgencia''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Enconio denota rencor, mala voluntad o encono acumulado contra alguien.''',
  ),
  Question(
    id: 'rv_q125',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: INDULGENCIA''',
    options: [
      r'''castigo''',
      r'''intolerancia''',
      r'''rigor''',
      r'''clemencia''',
      r'''severidad''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Indulgencia representa la inclinación a perdonar con facilidad, mostrando clemencia.''',
  ),
  Question(
    id: 'rv_q126',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: DISPLICENCIA''',
    options: [
      r'''afecto''',
      r'''interés''',
      r'''indiferencia''',
      r'''entusiasmo''',
      r'''amabilidad''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Displicencia denota indiferencia, apatía o falta de agrado y entusiasmo en el trato.''',
  ),
  Question(
    id: 'rv_q127',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: CONJETURA''',
    options: [
      r'''hecho''',
      r'''verdad''',
      r'''certeza''',
      r'''evidencia''',
      r'''suposición''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Conjetura es un juicio formado a partir de indicios u observaciones; una suposición.''',
  ),
  Question(
    id: 'rv_q128',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: DOGMA''',
    options: [
      r'''doctrina''',
      r'''cuestionamiento''',
      r'''escepticismo''',
      r'''duda''',
      r'''crítica''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Dogma es un punto esencial de una doctrina o religión que se acepta como verdad innegable.''',
  ),
  Question(
    id: 'rv_q129',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: EFICACIA''',
    options: [
      r'''incapacidad''',
      r'''ineficiencia''',
      r'''fracaso''',
      r'''inutilidad''',
      r'''efectividad''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Eficacia es la capacidad de lograr el efecto deseado, es decir, la efectividad.''',
  ),
  Question(
    id: 'rv_q130',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: GÉLIDO''',
    options: [
      r'''helado''',
      r'''caliente''',
      r'''cálido''',
      r'''tórrido''',
      r'''ardiente''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Gélido califica a lo que es extremadamente frío o helado.''',
  ),
  Question(
    id: 'rv_q131',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ÍGNEO''',
    options: [
      r'''terrestre''',
      r'''acuático''',
      r'''frío''',
      r'''volcánico''',
      r'''gélido''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Ígneo alude a aquello relacionado con el fuego o de naturaleza volcánica.''',
  ),
  Question(
    id: 'rv_q132',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: LATIVO''',
    options: [
      r'''inmóvil''',
      r'''pasivo''',
      r'''estático''',
      r'''neutro''',
      r'''direccional''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Lativo es un término lingüístico que indica movimiento hacia un lugar, es decir, direccional.''',
  ),
  Question(
    id: 'rv_q133',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: APATÍA''',
    options: [
      r'''entusiasmo''',
      r'''desinterés''',
      r'''dinamismo''',
      r'''pasión''',
      r'''fervor''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Apatía denota falta de vigor, desinterés o desgano por las cosas.''',
  ),
  Question(
    id: 'rv_q134',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: LACÓNICO''',
    options: [
      r'''locuaz''',
      r'''hablador''',
      r'''prolijo''',
      r'''breve''',
      r'''elocuente''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Lacónico describe a quien habla poco o escribe de forma breve y concisa.''',
  ),
  Question(
    id: 'rv_q135',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: LOCUAZ''',
    options: [
      r'''elocuente''',
      r'''callado''',
      r'''silencioso''',
      r'''mudo''',
      r'''lacónico''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Locuaz califica al que habla mucho o se expresa con elocuencia.''',
  ),
  Question(
    id: 'rv_q136',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: MEZQUINO''',
    options: [
      r'''desprendido''',
      r'''generoso''',
      r'''filántropo''',
      r'''altruista''',
      r'''tacaño''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Mezquino describe a la persona tacaña o cicatera que escatima en gastos.''',
  ),
  Question(
    id: 'rv_q137',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: OPULENCIA''',
    options: [
      r'''miseria''',
      r'''pobreza''',
      r'''riqueza''',
      r'''indigencia''',
      r'''escasez''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Opulencia representa gran abundancia de bienes, riqueza o lujo.''',
  ),
  Question(
    id: 'rv_q138',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: PENURIA''',
    options: [
      r'''plenitud''',
      r'''abundancia''',
      r'''riqueza''',
      r'''opulencia''',
      r'''escasez''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Penuria denota la falta de las cosas más necesarias, es decir, escasez o miseria.''',
  ),
  Question(
    id: 'rv_q139',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: RECTITUD''',
    options: [
      r'''integridad''',
      r'''desvío''',
      r'''corrupción''',
      r'''maldad''',
      r'''deshonestidad''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Rectitud es la cualidad de actuar conforme a las leyes y la moral, es decir, integridad.''',
  ),
  Question(
    id: 'rv_q140',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: SOBRIO''',
    options: [
      r'''desmedido''',
      r'''excesivo''',
      r'''moderado''',
      r'''ostentoso''',
      r'''lujoso''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Sobrio califica a quien es moderado en el comer, beber o en su estilo general.''',
  ),
  Question(
    id: 'rv_q141',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: TERCO''',
    options: [
      r'''obstinado''',
      r'''flexible''',
      r'''manejable''',
      r'''sumiso''',
      r'''dócil''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Terco describe a quien se mantiene firme en una opinión o actitud, siendo obstinado.''',
  ),
  Question(
    id: 'rv_q142',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: UTOPÍA''',
    options: [
      r'''hecho''',
      r'''certeza''',
      r'''quimera''',
      r'''logro''',
      r'''realidad''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Utopía es un plan o proyecto ideal que resulta inalcanzable, es decir, una quimera.''',
  ),
  Question(
    id: 'rv_q143',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: VIL''',
    options: [
      r'''despreciable''',
      r'''digno''',
      r'''noble''',
      r'''ilustre''',
      r'''generoso''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Vil califica a las acciones o personas bajas, ruines o despreciables.''',
  ),
  Question(
    id: 'rv_q144',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ZENIT''',
    options: [
      r'''cúspide''',
      r'''suelo''',
      r'''base''',
      r'''abismo''',
      r'''nadir''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El zenit representa el punto más alto en el hemisferio celeste, o la cúspide de un proceso.''',
  ),
  Question(
    id: 'rv_q145',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: ABSTRUSO''',
    options: [
      r'''comprensible''',
      r'''evidente''',
      r'''sencillo''',
      r'''incomprensible''',
      r'''claro''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Abstruso califica a aquello que es de difícil comprensión, resultando incomprensible.''',
  ),
  Question(
    id: 'rv_q146',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: BÉLICO''',
    options: [
      r'''conciliador''',
      r'''tranquilo''',
      r'''pacífico''',
      r'''calmo''',
      r'''guerrero''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Bélico alude a aquello perteneciente o relativo a la guerra, es decir, guerrero.''',
  ),
  Question(
    id: 'rv_q147',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: COLOQUIAL''',
    options: [
      r'''formal''',
      r'''culto''',
      r'''académico''',
      r'''técnico''',
      r'''familiar''',
    ],
    correctAnswer: 4,
    explanation:
        r'''Coloquial es el lenguaje propio de la conversación diaria, informal o familiar.''',
  ),
  Question(
    id: 'rv_q148',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: DECREPITUD''',
    options: [
      r'''vejez''',
      r'''juventud''',
      r'''fuerza''',
      r'''lozanía''',
      r'''vigor''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Decrepitud representa el estado de debilidad extrema propio de la senectud o vejez.''',
  ),
  Question(
    id: 'rv_q149',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: EFUSIÓN''',
    options: [
      r'''frialdad''',
      r'''reserva''',
      r'''expresividad''',
      r'''apatía''',
      r'''silencio''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Efusión es el derramamiento de sentimientos o afecto, denotando expresividad.''',
  ),
  Question(
    id: 'rv_q150',
    topicId: 'rv_sinonimos',
    text:
        r'''Identifique el sinónimo correcto del término resaltado en mayúsculas: FRUGAL''',
    options: [
      r'''excesivo''',
      r'''glotón''',
      r'''desmedido''',
      r'''templado''',
      r'''insaciable''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Frugal describe a quien come y bebe con moderación, resultando templado y comedido.''',
  ),
  Question(
    id: 'rv_q151',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antónimo absoluto de la premisa:
EFÍMERO''',
    options: [r'''Largo''', r'''Eternidad''', r'''Sempiterno''', r'''Fugaz'''],
    correctAnswer: 2,
    explanation:
        r"""C es correcta. B (Eternidad) es 'Transgresión Morfológica' (sustantivo). A (Largo) es un antónimo relativo débil. D es sinónimo distractor.""",
  ),
  Question(
    id: 'rv_q152',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antónimo absoluto de la premisa:
LÍCITO''',
    options: [
      r'''Ilegalidad''',
      r'''Prohibido''',
      r'''Ilegal''',
      r'''Delito''',
    ],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. A y D son transgresiones morfológicas (sustantivos). B (Prohibido) es un antónimo relativo (lo prohibido no siempre es ilícito).''',
  ),
  Question(
    id: 'rv_q153',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antónimo absoluto de la premisa:
ACICALAR''',
    options: [
      r'''Descuidado''',
      r'''Desaliñar''',
      r'''Limpiar''',
      r'''Suciedad''',
    ],
    correctAnswer: 1,
    explanation:
        r'''B es correcta (verbo). A (Descuidado) es adjetivo (transgresión morfológica). D es sustantivo. C es sinónimo de campo semántico cercano.''',
  ),
  Question(
    id: 'rv_q154',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antónimo absoluto de la premisa:
PRUDENTE''',
    options: [r'''Temeridad''', r'''Osado''', r'''Rápido''', r'''Insensato'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. A (Temeridad) es sustantivo. B (Osado) es antónimo relativo o aproximado. C (Rápido) es desviación de campo semántico.''',
  ),
  Question(
    id: 'rv_q155',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antónimo absoluto de la premisa:
ABATIDO''',
    options: [
      r'''Alegre''',
      r'''Euforia''',
      r'''Exultante''',
      r'''Levantado''',
    ],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. B (Euforia) es sustantivo. A (Alegre) es antónimo relativo de menor intensidad. D (Levantado) es interpretación literal errónea.''',
  ),
  Question(
    id: 'rv_q156',
    topicId: 'rv_antonimos',
    text:
        r"""Señale el antónimo de la palabra subrayada en el siguiente enunciado: 'A pesar de sus inmensas riquezas, el filósofo mantenía una dieta **frugal**'.""",
    options: [
      r'''espartana''',
      r'''moderada''',
      r'''copiosa''',
      r'''mesurada''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Frugal' significa moderado en el comer y el beber. Su opuesto directo es 'copioso', que indica abundante o excesivo, especialmente en la comida.""",
  ),
  Question(
    id: 'rv_q157',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **TACITURNO**.''',
    options: [r'''retraído''', r'''locuaz''', r'''sombrío''', r'''parco'''],
    correctAnswer: 1,
    explanation:
        r"""'Taciturno' se aplica a la persona silenciosa y callada. Su antónimo exacto es 'locuaz', que califica a quien habla mucho y con soltura.""",
  ),
  Question(
    id: 'rv_q158',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **GÉLIDO**.''',
    options: [r'''tórrido''', r'''gélido''', r'''frígido''', r'''templado'''],
    correctAnswer: 0,
    explanation:
        r"""'Gélido' significa extremadamente frío o helado. Su antónimo de intensidad correspondiente es 'tórrido', que significa extremadamente caliente o ardiente.""",
  ),
  Question(
    id: 'rv_q159',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **INDOLENTE**.''',
    options: [
      r'''apático''',
      r'''diligente''',
      r'''indiferente''',
      r'''negligente''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Indolente' califica a la persona perezosa o que no muestra esfuerzo. Su antónimo es 'diligente', que hace referencia al dinamismo, esmero y rapidez.""",
  ),
  Question(
    id: 'rv_q160',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **LACONISMO**.''',
    options: [
      r'''concisión''',
      r'''brevedad''',
      r'''verborrea''',
      r'''sobriedad''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Laconismo' es la costumbre de expresarse con brevedad e ideas directas. Su antónimo es 'verborrea', que es el exceso de palabras sin sustancia.""",
  ),
  Question(
    id: 'rv_q161',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **SEMPITERNO**.''',
    options: [r'''eterno''', r'''perpetuo''', r'''efímero''', r'''inmortal'''],
    correctAnswer: 2,
    explanation:
        r"""'Sempiterno' describe lo que durará siempre o no tiene fin. Su opuesto es 'efímero', que dura apenas un instante o un tiempo cortísimo.""",
  ),
  Question(
    id: 'rv_q162',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **OPROBIO**.''',
    options: [r'''ignominia''', r'''afrenta''', r'''lauda''', r'''honra'''],
    correctAnswer: 3,
    explanation:
        r"""'Oprobio' es la deshonra pública, humillación o ignominia. El antónimo es 'honra', que alude al honor, estima y buena reputación.""",
  ),
  Question(
    id: 'rv_q163',
    topicId: 'rv_antonimos',
    text:
        r"""Señale el antónimo de la palabra subrayada en el siguiente enunciado: 'El científico se mostraba **ufano** tras recibir el premio internacional'.""",
    options: [
      r'''soberbio''',
      r'''humilde''',
      r'''arrogante''',
      r'''satisfecho''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Ufano' denota orgullo, arrogancia o engreimiento por un logro obtenido. Su antónimo es 'humilde', que califica a quien carece de orgullo desmedido.""",
  ),
  Question(
    id: 'rv_q164',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **DIATRIBA**.''',
    options: [
      r'''invectiva''',
      r'''panegírico''',
      r'''sátira''',
      r'''catilinaria''',
    ],
    correctAnswer: 1,
    explanation:
        r"""Una 'diatriba' es un escrito o discurso violento e injurioso contra algo o alguien. Su antónimo es 'panegírico', que consiste en un elogio formal.""",
  ),
  Question(
    id: 'rv_q165',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **ESQUIVO**.''',
    options: [r'''huraño''', r'''elusivo''', r'''afable''', r'''retraído'''],
    correctAnswer: 2,
    explanation:
        r"""'Esquivo' es huraño, arisco o que evita el trato social. Su antónimo es 'afable', que describe a una persona cordial, afectuosa y de trato fácil.""",
  ),
  Question(
    id: 'rv_q166',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **PUSILÁNIME**.''',
    options: [
      r'''timorato''',
      r'''cobarde''',
      r'''denodado''',
      r'''indeciso''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Pusilánime' define a una persona temerosa o cobarde. Su antónimo es 'denodado', que denota un valor excepcional e intrepidez ante el peligro.""",
  ),
  Question(
    id: 'rv_q167',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **PERPETRAR**.''',
    options: [
      r'''cometer''',
      r'''prevenir''',
      r'''consumar''',
      r'''ejecutar''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Perpetrar' significa llevar a cabo un delito o acción censurable. Su antónimo es 'prevenir', que implica actuar con anticipación para evitar que ocurra.""",
  ),
  Question(
    id: 'rv_q168',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **INMARCESIBLE**.''',
    options: [
      r'''inmortal''',
      r'''eterno''',
      r'''marchitable''',
      r'''duradero''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Inmarcesible' es lo que no puede marchitarse o secarse. Su antónimo es 'marchitable', propenso a perder su lozanía y vigor natural.""",
  ),
  Question(
    id: 'rv_q169',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **APATÍA**.''',
    options: [
      r'''desinterés''',
      r'''dejadez''',
      r'''celo''',
      r'''indiferencia''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Apatía' es la indolencia o total falta de interés. Su antónimo es 'celo', que denota esmero, cuidado y fervorosa dedicación a una tarea.""",
  ),
  Question(
    id: 'rv_q170',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **ZAFIO**.''',
    options: [r'''tosco''', r'''rústico''', r'''pulido''', r'''grosero'''],
    correctAnswer: 2,
    explanation:
        r"""'Zafio' describe a alguien grosero, inculto y tosco de modales. Su antónimo es 'pulido', que califica a una persona educada, refinada y fina.""",
  ),
  Question(
    id: 'rv_q171',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **ENCONO**.''',
    options: [
      r'''rencor''',
      r'''tirria''',
      r'''benevolencia''',
      r'''animadversión''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Encono' es la mala voluntad, odio o rencor arraigado hacia alguien. Su antónimo es 'benevolencia', que expresa buena voluntad, simpatía y afecto.""",
  ),
  Question(
    id: 'rv_q172',
    topicId: 'rv_antonimos',
    text:
        r"""Señale el antónimo de la palabra subrayada: 'El nuevo producto quedó **exento** de pagar aranceles de importación'.""",
    options: [r'''libre''', r'''gravado''', r'''inmune''', r'''dispensado'''],
    correctAnswer: 1,
    explanation:
        r"""'Exento' significa libre de una carga u obligación. En el ámbito fiscal, su opuesto es 'gravado', que significa sometido a un impuesto o tasa.""",
  ),
  Question(
    id: 'rv_q173',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **LÁNGUIDO**.''',
    options: [r'''débil''', r'''decaído''', r'''lozano''', r'''desvaído'''],
    correctAnswer: 2,
    explanation:
        r"""'Lánguido' significa decaído, flaco o falto de fuerza. Su antónimo es 'lozano', que denota verdor, robustez, frescura y vigor saludable.""",
  ),
  Question(
    id: 'rv_q174',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **GÁRRULO**.''',
    options: [
      r'''charlatán''',
      r'''locuaz''',
      r'''taciturno''',
      r'''hablador''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Gárrulo' define al charlatán o persona que habla excesivamente y sin ton ni son. Su antónimo es 'taciturno', propenso al silencio.""",
  ),
  Question(
    id: 'rv_q175',
    topicId: 'rv_antonimos',
    text: r'''Señale el antónimo de la palabra: **EXECRAR**.''',
    options: [
      r'''maldecir''',
      r'''venerar''',
      r'''detestar''',
      r'''abominar''',
    ],
    correctAnswer: 1,
    explanation:
        r"""'Execrar' significa condenar y maldecir con fuerza moral. Su antónimo es 'venerar', que implica respetar y adorar solemnemente a alguien.""",
  ),
  Question(
    id: 'rv_q176',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
FRUGAL''',
    options: [r'''Copioso''', r'''Moderado''', r'''Sobrio''', r'''Mesurado'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Copioso" conserva la relacion lexical solicitada para "FRUGAL".''',
  ),
  Question(
    id: 'rv_q177',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
TACITURNO''',
    options: [r'''Callado''', r'''Locuaz''', r'''Reservado''', r'''Parco'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Locuaz" conserva la relacion lexical solicitada para "TACITURNO".''',
  ),
  Question(
    id: 'rv_q178',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
GELIDO''',
    options: [r'''Frigido''', r'''Helado''', r'''Torrido''', r'''Templado'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Torrido" conserva la relacion lexical solicitada para "GELIDO".''',
  ),
  Question(
    id: 'rv_q179',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
INDOLENTE''',
    options: [
      r'''Apatico''',
      r'''Negligente''',
      r'''Perezoso''',
      r'''Diligente''',
    ],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Diligente" conserva la relacion lexical solicitada para "INDOLENTE".''',
  ),
  Question(
    id: 'rv_q180',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
LACONICO''',
    options: [r'''Verboso''', r'''Breve''', r'''Conciso''', r'''Sucinto'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Verboso" conserva la relacion lexical solicitada para "LACONICO".''',
  ),
  Question(
    id: 'rv_q181',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
SEMPITERNO''',
    options: [r'''Eterno''', r'''Efimero''', r'''Perpetuo''', r'''Inmortal'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Efimero" conserva la relacion lexical solicitada para "SEMPITERNO".''',
  ),
  Question(
    id: 'rv_q182',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
OPROBIO''',
    options: [r'''Afrenta''', r'''Deshonra''', r'''Honra''', r'''Ignominia'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Honra" conserva la relacion lexical solicitada para "OPROBIO".''',
  ),
  Question(
    id: 'rv_q183',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
UFANO''',
    options: [r'''Soberbio''', r'''Altivo''', r'''Orgulloso''', r'''Humilde'''],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Humilde" conserva la relacion lexical solicitada para "UFANO".''',
  ),
  Question(
    id: 'rv_q184',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
DIATRIBA''',
    options: [
      r'''Panegirico''',
      r'''Invectiva''',
      r'''Critica''',
      r'''Reproche''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Panegirico" conserva la relacion lexical solicitada para "DIATRIBA".''',
  ),
  Question(
    id: 'rv_q185',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
ESQUIVO''',
    options: [r'''Huraño''', r'''Afable''', r'''Arisco''', r'''Elusivo'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Afable" conserva la relacion lexical solicitada para "ESQUIVO".''',
  ),
  Question(
    id: 'rv_q186',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
PUSILANIME''',
    options: [r'''Cobarde''', r'''Timorato''', r'''Valiente''', r'''Medroso'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Valiente" conserva la relacion lexical solicitada para "PUSILANIME".''',
  ),
  Question(
    id: 'rv_q187',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
PERPETRAR''',
    options: [
      r'''Cometer''',
      r'''Ejecutar''',
      r'''Consumir''',
      r'''Prevenir''',
    ],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Prevenir" conserva la relacion lexical solicitada para "PERPETRAR".''',
  ),
  Question(
    id: 'rv_q188',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
INMARCESIBLE''',
    options: [
      r'''Marchitable''',
      r'''Eterno''',
      r'''Incorruptible''',
      r'''Perenne''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Marchitable" conserva la relacion lexical solicitada para "INMARCESIBLE".''',
  ),
  Question(
    id: 'rv_q189',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
APATIA''',
    options: [
      r'''Indiferencia''',
      r'''Celo''',
      r'''Desgano''',
      r'''Desinteres''',
    ],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Celo" conserva la relacion lexical solicitada para "APATIA".''',
  ),
  Question(
    id: 'rv_q190',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
ZAFIO''',
    options: [r'''Tosco''', r'''Grosero''', r'''Pulido''', r'''Rustico'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Pulido" conserva la relacion lexical solicitada para "ZAFIO".''',
  ),
  Question(
    id: 'rv_q191',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
ENCONO''',
    options: [
      r'''Rencor''',
      r'''Odio''',
      r'''Animadversion''',
      r'''Benevolencia''',
    ],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Benevolencia" conserva la relacion lexical solicitada para "ENCONO".''',
  ),
  Question(
    id: 'rv_q192',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
EXENTO''',
    options: [
      r'''Gravado''',
      r'''Libre''',
      r'''Dispensado''',
      r'''Exceptuado''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Gravado" conserva la relacion lexical solicitada para "EXENTO".''',
  ),
  Question(
    id: 'rv_q193',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
LANGUIDO''',
    options: [r'''Debil''', r'''Lozano''', r'''Decaido''', r'''Exhausto'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Lozano" conserva la relacion lexical solicitada para "LANGUIDO".''',
  ),
  Question(
    id: 'rv_q194',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
GARRULO''',
    options: [
      r'''Charlatan''',
      r'''Locuaz''',
      r'''Taciturno''',
      r'''Hablador''',
    ],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Taciturno" conserva la relacion lexical solicitada para "GARRULO".''',
  ),
  Question(
    id: 'rv_q195',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
EXECRAR''',
    options: [
      r'''Detestar''',
      r'''Abominar''',
      r'''Maldecir''',
      r'''Venerar''',
    ],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Venerar" conserva la relacion lexical solicitada para "EXECRAR".''',
  ),
  Question(
    id: 'rv_q196',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
ADVERSO''',
    options: [r'''Favorable''', r'''Hostil''', r'''Contrario''', r'''Nocivo'''],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Favorable" conserva la relacion lexical solicitada para "ADVERSO".''',
  ),
  Question(
    id: 'rv_q197',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
ARIDO''',
    options: [r'''Seco''', r'''Fertil''', r'''Esteril''', r'''Desolado'''],
    correctAnswer: 1,
    explanation:
        r'''B es correcta. "Fertil" conserva la relacion lexical solicitada para "ARIDO".''',
  ),
  Question(
    id: 'rv_q198',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
AUDAZ''',
    options: [r'''Valiente''', r'''Osado''', r'''Timido''', r'''Temerario'''],
    correctAnswer: 2,
    explanation:
        r'''C es correcta. "Timido" conserva la relacion lexical solicitada para "AUDAZ".''',
  ),
  Question(
    id: 'rv_q199',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
BENIGNO''',
    options: [
      r'''Bondadoso''',
      r'''Suave''',
      r'''Inofensivo''',
      r'''Maligno''',
    ],
    correctAnswer: 3,
    explanation:
        r'''D es correcta. "Maligno" conserva la relacion lexical solicitada para "BENIGNO".''',
  ),
  Question(
    id: 'rv_q200',
    topicId: 'rv_antonimos',
    text: r'''Identifique el antonimo exacto de la premisa:
CAOTICO''',
    options: [
      r'''Ordenado''',
      r'''Confuso''',
      r'''Desordenado''',
      r'''Turbio''',
    ],
    correctAnswer: 0,
    explanation:
        r'''A es correcta. "Ordenado" conserva la relacion lexical solicitada para "CAOTICO".''',
  ),
  Question(
    id: 'rv_q201',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ABYECTO''',
    options: [
      r'''sagaz''',
      r'''despreciable''',
      r'''noble''',
      r'''cauto''',
      r'''efímero''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El antónimo directo de ABYECTO es noble. Mientras que ABYECTO significa despreciable o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q202',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: PUSILÁNIME''',
    options: [
      r'''audaz''',
      r'''sagaz''',
      r'''cobarde''',
      r'''cauto''',
      r'''valiente''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de PUSILÁNIME es valiente. Mientras que PUSILÁNIME significa cobarde o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q203',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: INMARCESIBLE''',
    options: [
      r'''apócrifio''',
      r'''efímero''',
      r'''inmarchitable''',
      r'''pasajero''',
      r'''abatido''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de INMARCESIBLE es pasajero. Mientras que INMARCESIBLE significa inmarchitable o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q204',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: OSTRACISMO''',
    options: [
      r'''acogida''',
      r'''indulgencia''',
      r'''reunión''',
      r'''destierro''',
      r'''aprobación''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El antónimo directo de OSTRACISMO es acogida. Mientras que OSTRACISMO significa destierro o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q205',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ABATIDO''',
    options: [
      r'''desalentado''',
      r'''fuerte''',
      r'''erguido''',
      r'''activo''',
      r'''alegre''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El antónimo directo de ABATIDO es erguido. Mientras que ABATIDO significa desalentado o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q206',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ABOLIR''',
    options: [
      r'''crear''',
      r'''promulgar''',
      r'''establecer''',
      r'''derogar''',
      r'''aprobar''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de ABOLIR es promulgar. Mientras que ABOLIR significa derogar o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q207',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ACUCIOSO''',
    options: [
      r'''lento''',
      r'''negligente''',
      r'''distraído''',
      r'''apático''',
      r'''diligente''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de ACUCIOSO es negligente. Mientras que ACUCIOSO significa diligente o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q208',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ANACRÓNICO''',
    options: [
      r'''vigente''',
      r'''actual''',
      r'''oportuno''',
      r'''moderno''',
      r'''extemporáneo''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de ANACRÓNICO es actual. Mientras que ANACRÓNICO significa extemporáneo o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q209',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: APÓCRIFO''',
    options: [
      r'''original''',
      r'''auténtico''',
      r'''genuíno''',
      r'''verdadero''',
      r'''falso''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de APÓCRIFO es auténtico. Mientras que APÓCRIFO significa falso o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q210',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: CAUTO''',
    options: [
      r'''prudente''',
      r'''arriesgado''',
      r'''temerario''',
      r'''imprudente''',
      r'''alocado''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El antónimo directo de CAUTO es temerario. Mientras que CAUTO significa prudente o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q211',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: EFÍMERO''',
    options: [
      r'''pasajero''',
      r'''constante''',
      r'''eterno''',
      r'''duradero''',
      r'''permanente''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de EFÍMERO es duradero. Mientras que EFÍMERO significa pasajero o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q212',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: FECUNDO''',
    options: [
      r'''árido''',
      r'''seco''',
      r'''infecundo''',
      r'''fértil''',
      r'''estéril''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de FECUNDO es estéril. Mientras que FECUNDO significa fértil o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q213',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: INEFABLE''',
    options: [
      r'''indescriptible''',
      r'''explicable''',
      r'''común''',
      r'''decible''',
      r'''expresable''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de INEFABLE es explicable. Mientras que INEFABLE significa indescriptible o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q214',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: SAGAZ''',
    options: [
      r'''ingenuo''',
      r'''lento''',
      r'''perspicaz''',
      r'''necio''',
      r'''torpe''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El antónimo directo de SAGAZ es ingenuo. Mientras que SAGAZ significa perspicaz o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q215',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: FUGACIDAD''',
    options: [
      r'''lentitud''',
      r'''brevedad''',
      r'''duración''',
      r'''perpetuidad''',
      r'''eternidad''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de FUGACIDAD es perpetuidad. Mientras que FUGACIDAD significa brevedad o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q216',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: VAPULEAR''',
    options: [
      r'''acariciar''',
      r'''proteger''',
      r'''golpear''',
      r'''elogiar''',
      r'''alabar''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El antónimo directo de VAPULEAR es acariciar. Mientras que VAPULEAR significa golpear o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q217',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: PERPLEJO''',
    options: [
      r'''resuelto''',
      r'''convencido''',
      r'''dudoso''',
      r'''decidido''',
      r'''seguro''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de PERPLEJO es seguro. Mientras que PERPLEJO significa dudoso o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q218',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ENIGMÁTICO''',
    options: [
      r'''manifiesto''',
      r'''evidente''',
      r'''obvio''',
      r'''misterioso''',
      r'''claro''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de ENIGMÁTICO es evidente. Mientras que ENIGMÁTICO significa misterioso o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q219',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: PROLIJO''',
    options: [
      r'''detallado''',
      r'''corto''',
      r'''breve''',
      r'''rápido''',
      r'''sucinto''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de PROLIJO es sucinto. Mientras que PROLIJO significa detallado o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q220',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: CONCISO''',
    options: [
      r'''sucinto''',
      r'''largo''',
      r'''prolijo''',
      r'''extenso''',
      r'''redundante''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de CONCISO es extenso. Mientras que CONCISO significa sucinto o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q221',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ALTIVO''',
    options: [
      r'''modesto''',
      r'''orgulloso''',
      r'''sencillo''',
      r'''humilde''',
      r'''sumiso''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de ALTIVO es humilde. Mientras que ALTIVO significa orgulloso o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q222',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: SUMISO''',
    options: [
      r'''obediente''',
      r'''indómito''',
      r'''altivo''',
      r'''rebelde''',
      r'''terco''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de SUMISO es rebelde. Mientras que SUMISO significa obediente o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q223',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: GÉNESIS''',
    options: [
      r'''extinción''',
      r'''término''',
      r'''conclusión''',
      r'''origen''',
      r'''final''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de GÉNESIS es final. Mientras que GÉNESIS significa origen o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q224',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ENCONIO''',
    options: [
      r'''rencor''',
      r'''afecto''',
      r'''cariño''',
      r'''indulgencia''',
      r'''simpatía''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de ENCONIO es afecto. Mientras que ENCONIO significa rencor o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q225',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: INDULGENCIA''',
    options: [
      r'''clemencia''',
      r'''rigor''',
      r'''intolerancia''',
      r'''castigo''',
      r'''severidad''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de INDULGENCIA es rigor. Mientras que INDULGENCIA significa clemencia o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q226',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: DISPLICENCIA''',
    options: [
      r'''afecto''',
      r'''interés''',
      r'''indiferencia''',
      r'''entusiasmo''',
      r'''amabilidad''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de DISPLICENCIA es entusiasmo. Mientras que DISPLICENCIA significa indiferencia o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q227',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: CONJETURA''',
    options: [
      r'''evidencia''',
      r'''verdad''',
      r'''hecho''',
      r'''certeza''',
      r'''suposición''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de CONJETURA es certeza. Mientras que CONJETURA significa suposición o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q228',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: DOGMA''',
    options: [
      r'''doctrina''',
      r'''crítica''',
      r'''escepticismo''',
      r'''cuestionamiento''',
      r'''duda''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El antónimo directo de DOGMA es escepticismo. Mientras que DOGMA significa doctrina o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q229',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: EFICACIA''',
    options: [
      r'''incapacidad''',
      r'''inutilidad''',
      r'''fracaso''',
      r'''ineficiencia''',
      r'''efectividad''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de EFICACIA es inutilidad. Mientras que EFICACIA significa efectividad o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q230',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: GÉLIDO''',
    options: [
      r'''caliente''',
      r'''ardiente''',
      r'''helado''',
      r'''tórrido''',
      r'''cálido''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de GÉLIDO es cálido. Mientras que GÉLIDO significa helado o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q231',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ÍGNEO''',
    options: [
      r'''frío''',
      r'''terrestre''',
      r'''volcánico''',
      r'''gélido''',
      r'''acuático''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de ÍGNEO es acuático. Mientras que ÍGNEO significa volcánico o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q232',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: LATIVO''',
    options: [
      r'''inmóvil''',
      r'''neutro''',
      r'''pasivo''',
      r'''direccional''',
      r'''estático''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de LATIVO es estático. Mientras que LATIVO significa direccional o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q233',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: APATÍA''',
    options: [
      r'''dinamismo''',
      r'''fervor''',
      r'''desinterés''',
      r'''entusiasmo''',
      r'''pasión''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de APATÍA es entusiasmo. Mientras que APATÍA significa desinterés o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q234',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: LACÓNICO''',
    options: [
      r'''breve''',
      r'''locuaz''',
      r'''hablador''',
      r'''elocuente''',
      r'''prolijo''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de LACÓNICO es locuaz. Mientras que LACÓNICO significa breve o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q235',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: LOCUAZ''',
    options: [
      r'''callado''',
      r'''mudo''',
      r'''silencioso''',
      r'''lacónico''',
      r'''elocuente''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El antónimo directo de LOCUAZ es callado. Mientras que LOCUAZ significa elocuente o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q236',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: MEZQUINO''',
    options: [
      r'''filántropo''',
      r'''generoso''',
      r'''altruista''',
      r'''desprendido''',
      r'''tacaño''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de MEZQUINO es generoso. Mientras que MEZQUINO significa tacaño o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q237',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: OPULENCIA''',
    options: [
      r'''escasez''',
      r'''pobreza''',
      r'''indigencia''',
      r'''riqueza''',
      r'''miseria''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de OPULENCIA es miseria. Mientras que OPULENCIA significa riqueza o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q238',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: PENURIA''',
    options: [
      r'''opulencia''',
      r'''abundancia''',
      r'''riqueza''',
      r'''plenitud''',
      r'''escasez''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de PENURIA es abundancia. Mientras que PENURIA significa escasez o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q239',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: RECTITUD''',
    options: [
      r'''integridad''',
      r'''desvío''',
      r'''corrupción''',
      r'''maldad''',
      r'''deshonestidad''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El antónimo directo de RECTITUD es corrupción. Mientras que RECTITUD significa integridad o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q240',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: SOBRIO''',
    options: [
      r'''lujoso''',
      r'''ostentoso''',
      r'''desmedido''',
      r'''excesivo''',
      r'''moderado''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de SOBRIO es excesivo. Mientras que SOBRIO significa moderado o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q241',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: TERCO''',
    options: [
      r'''manejable''',
      r'''flexible''',
      r'''dócil''',
      r'''sumiso''',
      r'''obstinado''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de TERCO es flexible. Mientras que TERCO significa obstinado o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q242',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: UTOPÍA''',
    options: [
      r'''hecho''',
      r'''realidad''',
      r'''logro''',
      r'''quimera''',
      r'''certeza''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de UTOPÍA es realidad. Mientras que UTOPÍA significa quimera o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q243',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: VIL''',
    options: [
      r'''despreciable''',
      r'''ilustre''',
      r'''generoso''',
      r'''digno''',
      r'''noble''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de VIL es noble. Mientras que VIL significa despreciable o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q244',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ZENIT''',
    options: [
      r'''base''',
      r'''suelo''',
      r'''abismo''',
      r'''nadir''',
      r'''cúspide''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de ZENIT es nadir. Mientras que ZENIT significa cúspide o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q245',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: ABSTRUSO''',
    options: [
      r'''sencillo''',
      r'''evidente''',
      r'''claro''',
      r'''comprensible''',
      r'''incomprensible''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El antónimo directo de ABSTRUSO es claro. Mientras que ABSTRUSO significa incomprensible o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q246',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: BÉLICO''',
    options: [
      r'''guerrero''',
      r'''conciliador''',
      r'''calmo''',
      r'''pacífico''',
      r'''tranquilo''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El antónimo directo de BÉLICO es pacífico. Mientras que BÉLICO significa guerrero o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q247',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: COLOQUIAL''',
    options: [
      r'''académico''',
      r'''formal''',
      r'''culto''',
      r'''técnico''',
      r'''familiar''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de COLOQUIAL es formal. Mientras que COLOQUIAL significa familiar o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q248',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: DECREPITUD''',
    options: [
      r'''vejez''',
      r'''juventud''',
      r'''lozanía''',
      r'''fuerza''',
      r'''vigor''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El antónimo directo de DECREPITUD es juventud. Mientras que DECREPITUD significa vejez o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q249',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: EFUSIÓN''',
    options: [
      r'''apatía''',
      r'''reserva''',
      r'''frialdad''',
      r'''expresividad''',
      r'''silencio''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El antónimo directo de EFUSIÓN es frialdad. Mientras que EFUSIÓN significa expresividad o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q250',
    topicId: 'rv_antonimos',
    text:
        r'''Identifique el antónimo correcto de la palabra escrita en mayúsculas: FRUGAL''',
    options: [
      r'''desmedido''',
      r'''insaciable''',
      r'''excesivo''',
      r'''templado''',
      r'''glotón''',
    ],
    correctAnswer: 4,
    explanation:
        r'''El antónimo directo de FRUGAL es glotón. Mientras que FRUGAL significa templado o afines, su contraposición semántica requiere un concepto opuesto.''',
  ),
  Question(
    id: 'rv_q251',
    topicId: 'rv_conectores',
    text:
        r'''Intentaron persuadirlo de manera repetida para que abandonara la investigación académica; ___________, él se mantuvo inflexible, ___________ sabía que la publicación de sus hallazgos era vital.''',
    options: [
      r'''aunque - por lo tanto''',
      r'''en cambio - por ende''',
      r'''sin embargo - ya que''',
      r'''pero - aunque''',
    ],
    correctAnswer: 2,
    explanation:
        r"""C es correcta (contraste - causa). A incurre en 'Falsa Consecuencia'. D es el 'Engaño de la Eufonía Simple', donde 'aunque' arruina la lógica causal final.""",
  ),
  Question(
    id: 'rv_q252',
    topicId: 'rv_conectores',
    text:
        r'''El equipo de investigadores no logró recolectar datos empíricos suficientes, ___________ decidieron suspender la publicación del artículo, ___________ esto significara perder la subvención económica.''',
    options: [
      r'''por ende - ya que''',
      r'''por lo tanto - aunque''',
      r'''sin embargo - si bien''',
      r'''debido a que - por lo cual''',
    ],
    correctAnswer: 1,
    explanation:
        r"""B es correcta (consecuencia - concesión). A presenta 'Causalidad Invertida'. C usa 'Falso Contraste' inicial (la falta de datos es causa directa de suspender, no contraste).""",
  ),
  Question(
    id: 'rv_q253',
    topicId: 'rv_conectores',
    text:
        r'''Estudió exhaustivamente las bases legales del caso; ___________, su exposición en el debate fue deficiente, ___________ omitió citar la jurisprudencia más reciente.''',
    options: [
      r'''no obstante - debido a que''',
      r'''por lo tanto - porque''',
      r'''si bien - ya que''',
      r'''ergo - en consecuencia''',
    ],
    correctAnswer: 0,
    explanation:
        r"""A es correcta. B tiene un 'Falso Contraste/Consecuencia' al usar 'por lo tanto'. C es engaño de eufonía simple al iniciar con concesivo.""",
  ),
  Question(
    id: 'rv_q254',
    topicId: 'rv_conectores',
    text:
        r'''El proyecto de infraestructura fue aprobado por el comité técnico, ___________ no contaba con presupuesto asignado; ___________, la obra tuvo que retrasarse un año más.''',
    options: [
      r'''porque - en consecuencia''',
      r'''a pesar de que - por consiguiente''',
      r'''aunque - sin embargo''',
      r'''ya que - por ello''',
    ],
    correctAnswer: 1,
    explanation:
        r"""B es correcta (concesión - consecuencia). A y D tienen un nexo causal ilógico ('porque no contaba...'). C cae en 'Engaño de eufonía' terminando en contraste en lugar de consecuencia.""",
  ),
  Question(
    id: 'rv_q255',
    topicId: 'rv_conectores',
    text:
        r'''El estudiante no redactó el ensayo final, ___________ recopiló la bibliografía solicitada; ___________, reprobó la asignatura.''',
    options: [
      r'''ni - por lo tanto''',
      r'''sino - aunque''',
      r'''pero - ya que''',
      r'''o - sin embargo''',
    ],
    correctAnswer: 0,
    explanation:
        r"""A es correcta (adición negativa - consecuencia). B cae en 'Falso Contraste'. C cae en eufonía pero altera la consecuencia final por una causa ('ya que').""",
  ),
  Question(
    id: 'rv_q256',
    topicId: 'rv_conectores',
    text:
        r'''El equipo estudió con mucha dedicación para el examen de admisión; _______, no lograron obtener la puntuación requerida por el estrecho margen de vacantes.''',
    options: [
      r'''por lo tanto''',
      r'''sin embargo''',
      r'''debido a que''',
      r'''en consecuencia''',
    ],
    correctAnswer: 1,
    explanation:
        r"""Se necesita un conector adversativo que marque la oposición entre el esfuerzo (causa positiva) y el resultado negativo de no obtener la vacante. 'Sin embargo' es idóneo.""",
  ),
  Question(
    id: 'rv_q257',
    topicId: 'rv_conectores',
    text:
        r'''No pudo asistir a la conferencia sobre cambio climático _______ estuvo internado en el hospital recuperándose de una delicada intervención quirúrgica.''',
    options: [r'''porque''', r'''por ello''', r'''aunque''', r'''sino'''],
    correctAnswer: 0,
    explanation:
        r"""El enunciado requiere un conector causal que explique la razón de la inasistencia a la conferencia médica. 'Porque' introduce esta explicación de forma directa.""",
  ),
  Question(
    id: 'rv_q258',
    topicId: 'rv_conectores',
    text:
        r'''Las lluvias torrenciales destruyeron las principales vías de comunicación; _______, el abastecimiento de alimentos en la ciudad se vio seriamente afectado.''',
    options: [
      r'''no obstante''',
      r'''por consiguiente''',
      r'''ya que''',
      r'''es decir''',
    ],
    correctAnswer: 1,
    explanation:
        r"""El segundo enunciado es una consecuencia del primero (la caída de vías genera problemas de abastecimiento). El conector de consecuencia correcto es 'por consiguiente'.""",
  ),
  Question(
    id: 'rv_q259',
    topicId: 'rv_conectores',
    text:
        r'''El proyecto de investigación fue rechazado por el jurado _______ no presentaba un marco metodológico claro _______ el presupuesto excedía los límites establecidos.''',
    options: [
      r'''ya que - y además''',
      r'''pero - por ende''',
      r'''si bien - aunque''',
      r'''debido a que - no obstante''',
    ],
    correctAnswer: 0,
    explanation:
        r"""El primer vacío demanda un conector causal ('ya que') y el segundo demanda un conector aditivo ('y además') que acumule las razones del rechazo del proyecto.""",
  ),
  Question(
    id: 'rv_q260',
    topicId: 'rv_conectores',
    text:
        r'''El profesor explicó el teorema varias veces con paciencia, _______ algunos alumnos continuaban con dudas sobre su aplicación práctica.''',
    options: [
      r'''por ende''',
      r'''debido a que''',
      r'''aun así''',
      r'''en primer lugar''',
    ],
    correctAnswer: 2,
    explanation:
        r"""Se requiere un conector de tipo concesivo o de contraste parcial ('aun así') que denote que las explicaciones no bastaron para solucionar todas las dudas.""",
  ),
  Question(
    id: 'rv_q261',
    topicId: 'rv_conectores',
    text:
        r'''El joven novelista quería publicar su primera obra antes de fin de año; _______, el editor le aconsejó revisar minuciosamente la trama, _______ apresurar el proceso podría arruinar la calidad literaria del libro.''',
    options: [
      r'''no obstante - ya que''',
      r'''por lo tanto - aunque''',
      r'''es decir - si bien''',
      r'''así que - puesto que''',
    ],
    correctAnswer: 0,
    explanation:
        r"""El primer conector debe ser adversativo ('no obstante') para contrastar el deseo con el consejo del editor. El segundo conector debe ser causal ('ya que') para fundamentar dicho consejo.""",
  ),
  Question(
    id: 'rv_q262',
    topicId: 'rv_conectores',
    text:
        r'''La globalización ha facilitado el intercambio cultural a nivel mundial; _______, ha puesto en riesgo la supervivencia de lenguas originarias minoritarias _______ la hegemonía de idiomas dominantes.''',
    options: [
      r'''por el contrario - a causa de''',
      r'''asimismo - a pesar de''',
      r'''sin embargo - debido a''',
      r'''por consiguiente - en vista de''',
    ],
    correctAnswer: 2,
    explanation:
        r"""El primer conector marca un contraste ('sin embargo') con las bondades de la globalización. El segundo conector introduce la causa ('debido a') de esta pérdida cultural.""",
  ),
  Question(
    id: 'rv_q263',
    topicId: 'rv_conectores',
    text:
        r'''El estudiante no pudo resolver el acertijo lógico en el tiempo establecido, _______ no comprendió las premisas iniciales, _______ se rindió antes de intentar una estrategia alternativa.''',
    options: [
      r'''por lo tanto - además''',
      r'''pues - por lo que''',
      r'''dado que - e incluso''',
      r'''aunque - es decir''',
    ],
    correctAnswer: 2,
    explanation:
        r"""'Dado que' introduce la causa principal de la no resolución y el conector aditivo intensificador 'e incluso' añade un grado extremo a su frustración.""",
  ),
  Question(
    id: 'rv_q264',
    topicId: 'rv_conectores',
    text:
        r'''La inversión en ciencia y tecnología es baja en el país; _______, el desarrollo industrial sigue siendo incipiente y dependiente de la tecnología extranjera, _______ no se implementen políticas de Estado a largo plazo.''',
    options: [
      r'''debido a esto - mientras''',
      r'''por ende - a menos que''',
      r'''no obstante - si bien''',
      r'''por consiguiente - a pesar de que''',
    ],
    correctAnswer: 1,
    explanation:
        r"""La consecuencia de la baja inversión es el desarrollo incipiente ('por ende'). La condición necesaria para revertir esta realidad se introduce con 'a menos que'.""",
  ),
  Question(
    id: 'rv_q265',
    topicId: 'rv_conectores',
    text:
        r'''_______ los esfuerzos de conservación de las especies marinas en peligro, el vertido ilegal de plásticos continúa creciendo, _______ las leyes ambientales no se aplican con suficiente rigor en alta mar.''',
    options: [
      r'''A pesar de - ya que''',
      r'''Debido a - porque''',
      r'''No obstante - pero''',
      r'''A causa de - por lo tanto''',
    ],
    correctAnswer: 0,
    explanation:
        r"""'A pesar de' introduce la concesión inicial sobre los esfuerzos ecológicos. El segundo conector causal 'ya que' introduce la causa del fracaso: la falta de rigor legal.""",
  ),
  Question(
    id: 'rv_q266',
    topicId: 'rv_conectores',
    text:
        r'''La directiva de la comunidad decidió postergar la asamblea general, _______ no se había alcanzado el quórum mínimo requerido por los estatutos; _______, programaron una nueva fecha para la siguiente semana.''',
    options: [
      r'''ya que - por ende''',
      r'''aunque - no obstante''',
      r'''pero - en consecuencia''',
      r'''puesto que - sin embargo''',
    ],
    correctAnswer: 0,
    explanation:
        r"""La postergación ocurre por falta de quórum, relación causal introducida por 'ya que'. La nueva programación es la consecuencia inmediata ('por ende') de la postergación.""",
  ),
  Question(
    id: 'rv_q267',
    topicId: 'rv_conectores',
    text:
        r'''El avance de la inteligencia artificial promete optimizar la productividad de las industrias; _______, genera justificados temores sobre el desplazamiento laboral masivo, _______ exige una profunda reestructuración educativa para mitigar sus efectos sociales.''',
    options: [
      r'''en cambio - no obstante''',
      r'''sin embargo - por lo cual''',
      r'''es decir - puesto que''',
      r'''asimismo - de ahí que''',
    ],
    correctAnswer: 1,
    explanation:
        r"""El primer conector debe ser de fuerte contraste ('sin embargo') al pasar del beneficio al peligro. El segundo conector de consecuencia ('por lo cual') liga la amenaza al deber de reestructurar.""",
  ),
  Question(
    id: 'rv_q268',
    topicId: 'rv_conectores',
    text:
        r'''La teoría de la relatividad general revolucionó la física clásica, _______ propuso una nueva concepción del espacio-tiempo; _______, no fue aceptada de inmediato por toda la comunidad científica de la época.''',
    options: [
      r'''puesto que - con todo''',
      r'''aunque - por tanto''',
      r'''debido a que - asimismo''',
      r'''por el contrario - sin embargo''',
    ],
    correctAnswer: 0,
    explanation:
        r"""El conector 'puesto que' introduce la justificación causal de la revolución de la física clásica. 'Con todo' es una locución adversativa concesiva adecuada para indicar que, pese a lo anterior, tardó en ser aceptada.""",
  ),
  Question(
    id: 'rv_q269',
    topicId: 'rv_conectores',
    text:
        r'''_______ se cuente con un presupuesto holgado para la obra pública, la ejecución del proyecto fracasará _______ la burocracia estatal y la corrupción sigan obstaculizando los procesos de licitación.''',
    options: [
      r'''Aunque - siempre que''',
      r'''Si bien - en la medida en que''',
      r'''A pesar de que - puesto que''',
      r'''Aun cuando - mientras''',
    ],
    correctAnswer: 3,
    explanation:
        r"""'Aun cuando' introduce el factor concesivo del presupuesto. El conector condicional y temporal 'mientras' indica que la corrupción y burocracia coexistirán impidiendo el éxito.""",
  ),
  Question(
    id: 'rv_q270',
    topicId: 'rv_conectores',
    text:
        r'''El valor estético de una obra literaria no reside en la complejidad de su lenguaje _______ en la autenticidad de la voz del autor; _______, muchos escritores jóvenes saturan sus textos con palabras rebuscadas en un vano intento por parecer cultos.''',
    options: [
      r'''sino - por ello''',
      r'''sino que - no obstante''',
      r'''pero sí - de modo que''',
      r'''sino - sin embargo''',
    ],
    correctAnswer: 0,
    explanation:
        r"""Se requiere un conector correctivo exclusivo ('sino') para oponer la autenticidad a la complejidad. La conducta errónea de los jóvenes autores se explica de forma consecutiva con 'por ello'.""",
  ),
  Question(
    id: 'rv_q271',
    topicId: 'rv_conectores',
    text: r'''Estudio con disciplina, _______ no descanso lo suficiente.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [
      r'''sin embargo''',
      r'''por lo tanto''',
      r'''ya que''',
      r'''ademas''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La opcion "sin embargo" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q272',
    topicId: 'rv_conectores',
    text: r'''El tema era complejo, _______ el profesor lo explico con claridad.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [r'''pero''', r'''porque''', r'''por ende''', r'''es decir'''],
    correctAnswer: 0,
    explanation:
        r'''La opcion "pero" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q273',
    topicId: 'rv_conectores',
    text: r'''No reviso sus respuestas; _______, cometio errores evitables.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [
      r'''por consiguiente''',
      r'''aunque''',
      r'''sin embargo''',
      r'''sino''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La opcion "por consiguiente" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q274',
    topicId: 'rv_conectores',
    text:
        r'''El postulante domino la teoria, _______ fallo por falta de practica.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [
      r'''no obstante''',
      r'''debido a que''',
      r'''por eso''',
      r'''ademas''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La opcion "no obstante" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q275',
    topicId: 'rv_conectores',
    text: r'''La lluvia fue intensa; _______, se suspendio el entrenamiento.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [r'''por ello''', r'''en cambio''', r'''aunque''', r'''sino'''],
    correctAnswer: 0,
    explanation:
        r'''La opcion "por ello" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q276',
    topicId: 'rv_conectores',
    text:
        r'''La evidencia era insuficiente, _______ el juez solicito nuevas pruebas.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [
      r'''por lo tanto''',
      r'''a pesar de''',
      r'''sin embargo''',
      r'''pero''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La opcion "por lo tanto" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q277',
    topicId: 'rv_conectores',
    text: r'''El texto es breve, _______ contiene ideas esenciales.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [r'''pero''', r'''porque''', r'''por ende''', r'''a causa de'''],
    correctAnswer: 0,
    explanation:
        r'''La opcion "pero" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q278',
    topicId: 'rv_conectores',
    text:
        r'''Debe leer la premisa completa, _______ las alternativas pueden ser engañosas.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [
      r'''ya que''',
      r'''aunque''',
      r'''sin embargo''',
      r'''por consiguiente''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La opcion "ya que" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q279',
    topicId: 'rv_conectores',
    text: r'''Practico conectores a diario; _______, mejoro su precision.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [r'''por eso''', r'''no obstante''', r'''aunque''', r'''sino'''],
    correctAnswer: 0,
    explanation:
        r'''La opcion "por eso" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q280',
    topicId: 'rv_conectores',
    text:
        r'''El autor critica la corrupcion, _______ propone reformas institucionales.
Seleccione el conector logico adecuado. Caso 1.''',
    options: [r'''ademas''', r'''pero''', r'''aunque''', r'''sin embargo'''],
    correctAnswer: 0,
    explanation:
        r'''La opcion "ademas" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q287',
    topicId: 'rv_conectores',
    text: r'''El texto es breve, _______ contiene ideas esenciales.
Seleccione el conector logico adecuado. Caso 2.''',
    options: [r'''pero''', r'''porque''', r'''por ende''', r'''a causa de'''],
    correctAnswer: 0,
    explanation:
        r'''La opcion "pero" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q297',
    topicId: 'rv_conectores',
    text: r'''El texto es breve, _______ contiene ideas esenciales.
Seleccione el conector logico adecuado. Caso 3.''',
    options: [r'''pero''', r'''porque''', r'''por ende''', r'''a causa de'''],
    correctAnswer: 0,
    explanation:
        r'''La opcion "pero" mantiene la relacion logica exigida por el enunciado.''',
  ),
  Question(
    id: 'rv_q301',
    topicId: 'rv_conectores',
    text:
        r'''Complete los espacios en blanco con los conectores lógicos más adecuados para dar coherencia a la oración: Estudió con dedicación y esmero; _______, no logró alcanzar el puntaje de ingreso en esta oportunidad.''',
    options: [
      r'''además''',
      r'''porque''',
      r'''sin embargo''',
      r'''es decir''',
      r'''por lo tanto''',
    ],
    correctAnswer: 2,
    explanation:
        r"""El conector adversativo 'sin embargo' expresa un obstáculo o restricción que no impide el hecho principal.""",
  ),
  Question(
    id: 'rv_q351',
    topicId: 'rv_plan',
    text:
        r'''Ordena correctamente: "Evolución de la Criminología Aplicada"
I. Gracias a estos estudios pioneros, se lograron establecer sistemas penitenciarios de resocialización.
II. Sus raíces como disciplina moderna se consolidan a finales del siglo XIX.
III. En la actualidad, el perfilador criminal representa la máxima evolución de la criminología.
IV. La criminología se define unívocamente como el estudio empírico del delito.
V. En sus etapas formativas iniciales, centró su análisis en causas biológicas de la conducta.''',
    options: [
      r'''II - IV - V - I - III''',
      r'''IV - II - V - I - III''',
      r'''III - IV - II - V - I''',
      r'''IV - II - I - V - III''',
    ],
    correctAnswer: 1,
    explanation:
        r"""B es correcta. A cae en la 'Trampa Histórica' al obviar la definición general. C sufre el 'Sesgo de lo Contemporáneo' al iniciar por la idea más atractiva y actual. D incurre en 'Ruptura Causal'.""",
  ),
  Question(
    id: 'rv_q352',
    topicId: 'rv_plan',
    text:
        r'''Ordena correctamente: "La Fotosíntesis"
I. Los cloroplastos captan la energía solar mediante la clorofila.
II. Proceso metabólico mediante el cual las plantas elaboran su propio alimento.
III. El resultado final es la producción de glucosa y liberación de oxígeno.
IV. A nivel celular, requiere la absorción previa de agua y dióxido de carbono.
V. Este oxígeno es vital hoy en día para el mantenimiento de la biosfera terrestre.''',
    options: [
      r'''I - IV - II - III - V''',
      r'''II - IV - I - III - V''',
      r'''V - II - IV - I - III''',
      r'''II - I - IV - V - III''',
    ],
    correctAnswer: 1,
    explanation:
        r"""B es correcta (Generalidad -> Detalles del proceso -> Efecto final). C cae en el 'Sesgo Contemporáneo'. A sufre la 'Trampa Específica' iniciando por un organelo celular.""",
  ),
  Question(
    id: 'rv_q353',
    topicId: 'rv_plan',
    text:
        r'''Ordena correctamente: "El Método Científico"
I. Análisis de resultados y formulación de conclusiones objetivas.
II. Conjunto de pasos sistemáticos para alcanzar conocimiento válido.
III. Diseño y ejecución de la experimentación controlada.
IV. Observación de un fenómeno y planteamiento del problema.
V. Planteamiento de hipótesis o posibles explicaciones iniciales.''',
    options: [
      r'''IV - V - III - I - II''',
      r'''II - IV - V - III - I''',
      r'''II - V - IV - III - I''',
      r'''III - I - IV - V - II''',
    ],
    correctAnswer: 1,
    explanation:
        r"""B es correcta. A ignora la 'Definición General' inicial (Trampa metodológica). C invierte el problema y la hipótesis.""",
  ),
  Question(
    id: 'rv_q354',
    topicId: 'rv_plan',
    text:
        r'''Ordena correctamente: "El Imperio Romano"
I. La división del imperio por Teodosio entre sus hijos Honorio y Arcadio.
II. Civilización de la Antigüedad clásica surgida en la península itálica.
III. La caída definitiva de Roma occidental en el año 476 d.C.
IV. Sus orígenes míticos se remontan a Rómulo y Remo.
V. Su máxima expansión territorial ocurrió bajo el gobierno de Trajano.''',
    options: [
      r'''II - IV - V - I - III''',
      r'''IV - II - V - I - III''',
      r'''II - V - IV - I - III''',
      r'''III - II - IV - V - I''',
    ],
    correctAnswer: 0,
    explanation:
        r"""A es correcta (Definición -> Origen -> Apogeo -> Crisis -> Caída). B sufre 'Trampa Histórica'. D sufre 'Trampa del Impacto' (inicia por la caída).""",
  ),
  Question(
    id: 'rv_q355',
    topicId: 'rv_plan',
    text:
        r'''Ordena correctamente: "Desarrollo de Software"
I. Etapa de codificación utilizando lenguajes de programación.
II. Recolección exhaustiva y análisis de los requerimientos del cliente.
III. Concepto de ingeniería informática para crear aplicativos lógicos.
IV. Fase final de despliegue en producción y mantenimiento continuo.
V. Pruebas de calidad (Testing) para detectar errores (bugs).''',
    options: [
      r'''II - I - V - IV - III''',
      r'''III - II - I - V - IV''',
      r'''III - I - II - V - IV''',
      r'''I - V - IV - II - III''',
    ],
    correctAnswer: 1,
    explanation:
        r'''B es correcta (Definición -> Análisis -> Código -> Pruebas -> Despliegue). A omite la definición inicial. C altera el orden lógico procedimental.''',
  ),
  Question(
    id: 'rv_q356',
    topicId: 'rv_plan',
    text:
        r'''El proceso de potabilización del agua
I. Captación del agua cruda desde ríos o lagos mediante rejillas protectoras.
II. Distribución del agua potable a los hogares a través de la red de tuberías.
III. Aplicación de cloro u otros desinfectantes para eliminar microorganismos patógenos.
IV. Adición de sustancias coagulantes para agrupar y sedimentar las impurezas sólidas.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''I - IV - III - II''',
      r'''I - III - IV - II''',
      r'''IV - I - III - II''',
      r'''I - IV - II - III''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El orden del tratamiento sigue un curso natural: captación de la materia prima (I), filtración de impurezas gruesas y coagulación fina (IV), desinfección biológica con cloro (III) y entrega al consumidor final (II).''',
  ),
  Question(
    id: 'rv_q357',
    topicId: 'rv_plan',
    text:
        r'''La evolución estelar
I. Colapso gravitatorio de una nube interestelar de gas y polvo.
II. Consumo del combustible nuclear en el núcleo de la estrella.
III. Nacimiento de una protoestrella que comienza a brillar debido al calor.
IV. Expansión y posterior muerte de la estrella como enana blanca o supernova.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''I - III - II - IV''',
      r'''III - I - II - IV''',
      r'''I - II - III - IV''',
      r'''I - III - IV - II''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El ciclo de vida de una estrella comienza con el colapso de la nube materna (I), el encendido o nacimiento de la protoestrella (III), su ciclo de vida estable quemando combustible nuclear (II) y la posterior muerte de la estrella (IV).''',
  ),
  Question(
    id: 'rv_q358',
    topicId: 'rv_plan',
    text:
        r'''La investigación científica de campo
I. Formulación de la hipótesis de investigación basada en teorías previas.
II. Análisis de los datos recolectados mediante herramientas estadísticas.
III. Recolección de muestras biológicas directamente en el ecosistema estudiado.
IV. Publicación de las conclusiones en una revista científica indexada.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''I - III - II - IV''',
      r'''I - II - III - IV''',
      r'''III - I - II - IV''',
      r'''III - II - I - IV''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El método de campo arranca con la hipótesis o marco teórico del investigador (I), prosigue con la expedición al hábitat para obtener datos empíricos (III), se analizan los datos (II) y finalmente se difunde el conocimiento (IV).''',
  ),
  Question(
    id: 'rv_q359',
    topicId: 'rv_plan',
    text: r'''El Imperio Incaico y su expansió
I. Pachacútec asume el poder y defiende el Cusco de la invasión de los chancas.
II. Consolidación de un gran imperio multiétnico a lo largo del territorio andino.
III. Fase inicial del curacazgo incaico limitado al valle del Cusco.
IV. Llegada de los conquistadores españoles y caída del Tahuantinsuyo.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''III - I - II - IV''',
      r'''I - III - II - IV''',
      r'''III - II - I - IV''',
      r'''III - I - IV - II''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La cronología histórica sitúa primero el curacazgo local preexpansivo (III), luego el hito fundacional de la expansión con Pachacútec (I), el apogeo imperial consolidado (II) y la destrucción final a manos de la invasión hispana (IV).''',
  ),
  Question(
    id: 'rv_q360',
    topicId: 'rv_plan',
    text:
        r'''El descubrimiento de la penicilina
I. Fleming observa que las bacterias alrededor del hongo Penicillium habían muerto.
II. Alexander Fleming olvida unas placas de cultivo de bacterias en su laboratorio.
III. Purificación industrial de la penicilina para su uso en la Segunda Guerra Mundial.
IV. Identificación del hongo y publicación del hallazgo sobre sus propiedades antibacterianas.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''II - I - IV - III''',
      r'''I - II - IV - III''',
      r'''II - IV - I - III''',
      r'''II - I - III - IV''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El plan es cronológico y causal: el olvido accidental de las placas (II) posibilita la observación del hongo asesino (I), su clasificación científica e informe oficial (IV) y la consecuente industrialización masiva bélica (III).''',
  ),
  Question(
    id: 'rv_q361',
    topicId: 'rv_plan',
    text:
        r'''Publicación de un libro de texto
I. Redacción de los capítulos por parte del equipo de autores especialistas.
II. Revisión del texto por parte del editor y corrección de estilo.
III. Impresión y encuadernación de los ejemplares en los talleres gráficos.
IV. Distribución de los libros en las principales librerías del país.
V. Concepción de la idea pedagógica y diseño curricular del libro de texto.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''V - I - II - III - IV''',
      r'''I - V - II - III - IV''',
      r'''V - II - I - III - IV''',
      r'''V - I - III - II - IV''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El flujo de valor editorial inicia con la planificación pedagógica (V), prosigue con la producción escrita de contenidos (I), su refinamiento y corrección lingüística (II), el paso mecánico de imprenta (III) y culmina con la comercialización (IV).''',
  ),
  Question(
    id: 'rv_q362',
    topicId: 'rv_plan',
    text:
        r'''El ciclo del carbono
I. Liberación de dióxido de carbono a la atmósfera mediante la respiración animal.
II. Fijación del carbono por parte de las plantas mediante la fotosíntesis.
III. Transferencia de carbono al suelo tras la muerte y descomposición de los organismos.
IV. Consumo de materia vegetal por parte de los animales herbívoros.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''II - IV - I - III''',
      r'''I - II - IV - III''',
      r'''II - I - IV - III''',
      r'''II - IV - III - I''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El ciclo inicia con el secuestro vegetal del carbono inorgánico de la atmósfera (II), sigue con la ingesta trófica animal (IV), la devolución gaseosa mediante la respiración (I) y el enterramiento mineral tras la descomposición orgánica (III).''',
  ),
  Question(
    id: 'rv_q363',
    topicId: 'rv_plan',
    text:
        r'''La redacción de un ensayo académico
I. Selección del tema delimitado y búsqueda de fuentes bibliográficas confiables.
II. Elaboración de un esquema argumentativo preliminar.
III. Escritura del borrador inicial desarrollando la tesis central y argumentos.
IV. Revisión minuciosa y redacción de la versión final del ensayo.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''I - II - III - IV''',
      r'''II - I - III - IV''',
      r'''I - III - II - IV''',
      r'''I - II - IV - III''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El ordenamiento respeta el flujo de producción escrita: documentación inicial y delimitación del tema (I), elaboración del andamio o plan argumentativo (II), ejecución redactada en borrador (III) y la revisión final crítica (IV).''',
  ),
  Question(
    id: 'rv_q364',
    topicId: 'rv_plan',
    text:
        r'''El proceso de evolución humana
I. Desarrollo del bipedismo como adaptación a la vida en la sabana africana.
II. Migración de los primeros homínidos fuera del continente africano hacia Eurasia.
III. Incremento significativo del volumen craneal y uso sistemático de herramientas.
IV. Surgimiento del Homo sapiens y desarrollo del lenguaje simbólico complejo.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''I - III - II - IV''',
      r'''III - I - II - IV''',
      r'''I - II - III - IV''',
      r'''I - III - IV - II''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El orden sigue la secuencia evolutiva paleolítica: la locomoción bípeda (I), que liberó las manos potenciando la encefalización y las herramientas (III), permitiendo las primeras expansiones migratorias (II) y coronando con el Homo sapiens lingüístico moderno (IV).''',
  ),
  Question(
    id: 'rv_q365',
    topicId: 'rv_plan',
    text:
        r'''La crisis de la deuda externa en América Latina
I. Declaración de moratoria de pagos por parte de México en 1982.
II. Concesión masiva de préstamos baratos a tasas de interés flotantes por bancos internacionales durante la bonanza petrolera de los años 70.
III. Implementación de severas políticas de ajuste macroeconómico y reformas estructurales bajo el Consenso de Washington.
IV. Elevación abrupta de las tasas de interés en Estados Unidos para combatir su propia inflación doméstica.
Elija el ordenamiento lógico correcto de las ideas:''',
    options: [
      r'''II - IV - I - III''',
      r'''II - I - IV - III''',
      r'''IV - II - I - III''',
      r'''II - IV - III - I''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El orden causal e histórico inicia con el endeudamiento de los 70 (II), seguido del encarecimiento unilateral de tasas flotantes estadounidenses en los 80 (IV), el colapso de pagos y moratoria de México (I) y la consiguiente cura económica neoliberal del FMI/Consenso de Washington (III).''',
  ),
  Question(
    id: 'rv_q366',
    topicId: 'rv_plan',
    text:
        r'''Preparacion academica
I. Identificacion de temas debiles
II. Diagnostico inicial de conocimientos
III. Practica diaria con retroalimentacio
IV. Planificacion del horario de estudio
Elija el ordenamiento logico correcto de las ideas:''',
    options: [
      r'''II - I - IV - III''',
      r'''I - II - III - IV''',
      r'''II - IV - I - III''',
      r'''IV - III - II - I''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El orden correcto parte de la fase inicial, continua con el desarrollo y culmina con la verificacion o cierre.''',
  ),
  Question(
    id: 'rv_q367',
    topicId: 'rv_plan',
    text:
        r'''Lectura comprensiva
I. Identificacion de ideas secundarias
II. Reconocimiento del tema central
III. Sintesis final del texto
IV. Inferencia de informacion implicita
Elija el ordenamiento logico correcto de las ideas:''',
    options: [
      r'''II - I - IV - III''',
      r'''I - II - III - IV''',
      r'''II - IV - I - III''',
      r'''IV - III - II - I''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El orden correcto parte de la fase inicial, continua con el desarrollo y culmina con la verificacion o cierre.''',
  ),
  Question(
    id: 'rv_q368',
    topicId: 'rv_plan',
    text:
        r'''Investigacion historica
I. Busqueda de fuentes confiables
II. Planteamiento del problema
III. Redaccion de conclusiones
IV. Contraste de evidencias
Elija el ordenamiento logico correcto de las ideas:''',
    options: [
      r'''II - I - IV - III''',
      r'''I - II - III - IV''',
      r'''II - IV - I - III''',
      r'''IV - III - II - I''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El orden correcto parte de la fase inicial, continua con el desarrollo y culmina con la verificacion o cierre.''',
  ),
  Question(
    id: 'rv_q369',
    topicId: 'rv_plan',
    text:
        r'''Resolucion de problemas
I. Seleccion de datos relevantes
II. Comprension del enunciado
III. Verificacion del resultado
IV. Aplicacion del metodo adecuado
Elija el ordenamiento logico correcto de las ideas:''',
    options: [
      r'''II - I - IV - III''',
      r'''I - II - III - IV''',
      r'''II - IV - I - III''',
      r'''IV - III - II - I''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El orden correcto parte de la fase inicial, continua con el desarrollo y culmina con la verificacion o cierre.''',
  ),
  Question(
    id: 'rv_q370',
    topicId: 'rv_plan',
    text: r'''Exposicion oral
I. Organizacion del guio
II. Eleccion del tema
III. Respuesta a preguntas del publico
IV. Ensayo de la presentacion
Elija el ordenamiento logico correcto de las ideas:''',
    options: [
      r'''II - I - IV - III''',
      r'''I - II - III - IV''',
      r'''II - IV - I - III''',
      r'''IV - III - II - I''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El orden correcto parte de la fase inicial, continua con el desarrollo y culmina con la verificacion o cierre.''',
  ),
  Question(
    id: 'rv_q401',
    topicId: 'rv_plan',
    text:
        r'''Ordene lógicamente los enunciados para estructurar un texto coherente bajo el título:

**LA REDACCIÓN DE UN ATESTADO POLICIAL**

I. Diligencias de investigación realizadas.
II. Identificación de los presuntos infractores.
III. Conclusiones y firma del instructor.
IV. Recepción de la denuncia o noticia criminal.''',
    options: [
      r'''IV - I - II - III''',
      r'''IV - II - I - III''',
      r'''I - II - IV - III''',
      r'''II - IV - I - III''',
      r'''IV - II - III - I''',
    ],
    correctAnswer: 1,
    explanation:
        r'''La estructura lógica de un informe o atestado policial inicia con la denuncia (IV), sigue con la identificación de implicados (II), las diligencias del caso (I) y culmina con las conclusiones (III).''',
  ),
  Question(
    id: 'rv_q402',
    topicId: 'rv_plan',
    text:
        r'''Ordene lógicamente los enunciados para estructurar un texto coherente bajo el título:

**EL PROCESO DE HOMINIZACIÓN**

I. Dominio del fuego por el Homo erectus.
II. Hominización y bipedismo inicial.
III. Arte rupestre e inicio del Homo sapiens.
IV. Confección de herramientas líticas por el Homo habilis.''',
    options: [
      r'''II - I - IV - III''',
      r'''IV - II - I - III''',
      r'''II - IV - III - I''',
      r'''I - II - IV - III''',
      r'''II - IV - I - III''',
    ],
    correctAnswer: 4,
    explanation:
        r'''La secuencia evolutiva cronológica es: Bipedismo inicial (II), herramientas del Habilis (IV), control del fuego del Erectus (I) y el arte simbólico del Sapiens (III).''',
  ),
  Question(
    id: 'rv_q403',
    topicId: 'rv_plan',
    text:
        r'''Ordene lógicamente los enunciados para estructurar un texto coherente bajo el título:

**ÁREAS NATURALES PROTEGIDAS EN EL PERÚ**

I. La categorización técnica del SERNANP.
II. Marco constitucional y Ley N° 26834.
III. El establecimiento del Parque Nacional Huascarán.
IV. Diagnóstico de la deforestación en la Amazonía.''',
    options: [
      r'''II - III - I - IV''',
      r'''II - I - III - IV''',
      r'''II - I - IV - III''',
      r'''IV - II - I - III''',
      r'''I - II - III - IV''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El orden lógico va del marco legal general (II), a la categorización específica (I), la creación del Parque Nacional (III) y la problemática de deforestación local (IV).''',
  ),
  Question(
    id: 'rv_q451',
    topicId: 'rv_lectura',
    text:
        r'''Texto: "El concepto de justicia en las sociedades preestatales no se fundamentaba en la restitución del daño, sino en el aplacamiento ritual de la ira divina. Las leyes buscaban mantener la estabilidad cósmica. La infracción de un tabú era vista como una afrenta a los dioses que desataría plagas. Por ende, el castigo debía ser público y desproporcionado. Hoy, en radical contraste, la jurisprudencia moderna ha secularizado el castigo, orientándolo hacia la reeducación del infractor."
Según lo expuesto, resulta lógicamente válido INFERIR que:''',
    options: [
      r'''La infracción deliberada de un tabú era percibida como una afrenta letal a los dioses.''',
      r'''Los jueces de las cortes arcaicas eran sacerdotes carentes de formación jurídica.''',
      r'''La proporcionalidad del castigo moderno carecía de sentido bajo la noción preestatal de justicia.''',
      r'''Las leyes preestatales buscaban mantener la estabilidad cósmica del grupo social.''',
    ],
    correctAnswer: 2,
    explanation:
        r"""C es correcta (Inferencia deductiva sólida). A y D son 'Transplantes Literales Engañosos' (están escritas explícitamente, por lo que NO son inferencias). B es una 'Inferencia Imaginada' subjetiva que no se deduce del texto.""",
  ),
  Question(
    id: 'rv_q452',
    topicId: 'rv_lectura',
    text:
        r'''Texto (sobre justicia arcaica): ¿Cuál de los siguientes enunciados condensa con mayor precisión la IDEA PRINCIPAL del texto?''',
    options: [
      r'''La historia de cómo los castigos dejaron progresivamente de ser ofrendas divinas.''',
      r'''Las sociedades arcaicas castigaban severamente para aplacar la ira cósmica de las deidades.''',
      r'''La jurisprudencia moderna secular ha logrado reeducar exitosamente al infractor.''',
      r'''El contraste entre el enfoque sacro, punitivo arcaico y el modelo secular, reeducativo moderno.''',
    ],
    correctAnswer: 3,
    explanation:
        r"""D es correcta. A es 'Falsa Síntesis Temática'. B y C son 'Ideas Secundarias hiperespecíficas' que abarcan solo un fragmento del texto.""",
  ),
  Question(
    id: 'rv_q453',
    topicId: 'rv_lectura',
    text:
        r'''Texto: "A diferencia de la memoria ramificada humana, sujeta a reinterpretaciones emocionales con cada evocación, los registros de datos digitales son inmutables en su código fuente, carecen de desgaste biológico y no padecen de olvido traumático. Sin embargo, esta aparente superioridad técnica es engañosa: la memoria humana es adaptativa, su falibilidad es el mecanismo evolutivo primario que permite a nuestra especie superar tragedias paralizantes y proyectar nuevos futuros."
Es INCOMPATIBLE con la tesis del autor afirmar que:''',
    options: [
      r'''La memoria humana reinterpreta los eventos desde un lente emocional.''',
      r'''La infalibilidad del registro digital lo hace biológicamente superior a la memoria humana.''',
      r'''El olvido posee una función evolutiva esencial para superar traumas.''',
      r'''El código fuente de los datos digitales es técnica y estructuralmente inmutable.''',
    ],
    correctAnswer: 1,
    explanation:
        r"""B es correcta (Es incompatible porque el autor dice explícitamente que dicha superioridad es 'engañosa'). A, C y D son ideas compatibles o literales.""",
  ),
  Question(
    id: 'rv_q454',
    topicId: 'rv_lectura',
    text:
        r'''Texto (sobre la memoria): A partir del texto, se COLIGE lógicamente que la exactitud absoluta en la retención de recuerdos a largo plazo:''',
    options: [
      r'''Sería un impedimento perjudicial para la sanación emocional humana frente a la adversidad.''',
      r'''Carece de desgaste biológico y no padece de olvido traumático a diferencia de los discos duros.''',
      r'''Debería ser replicada genéticamente imitando la inmutabilidad de las computadoras modernas.''',
      r'''Es el mecanismo evolutivo primario que nos diferencia cognitivamente de otros mamíferos.''',
    ],
    correctAnswer: 0,
    explanation:
        r"""A es correcta (Inferencia válida: si el olvido permite superar traumas, recordar absolutamente todo impediría sanar). B es 'Transplante Literal Engañoso'. C es 'Inferencia Imaginada' (sobre-extrapolación sin base textual).""",
  ),
  Question(
    id: 'rv_q455',
    topicId: 'rv_lectura',
    text:
        r'''Texto (sobre la memoria): La expresión "aparente superioridad" en el texto connota fundamentalmente una cualidad que es:''',
    options: [
      r'''Evidente''',
      r'''Definitiva''',
      r'''Ilusoria''',
      r'''Insuperable''',
    ],
    correctAnswer: 2,
    explanation:
        r"""C es correcta (Sentido contextual: si es 'aparente' y luego se dice que es 'engañosa', connota una ilusión). A es un sinónimo literal descontextualizado. B y D contradicen el propósito del autor.""",
  ),
  Question(
    id: 'rv_q456',
    topicId: 'rv_lectura',
    text:
        r'''Texto: A lo largo de la historia, las sociedades humanas han dependido de los ríos para el desarrollo de la agricultura, el comercio y el transporte. No es casualidad que las civilizaciones más antiguas, como la mesopotámica y la egipcia, se asentaran en las cuencas del Tigris, Éufrates y Nilo. Estos cuerpos de agua no solo proveían el recurso hídrico elemental, sino que depositaban sedimentos fértiles durante las inundaciones anuales, permitiendo cosechas abundantes en zonas áridas.
Del texto se infiere principalmente que:''',
    options: [
      r'''Las zonas áridas son incapaces de sustentar la agricultura sin inundaciones de grandes ríos.''',
      r'''El éxito de las primeras civilizaciones estuvo estrechamente vinculado a las ventajas geográficas de su entorno.''',
      r'''Los ríos Tigris, Éufrates y Nilo fueron los únicos que permitieron el comercio en la antigüedad.''',
      r'''Las inundaciones anuales de los ríos son eventos destructivos que las civilizaciones antiguas no podían controlar.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El autor explica cómo los asentamientos fluviales proveyeron ventajas definitivas (agua, abono orgánico) para el desarrollo de grandes civilizaciones, lo que permite inferir que su éxito dependió fuertemente de la geografía física de su entorno.''',
  ),
  Question(
    id: 'rv_q457',
    topicId: 'rv_lectura',
    text:
        r'''Texto: La lectura de obras clásicas de la literatura universal suele ser percibida por los jóvenes como una tarea académica aburrida y ajena a su realidad. Sin embargo, al analizar detenidamente temas como la traición en Macbeth o el amor imposible en Romeo y Julieta, se descubre que los dilemas existenciales de los personajes históricos siguen vigentes en las relaciones humanas actuales.
Del texto se puede inferir que los clásicos de la literatura:''',
    options: [
      r'''Solo abordan temas de amor y traición en contextos antiguos.''',
      r'''Deberían ser explicados sin recurrir a la rigidez académica tradicional.''',
      r'''Tratan problemáticas humanas que trascienden el tiempo y las épocas.''',
      r'''Son difíciles de comprender para cualquier lector menor de edad.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El texto afirma que los dilemas existenciales plasmados en las obras antiguas siguen vigentes en las relaciones actuales, de lo cual se infiere que los clásicos abordan problemas intrínsecos de la condición humana que no dependen de una época específica.''',
  ),
  Question(
    id: 'rv_q458',
    topicId: 'rv_lectura',
    text:
        r'''Texto: La fotosíntesis es un proceso biológico vital mediante el cual las plantas convierten la luz solar, el dióxido de carbono y el agua en glucosa y oxígeno. Este fenómeno no solo sostiene la vida de las plantas, sino que limpia el aire al absorber el gas de efecto invernadero producido por la actividad industrial humana. Así, la conservación de grandes extensiones boscosas actúa como un regulador natural de la temperatura global.
A partir de la información del texto, se infiere que la deforestación masiva:''',
    options: [
      r'''Interrumpe la conversión de luz solar en energía eléctrica a nivel planetario.''',
      r'''Generaría un incremento colateral en la concentración de gases de efecto invernadero.''',
      r'''Detendría de forma inmediata la respiración de todos los seres vivos.''',
      r'''Reduciría la cantidad de agua disponible para los ciclos de lluvia terrestres.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Dado que el texto establece que las plantas limpian el aire absorbiendo dióxido de carbono (gas de efecto invernadero) regulando la temperatura global, eliminar grandes masas boscosas dejaría libre este gas, aumentando su concentración atmosférica.''',
  ),
  Question(
    id: 'rv_q459',
    topicId: 'rv_lectura',
    text:
        r'''Texto: En los últimos años, el uso de billeteras digitales ha experimentado un crecimiento exponencial en América Latina, desplazando progresivamente al dinero en efectivo. Este cambio ha sido impulsado por la comodidad, la rapidez de las transacciones y la creciente penetración de la telefonía móvil en sectores de la población que tradicionalmente carecían de acceso a cuentas bancarias formales.
A partir de los datos presentados, se puede inferir que las billeteras digitales:''',
    options: [
      r'''Han promovido la inclusión financiera de personas que no estaban bancarizadas.''',
      r'''Son el único medio seguro de pago que existe en los países de América Latina.''',
      r'''Han eliminado por completo el uso de billetes físicos en el comercio minorista.''',
      r'''Exigen que los usuarios posean un alto nivel de educación financiera formal.''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El texto vincula el crecimiento del dinero digital con la inclusión de sectores de la población que no tenían cuentas bancarias formales previos a la penetración del móvil, infiriéndose un efecto directo de inclusión financiera.''',
  ),
  Question(
    id: 'rv_q460',
    topicId: 'rv_lectura',
    text:
        r'''Texto: El cerebro humano posee una capacidad asombrosa conocida como neuroplasticidad, que le permite reorganizarse y crear nuevas conexiones neuronales a lo largo de toda la vida en respuesta al aprendizaje y a la experiencia. Si bien esta flexibilidad es máxima durante la infancia, las investigaciones demuestran que los adultos mayores que se dedican a aprender nuevas disciplinas, como un idioma o un instrumento musical, presentan una menor tasa de deterioro cognitivo.
Sobre la neuroplasticidad descrita en el texto, se infiere que:''',
    options: [
      r'''Es una característica biológica exclusiva de la etapa de desarrollo infantil.''',
      r'''Puede ser estimulada de forma voluntaria mediante actividades intelectuales novedosas.''',
      r'''Detiene por completo el proceso natural de envejecimiento del cerebro.''',
      r'''Funciona de manera idéntica tanto en niños como en adultos de la tercera edad.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El texto muestra que el deterioro cognitivo en la vejez disminuye al aprender nuevas disciplinas (lo que exige neuroplasticidad), infiriéndose que este mecanismo biológico puede ser estimulado de forma deliberada con el aprendizaje continuo.''',
  ),
  Question(
    id: 'rv_q461',
    topicId: 'rv_lectura',
    text:
        r'''Texto: El método científico no es una receta infalible ni un camino lineal hacia la verdad absoluta. Consiste en un ciclo constante de observación, formulación de hipótesis, experimentación y, muy frecuentemente, reformulación de las ideas originales a la luz de resultados inesperados. De hecho, muchos de los descubrimientos más revolucionarios de la ciencia moderna surgieron del fracaso de experimentos que buscaban probar teorías que se creían correctas.
Se infiere del texto que en el ámbito de la investigación científica:''',
    options: [
      r'''El fracaso experimental carece de valor educativo o científico.''',
      r'''Las hipótesis iniciales son siempre refutadas por la experimentación.''',
      r'''Los resultados inesperados constituyen un motor esencial para el avance del conocimiento.''',
      r'''Las verdades alcanzadas por el método científico son inmutables a lo largo del tiempo.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Dado que el fracaso de experimentos antiguos llevó al planteamiento de ideas revolucionarias debido a los resultados inesperados, se infiere que estos eventos imprevistos son catalizadores fundamentales del progreso de la ciencia.''',
  ),
  Question(
    id: 'rv_q462',
    topicId: 'rv_lectura',
    text:
        r'''Texto: Durante el Renacimiento, el redescubrimiento de los textos clásicos de Grecia y Roma propició el surgimiento del humanismo, una corriente que colocaba al ser humano, sus capacidades y su razón en el centro del pensamiento. Esto rompió con la visión teocéntrica medieval, donde la vida terrenal era vista meramente como un tránsito sufriente hacia la salvación eterna, revalorizando en su lugar la búsqueda del conocimiento, el arte y el bienestar terrenal.
Del texto se infiere que la transición del pensamiento medieval al renacentista implicó:''',
    options: [
      r'''El abandono total de las creencias religiosas y la adopción del ateísmo.''',
      r'''Una reorientación de los valores culturales hacia la vida y el potencial humano.''',
      r'''La prohibición de la lectura de textos clásicos en los círculos académicos.''',
      r'''Una disminución del interés por el desarrollo artístico y filosófico.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El texto explica el paso de una visión donde la vida humana era despreciada frente a la eternidad religiosa a una donde se revalorizan las potencialidades racionales y artísticas humanas terrenales, infiriéndose un profundo giro antropocéntrico.''',
  ),
  Question(
    id: 'rv_q463',
    topicId: 'rv_lectura',
    text:
        r'''Texto: Los antibióticos han sido una de las herramientas médicas más eficaces para salvar vidas humanas desde el descubrimiento de la penicilina. Sin embargo, su uso indiscriminado y sin receta médica ha acelerado el desarrollo de cepas bacterianas resistentes. Hoy en día, enfermedades que antes eran tratables de forma sencilla amenazan con convertirse nuevamente en amenazas mortales debido a la ineficacia de los fármacos comunes.
A partir de la problemática expuesta en el texto, se puede inferir que:''',
    options: [
      r'''Las bacterias tienen la capacidad evolutiva de adaptarse y resistir la acción de los fármacos.''',
      r'''Los antibióticos modernos son intrínsecamente menos eficaces que los primeros que se sintetizaron.''',
      r'''La medicina debe prohibir el uso de antibióticos para garantizar la salud global.''',
      r'''El ser humano ha dejado de investigar nuevos tratamientos químicos contra las infecciones.''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La resistencia bacteriana generada por la automedicación constante demuestra que el patógeno experimenta un cambio adaptativo y de selección natural para sobrevivir a las dosis químicas de los medicamentos.''',
  ),
  Question(
    id: 'rv_q464',
    topicId: 'rv_lectura',
    text:
        r'''Texto: La economía del comportamiento ha demostrado que las decisiones financieras de las personas distan mucho de ser perfectamente racionales, como asumían los modelos clásicos. Los seres humanos sufrimos de sesgos cognitivos constantes; por ejemplo, valoramos más evitar una pérdida económica de cien dólares que la posibilidad de ganar esa misma cantidad. Esta asimetría psicológica influye de manera determinante en las burbujas especulativas y en el comportamiento del mercado de valores.
Del texto se infiere que los modelos económicos clásicos:''',
    options: [
      r'''Eran inútiles porque ignoraban por completo la existencia de los mercados de valores.''',
      r'''Se basaban en una premisa simplificada de la conducta del consumidor que no refleja la realidad psicológica.''',
      r'''Proponían que los seres humanos buscan perder dinero para evitar la ansiedad del éxito.''',
      r'''Fueron desarrollados por psicólogos interesados en el estudio de las burbujas financieras.''',
    ],
    correctAnswer: 1,
    explanation:
        r"""Si la economía clásica asumía que el agente económico tomaba decisiones de forma 'perfectamente racional', y la evidencia empírica muestra lo contrario (sesgos conductuales), se infiere que sus postulados partían de una abstracción idealizada del ser humano.""",
  ),
  Question(
    id: 'rv_q465',
    topicId: 'rv_lectura',
    text:
        r'''Texto: El arqueólogo Arthur Evans creyó haber descubierto en Creta el palacio del legendario rey Minos, asociando las intrincadas y laberínticas estructuras del palacio de Cnosos con el mito del Minotauro. Sin embargo, análisis arquitectónicos y epigráficos contemporáneos sugieren que Cnosos no funcionaba propiamente como la residencia de un monarca absoluto, sino como un gran centro administrativo, religioso y de almacenamiento redistributivo compartido por una corporación sacerdotal u oligárquica.
A partir de la rectificación histórica mencionada en el texto, se puede inferir que:''',
    options: [
      r'''La arqueología del siglo XIX solía interpretar los restos físicos a la luz de los relatos mitológicos conocidos.''',
      r'''El rey Minos gobernó Creta como un monarca sumamente democrático y participativo.''',
      r'''Las estructuras de Cnosos eran en realidad trampas diseñadas para encerrar prisioneros de guerra.''',
      r'''Los mitos griegos carecen de cualquier tipo de vinculación con la realidad geográfica e histórica de Creta.''',
    ],
    correctAnswer: 0,
    explanation:
        r'''El caso de Evans interpretando la arquitectura real de Cnosos como el calabozo del Minotauro y hogar de Minos muestra que la arqueología inicial asociaba sesgadamente los descubrimientos materiales a la épica literaria regional.''',
  ),
  Question(
    id: 'rv_q466',
    topicId: 'rv_lectura',
    text:
        r'''Texto: La disciplina diaria permite convertir el estudio en habito. Cuando el aprendizaje se distribuye en sesiones breves y constantes, la memoria retiene mejor que en jornadas improvisadas.
Del texto se infiere principalmente que:''',
    options: [
      r'''La constancia mejora la retencion del aprendizaje.''',
      r'''Estudiar solo un dia antes es suficiente.''',
      r'''La memoria no depende de habitos.''',
      r'''Las sesiones breves impiden aprender.''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La respuesta correcta resume una inferencia coherente con la idea central del texto.''',
  ),
  Question(
    id: 'rv_q467',
    topicId: 'rv_lectura',
    text:
        r'''Texto: La comprension lectora no consiste en repetir frases del texto, sino en reconocer relaciones entre ideas, identificar la intencion del autor e inferir informacion no expresada literalmente.
Del texto se infiere principalmente que:''',
    options: [
      r'''Comprender es copiar literalmente.''',
      r'''Comprender exige interpretar relaciones e intenciones.''',
      r'''La inferencia no pertenece a la lectura.''',
      r'''La intencion del autor es irrelevante.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''La respuesta correcta resume una inferencia coherente con la idea central del texto.''',
  ),
  Question(
    id: 'rv_q468',
    topicId: 'rv_lectura',
    text:
        r'''Texto: Los simulacros cumplen una funcion diagnostica: revelan errores recurrentes, miden el manejo del tiempo y permiten ajustar la estrategia antes de enfrentar una evaluacion real.
Del texto se infiere principalmente que:''',
    options: [
      r'''El simulacro reemplaza todo estudio teorico.''',
      r'''El tiempo no importa en un examen.''',
      r'''El simulacro sirve para corregir estrategia y detectar fallas.''',
      r'''Los errores deben ignorarse.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La respuesta correcta resume una inferencia coherente con la idea central del texto.''',
  ),
  Question(
    id: 'rv_q469',
    topicId: 'rv_lectura',
    text:
        r'''Texto: El vocabulario amplio favorece la precision comunicativa. Quien distingue matices entre palabras similares puede elegir terminos mas exactos y comprender mejor textos complejos.
Del texto se infiere principalmente que:''',
    options: [
      r'''Todas las palabras similares significan lo mismo.''',
      r'''El vocabulario no afecta la comprension.''',
      r'''La precision depende solo de la memoria visual.''',
      r'''El dominio lexical ayuda a expresarse y comprender con precision.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''La respuesta correcta resume una inferencia coherente con la idea central del texto.''',
  ),
  Question(
    id: 'rv_q470',
    topicId: 'rv_lectura',
    text:
        r'''Texto: La organizacion de ideas en un texto responde a una jerarquia: primero se presenta el tema, luego se desarrollan argumentos y finalmente se cierra con una conclusion coherente.
Del texto se infiere principalmente que:''',
    options: [
      r'''Un texto coherente sigue una estructura jerarquica.''',
      r'''La conclusion debe ir siempre al inicio.''',
      r'''Los argumentos no requieren orden.''',
      r'''La jerarquia textual impide comprender.''',
    ],
    correctAnswer: 0,
    explanation:
        r'''La respuesta correcta resume una inferencia coherente con la idea central del texto.''',
  ),
  Question(
    id: 'rv_q501',
    topicId: 'rv_lectura',
    text: r'''**TEXTO**:
El policía es el garante de la seguridad y del orden público, pero sobre todo, del respeto irrestricto de las garantías constitucionales. En un Estado de derecho, la autoridad no reside en la fuerza del uniforme, sino en la legitimidad de las leyes que dicho uniforme tiene la obligación de defender. Por ende, la disciplina policial no representa una sumisión ciega, sino un compromiso ético y consciente con los valores democráticos y constitucionales de la nación.

Del texto anterior se infiere principalmente que la labor del policía es:''',
    options: [
      r'''una mera profesión de carácter administrativo.''',
      r'''un compromiso ético con los valores constitucionales.''',
      r'''el uso ilimitado de la fuerza coercitiva.''',
      r'''la defensa exclusiva de los intereses de la élite.''',
      r'''una sumisión ciega a los mandos superiores.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El texto resalta que la disciplina y autoridad policial residen en la legitimidad de las leyes y su compromiso ético con la Constitución.''',
  ),
  Question(
    id: 'rv_q506',
    topicId: 'rv_lectura',
    text: r'''**TEXTO**:
La biodiversidad del Perú es un pilar fundamental para su seguridad alimentaria y económica, albergando miles de especies de flora y fauna en sus diversas regiones ecológicas. Las Áreas Naturales Protegidas (ANP) actúan como santuarios para salvaguardar estos recursos de amenazas como la minería ilegal y la deforestación. Sin embargo, la gestión ambiental eficaz requiere no solo de resguardo legal, sino de la incorporación de tecnologías de monitoreo en tiempo real (teledetección) y la activa participación de los pueblos indígenas locales.

El autor del fragmento sostiene principalmente que la protección de la biodiversidad:''',
    options: [
      r'''debe limitarse al uso de satélites espaciales de teledetección.''',
      r'''se resuelve desalojando a los pueblos indígenas de sus tierras.''',
      r'''exige un enfoque integral de leyes, tecnología y participación local.''',
      r'''es prioritaria solo para atraer inversión extranjera y turismo.''',
      r'''depende únicamente de las leyes dictadas en el Congreso.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El texto indica explícitamente que la eficacia requiere resguardo legal, tecnología y la participación activa indígena.''',
  ),
];
