import 'package:learn/models/question.dart';

final List<Question> tablaPeriodicaQuestions = [
  // Nivel Fácil
  Question(
    id: 'tab_per_f1',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué información principal indica el número atómico de un elemento químico en la tabla periódica?''',
    options: [
      r'''El número total de electrones y neutrones.''',
      r'''El peso de la corteza atómica.''',
      r'''El número de protones presentes en el núcleo de un átomo.''',
      r'''La cantidad de enlaces covalentes que puede formar.''',
      r'''El estado físico del elemento a temperatura ambiente.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El número atómico es la magnitud fundamental para ordenar la tabla y, científicamente, es exactamente igual al número de protones que contiene el núcleo del átomo del elemento.''',
  ),
  Question(
    id: 'tab_per_f2',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo químico del elemento Oxígeno?''',
    options: [r'''Ox''', r'''Og''', r'''On''', r'''O''', r'''Os'''],
    correctAnswer: 3,
    explanation:
        r'''El oxígeno, esencial para la respiración y componente mayoritario del aire, se representa internacionalmente con la letra mayúscula "O".''',
  ),
  Question(
    id: 'tab_per_f3',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo químico del elemento Sodio?''',
    options: [r'''Sd''', r'''So''', r'''Na''', r'''NA''', r'''Nd'''],
    correctAnswer: 2,
    explanation:
        r'''El símbolo del sodio es "Na", proveniente de su nombre originario en latín Natrium.''',
  ),
  Question(
    id: 'tab_per_f4',
    topicId: 'cta_tabla_periodica',
    text:
        r'''De acuerdo a la estructura general de la tabla periódica, ¿qué indican los "períodos"?''',
    options: [
      r'''Las columnas verticales que agrupan gases.''',
      r'''Las filas horizontales que indican los niveles de energía de los electrones de los átomos.''',
      r'''Los bloques de elementos radiactivos sintéticos.''',
      r'''La cantidad de protones de los metales.''',
      r'''Los nombres de los científicos que los descubrieron.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Los periodos son las 7 filas horizontales de la tabla e indican o representan el número de capas electrónicas (o niveles de energía) que tienen los átomos de los elementos ubicados en esa fila.''',
  ),
  Question(
    id: 'tab_per_f5',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo químico del Hierro?''',
    options: [r'''Hi''', r'''Ir''', r'''Fe''', r'''F''', r'''He'''],
    correctAnswer: 2,
    explanation:
        r'''El hierro, del latín Ferrum, está clasificado en el grupo 8 (metales de transición) y su símbolo oficial es "Fe".''',
  ),
  Question(
    id: 'tab_per_f6',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Cuál es el elemento químico más abundante y ligero de todo el universo?''',
    options: [
      r'''El Oxígeno.''',
      r'''El Helio.''',
      r'''El Carbono.''',
      r'''El Hidrógeno.''',
      r'''El Nitrógeno.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El hidrógeno (H) es el elemento más ligero (número atómico 1) y el más abundante del universo, constituyendo aproximadamente el 75% de toda la materia visible.''',
  ),
  Question(
    id: 'tab_per_f7',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo del elemento Magnesio?''',
    options: [r'''Mn''', r'''MG''', r'''mn''', r'''Mg''', r'''Ma'''],
    correctAnswer: 3,
    explanation:
        r'''El magnesio, un metal alcalinotérreo, se representa químicamente con el símbolo "Mg" (la primera letra siempre mayúscula y la segunda minúscula).''',
  ),
  Question(
    id: 'tab_per_f8',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Quién es considerado el creador de la primera versión de la tabla periódica moderna en 1869?''',
    options: [
      r'''John Newlands.''',
      r'''Johann Wolfgang Döbereiner.''',
      r'''Julius Lothar Meyer.''',
      r'''Dmitri Ivánovich Mendeléyev.''',
      r'''Henry Moseley.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El químico ruso Dmitri Mendeléyev organizó por primera vez los elementos basándose en sus propiedades químicas y pesos atómicos, dejando espacios para predecir futuros descubrimientos, sentando las bases de la tabla moderna.''',
  ),
  Question(
    id: 'tab_per_f9',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo del elemento Potasio?''',
    options: [r'''P''', r'''Po''', r'''Pt''', r'''Pp''', r'''K'''],
    correctAnswer: 4,
    explanation:
        r'''El símbolo del potasio es "K", el cual proviene del latín Kalium.''',
  ),
  Question(
    id: 'tab_per_f10',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo químico del elemento Oro?''',
    options: [r'''Or''', r'''Au''', r'''Ag''', r'''O''', r'''Ua'''],
    correctAnswer: 1,
    explanation:
        r'''El oro, clasificado como un metal de transición y metal precioso de acuñar en el Grupo 11, se representa con el símbolo "Au" (del latín Aurum).''',
  ),

  // Nivel Medio
  Question(
    id: 'tab_per_m1',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué característica fundamental determina que los elementos se ubiquen en una misma familia o grupo y tengan propiedades similares?''',
    options: [
      r'''Su año de descubrimiento.''',
      r'''El número de electrones de valencia en su capa externa.''',
      r'''Su estado físico (siempre son líquidos).''',
      r'''Su grado de reactividad nuclear.''',
      r'''El orden alfabético de sus símbolos.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Las características químicas de los elementos de una familia están determinadas principalmente por su configuración electrónica, es decir, el número de electrones en su última capa o electrones de valencia.''',
  ),
  Question(
    id: 'tab_per_m2',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo del elemento Plomo?''',
    options: [r'''Pl''', r'''Po''', r'''Pt''', r'''Pb''', r'''PM'''],
    correctAnswer: 3,
    explanation:
        r'''El plomo, ubicado en el grupo de los carbonoideos, se identifica con el símbolo químico "Pb" proveniente de Plumbum.''',
  ),
  Question(
    id: 'tab_per_m3',
    topicId: 'cta_tabla_periodica',
    text:
        r'''En la tabla periódica, ¿cómo se conoce oficialmente al Grupo 18, famoso por poseer elementos con muy baja reactividad?''',
    options: [
      r'''Halógenos.''',
      r'''Metales de transición.''',
      r'''Alcalinotérreos.''',
      r'''Gases Nobles.''',
      r'''Carbonoideos.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El Grupo 18 está compuesto por los Gases Nobles (Helio, Neón, Argón, etc.), que se caracterizan por encontrarse en forma gaseosa y presentar una extremada estabilidad y baja reactividad.''',
  ),
  Question(
    id: 'tab_per_m4',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo químico del Azufre?''',
    options: [r'''Az''', r'''A''', r'''Su''', r'''Z''', r'''S'''],
    correctAnswer: 4,
    explanation:
        r'''El azufre, fundamental en aminoácidos y procesos industriales (familia de los calcógenos), se representa con el símbolo "S" (del latín Sulphur).''',
  ),
  Question(
    id: 'tab_per_m5',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué propiedades intermedias definen a los elementos conocidos como "Metaloides"?''',
    options: [
      r'''Son gases altamente reactivos con el agua.''',
      r'''Son radiactivos y sintéticos, creados únicamente en laboratorios.''',
      r'Comparten características de los metales (como ser semiconductores de electricidad) y de los no metales (como ser quebradizos).',
      r'''Son los mejores conductores del calor de toda la tabla.''',
      r'''Tienen un peso atómico negativo.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Los metaloides (como el silicio o el germanio) se ubican en una franja diagonal y exhiben propiedades intermedias entre los metales típicos y los no metales, siendo fundamentales como semiconductores.''',
  ),
  Question(
    id: 'tab_per_m6',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo químico del Fósforo?''',
    options: [r'''Fs''', r'''F''', r'''Po''', r'''P''', r'''Ph'''],
    correctAnswer: 3,
    explanation:
        r'''El fósforo, del grupo de los nitrogenoideos, esencial para la estructura del ADN, tiene como símbolo químico la letra "P".''',
  ),
  Question(
    id: 'tab_per_m7',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo químico del Flúor?''',
    options: [r'''Fl''', r'''Fo''', r'''Fe''', r'''F''', r'''Fu'''],
    correctAnswer: 3,
    explanation:
        r'''El flúor es un halógeno y el elemento más electronegativo de la tabla; su símbolo químico oficial es la "F" mayúscula.''',
  ),
  Question(
    id: 'tab_per_m8',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Cómo se comporta químicamente la familia de los Metales Alcalinos (Grupo 1) frente al agua?''',
    options: [
      r'''Son altamente reactivos y reaccionan violentamente formando álcalis.''',
      r'''Se congelan inmediatamente.''',
      r'''Se transforman en gases inertes.''',
      r'''No presentan ninguna reacción química.''',
      r'''Se asientan en el fondo por su alta densidad sin disolverse.''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Los metales alcalinos (como el sodio y el potasio) son extremadamente reactivos, especialmente al entrar en contacto con la humedad o el agua, formando soluciones básicas o alcalinas.''',
  ),
  Question(
    id: 'tab_per_m9',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo del elemento Estaño?''',
    options: [r'''Es''', r'''Et''', r'''St''', r'''Sn''', r'''En'''],
    correctAnswer: 3,
    explanation:
        r'''El estaño, un metal del grupo de los carbonoideos, se representa con el símbolo "Sn", derivado del latín Stannum.''',
  ),
  Question(
    id: 'tab_per_m10',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo del gas noble Radón?''',
    options: [r'''Ra''', r'''Rd''', r'''RN''', r'''Ro''', r'''Rn'''],
    correctAnswer: 4,
    explanation:
        r'''El radón es un gas noble altamente radiactivo ubicado en el Grupo 18 y se representa mediante el símbolo "Rn".''',
  ),

  // Nivel Difícil
  Question(
    id: 'tab_per_d1',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Cuál fue el mayor mérito predictivo de la tabla de Dmitri Mendeléyev publicada en 1869?''',
    options: [
      r'''Fue el primero en descubrir los protones, neutrones y electrones.''',
      r'''Logró sintetizar oro a partir de plomo.''',
      r'''Dejó espacios vacíos en su tabla y predijo con exactitud las propiedades físicas y químicas de elementos que aún no se habían descubierto.''',
      r'''Dividió el átomo por primera vez.''',
      r'''Comprobaron la existencia de la antimateria.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Mendeléyev previó la existencia de elementos desconocidos (como el galio y el germanio) al dejar intencionalmente huecos vacíos en su arreglo, calculando sus propiedades gracias a su ubicación teórica en la tabla.''',
  ),
  Question(
    id: 'tab_per_d2',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué significa el término "isótopo" aplicado a los elementos químicos?''',
    options: [
      r'''Átomos del mismo elemento que carecen por completo de electrones.''',
      r'''Un elemento sintético fabricado por la IUPAC.''',
      r'''Átomos de un mismo elemento (mismo número atómico) que poseen distinto número de neutrones en su núcleo, variando su número másico.''',
      r'''Elementos que se evaporan al contacto con el aire.''',
      r'''Elementos que no se encuentran en estado sólido.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Se llama isótopo a la sustancia constituida por átomos cuyo núcleo posee el mismo número de protones (mismo elemento) pero difieren en su cantidad de neutrones.''',
  ),
  Question(
    id: 'tab_per_d3',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué elemento vital, considerado estratégico para la industria (usado en las bolas de los bolígrafos y herramientas de corte), fue descubierto por los españoles hermanos Elhuyar y tiene como símbolo la letra "W"?''',
    options: [
      r'''Galio.''',
      r'''Platino.''',
      r'''Wolframio (o Tungsteno).''',
      r'''Vanadio.''',
      r'''Francio.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El Wolframio (Tungsteno, símbolo W) fue aislado en 1783 por los hermanos Fausto y Juan José Elhuyar en Vergara, siendo vital por su altísima dureza y punto de fusión.''',
  ),
  Question(
    id: 'tab_per_d4',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué organismo internacional es la máxima autoridad encargada de registrar, validar y denominar a los nuevos elementos químicos y sus símbolos?''',
    options: [
      r'''ONU (Organización de las Naciones Unidas).''',
      r'''CSIC (Consejo Superior de Investigaciones Científicas).''',
      r'''EuChemS (Sociedad Europea de Química).''',
      r'''IUPAC (Unión Internacional de Química Pura y Aplicada).''',
      r'''NASA (Administración Nacional de Aeronáutica y el Espacio).''',
    ],
    correctAnswer: 3,
    explanation:
        r'''La IUPAC, a través de su Comité Interdivisional de Nomenclatura y Símbolos, es la encargada oficial de autorizar nombres y símbolos en química a nivel mundial.''',
  ),
  Question(
    id: 'tab_per_d5',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo del elemento Talio?''',
    options: [r'''Ti''', r'''To''', r'''Ta''', r'''TL''', r'''Tl'''],
    correctAnswer: 4,
    explanation:
        r'''El talio es un elemento del bloque p (grupo térreos) y su símbolo químico correcto (primera mayúscula, segunda minúscula) es "Tl".''',
  ),
  Question(
    id: 'tab_per_d6',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué elemento químico fue descubierto por el científico español Antonio de Ulloa en 1735 en Ecuador, cuyo símbolo es "Pt"?''',
    options: [
      r'''Plomo.''',
      r'''Platino.''',
      r'''Paladio.''',
      r'''Polonio.''',
      r'''Potasio.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Antonio de Ulloa descubrió el Platino (Pt), siendo el primer elemento clasificado descubierto por un español, hoy vital en catalizadores de vehículos y medicina.''',
  ),
  Question(
    id: 'tab_per_d7',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo del elemento Arsénico?''',
    options: [r'''Ar''', r'''Ac''', r'''Ao''', r'''AS''', r'''As'''],
    correctAnswer: 4,
    explanation:
        r'''El arsénico, un conocido metaloide del grupo 15 (nitrogenoideos), se identifica mundialmente con el símbolo "As".''',
  ),
  Question(
    id: 'tab_per_d8',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué elemento de la tabla periódica fue predicho por Mendeléyev bajo el nombre temporal de "eka-silicio" antes de ser descubierto 17 años después?''',
    options: [
      r'''Escandio.''',
      r'''Galio.''',
      r'''Germanio.''',
      r'''Polonio.''',
      r'''Bismuto.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Mendeléyev predijo las propiedades de un elemento similar al silicio y al estaño al que llamó eka-silicio; tras su hallazgo en 1886, este fue bautizado como Germanio.''',
  ),
  Question(
    id: 'tab_per_d9',
    topicId: 'cta_tabla_periodica',
    text: r'''¿Cuál es el símbolo del elemento Astato?''',
    options: [r'''As''', r'''AS''', r'''A''', r'''Aa''', r'''At'''],
    correctAnswer: 4,
    explanation:
        r'''El astato, un halógeno muy escaso y radiactivo, posee el símbolo químico "At".''',
  ),
  Question(
    id: 'tab_per_d10',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿A qué se refiere la "Ley Periódica" moderna postulada a partir de los descubrimientos sobre los átomos?''',
    options: [
      r'''A que todos los metales flotan en agua.''',
      r'''A que las propiedades físicas y químicas de los elementos son funciones periódicas de sus números atómicos.''',
      r'''A que la tabla se debe organizar por colores y dureza.''',
      r'''A que los elementos cambian sus propiedades dependiendo del hemisferio terrestre.''',
      r'''A que solo los gases nobles tienen isótopos.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''La ley periódica establece que si se organizan los elementos por el orden creciente de su número atómico (y configuración electrónica), se evidencia una periodicidad y repetición sistemática en sus propiedades químicas y físicas.''',
  ),

  // Nivel Extremo
  Question(
    id: 'tab_per_e1',
    topicId: 'cta_tabla_periodica',
    text:
        r'''Según la configuración electrónica de los elementos, la tabla periódica se divide en grandes bloques. ¿Qué grupos conforman los "Metales de transición" y a qué bloque orbital pertenecen mayoritariamente?''',
    options: [
      r'''Grupos 1 y 2, pertenecen al bloque s.''',
      r'''Grupo 18, pertenecen al bloque f.''',
      r'''Grupos 13 al 17, pertenecen al bloque p.''',
      r'''Grupos del 3 al 12, se caracterizan por tener electrones en su subnivel d.''',
      r'''Son únicamente los lantánidos en el bloque g.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Los metales de transición ocupan el centro de la tabla (del Grupo 3 al 12) y su característica principal cuántica es que van llenando los orbitales del subnivel "d".''',
  ),
  Question(
    id: 'tab_per_e2',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Cuál es el elemento actual más pesado de la tabla periódica y bajo qué número atómico se ubica?''',
    options: [
      r'''Uranio (Z=92).''',
      r'''Plutonio (Z=94).''',
      r'''Laurencio (Z=103).''',
      r'''Oganesón (Z=118).''',
      r'''Californio (Z=98).''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El oganesón (Og) fue uno de los últimos elementos sintéticos añadidos a la tabla en 2016, completando el periodo 7 y siendo actualmente el elemento más pesado registrado (Z=118).''',
  ),
  Question(
    id: 'tab_per_e3',
    topicId: 'cta_tabla_periodica',
    text:
        r'''En el ámbito de las tendencias periódicas, ¿cuál es el elemento más electronegativo de toda la tabla periódica?''',
    options: [
      r'''El Francio (Fr).''',
      r'''El Oxígeno (O).''',
      r'''El Flúor (F).''',
      r'''El Cloro (Cl).''',
      r'''El Oro (Au).''',
    ],
    correctAnswer: 2,
    explanation:
        r'''En la escala de Pauling, la electronegatividad aumenta hacia arriba y a la derecha de la tabla, coronando al halógeno Flúor (F) como el elemento más electronegativo y oxidante.''',
  ),
  Question(
    id: 'tab_per_e4',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Cómo se define el concepto cuántico de "afinidad electrónica" en los elementos?''',
    options: [
      r'''El rechazo automático que tienen los metales hacia el agua.''',
      r'''La energía que un núcleo usa para absorber sus propios protones.''',
      r'''Es la energía que se libera cuando un átomo (en estado neutro y gaseoso) capta o acepta un electrón para formar un anión.''',
      r'''Es la capacidad de atraer cationes de otras moléculas.''',
      r'''El proceso por el cual un átomo se convierte en antimateria.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La afinidad electrónica es una propiedad química periódica definida como la cantidad de energía liberada cuando un átomo acepta un electrón adicional en su capa externa.''',
  ),
  Question(
    id: 'tab_per_e5',
    topicId: 'cta_tabla_periodica',
    text:
        r'''En la sección inferior de la tabla periódica (bloque f) existen dos largas filas de metales llamados Lantánidos y Actínidos. ¿Qué característica radiactiva distingue fuertemente a los Actínidos?''',
    options: [
      r'''Todos son gases a temperatura ambiente.''',
      r'''Son inertes y no interactúan con nada.''',
      r'''Todos los elementos de la familia de los actínidos son radiactivos, y muchos de ellos son sintéticos que no se encuentran en la naturaleza.''',
      r'''Son los únicos elementos sin núcleo.''',
      r'''No se pueden combinar con el oxígeno.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Los actínidos inician con el actinio y se ubican en la última fila del bloque f; su distintivo físico es que todos sus isótopos son radiactivos y gran parte son creados artificialmente en laboratorios.''',
  ),
  Question(
    id: 'tab_per_e6',
    topicId: 'cta_tabla_periodica',
    text:
        r'''Según el mapa de vulnerabilidad de la EuChemS, ¿qué preocupante fenómeno ocurre con los elementos naturales (como el Galio, Tántalo o Indio) integrados en tecnologías cotidianas como los smartphones?''',
    options: [
      r'''Son tóxicos y se están evaporando rápidamente por el calor global.''',
      r'''Explotan al ser agrupados con elementos alcalinos.''',
      r'Están bajo un severo riesgo o "peligro de extinción" debido a la elevada demanda tecnológica, lo que podría generar escasez global si no se desarrollan sistemas de reciclado agresivos.',
      r'''Son los únicos elementos sin núcleo.''',
      r'''Han perdido su configuración electrónica d debido a la radiación.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Más de la mitad de los 30 elementos usados en teléfonos móviles enfrentan niveles de disponibilidad limitada y riesgo de abastecimiento a escala mundial, lo que exige desarrollar un reciclaje agresivo de residuos electrónicos.''',
  ),
  Question(
    id: 'tab_per_e7',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué nombre recibe la familia del Grupo 16 (Oxígeno, Azufre, Selenio, Telurio, Polonio) cuyo vocablo de origen griego denota su tendencia a "formar compuestos ácidos o básicos a ambos lados"?''',
    options: [
      r'''Pnicógenos.''',
      r'''Tierras raras.''',
      r'''Transactínidos.''',
      r'''Anfígenos o Calcógenos.''',
      r'''Carbonoideos.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El grupo 16 se denomina "calcógenos" o "anfígenos"; el vocablo griego amphi (a ambos lados) y genos (producir) refleja la capacidad de elementos como el oxígeno o azufre de originar sustancias ácidas y básicas.''',
  ),
  Question(
    id: 'tab_per_e8',
    topicId: 'cta_tabla_periodica',
    text:
        r'''¿Qué regla observó el químico John Newlands en 1865, al ordenar los elementos por masa atómica, en su famoso pero primitivo intento de clasificación llamado "Ley de las Octavas"?''',
    options: [
      r'''Que las propiedades químicas de los elementos parecían repetirse cíclicamente cada ocho elementos, de manera análoga a las octavas musicales.''',
      r'''Que todos los elementos pesaban exactamente lo mismo multiplicados por ocho.''',
      r'''Que el carbono tenía ocho isótopos.''',
      r'''Que la tabla solo podía contener ochenta elementos en total.''',
      r'''Que los electrones de valencia siempre eran ocho para los metales.''',
    ],
    correctAnswer: 0,
    explanation:
        r'''Newlands planteó la Ley de las Octavas al darse cuenta de que, ordenando por peso atómico creciente, el octavo elemento mostraba propiedades químicas similares al primero del grupo anterior, de forma análoga a una octava musical.''',
  ),
  Question(
    id: 'tab_per_e9',
    topicId: 'cta_tabla_periodica',
    text:
        r'''Químicamente, ¿qué proceso metabólico y radiactivo experimentan en su núcleo aquellos átomos superpesados y sobrecargados de protones que se repelen entre sí (como el Uranio)?''',
    options: [
      r'''Sublimación inversa atómica.''',
      r'''Formación de enlaces de hidrógeno.''',
      r'''Electronegatividad infinita.''',
      r'''Desintegración radiactiva, proceso por el cual el núcleo inestable emite partículas y energía para equilibrarse.''',
      r'''Congelamiento de positrones atómicos.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Los núcleos de átomos muy grandes (como uranio o actínidos sintéticos) tienen tantos protones que la repulsión electromagnética supera la fuerza nuclear, provocando que se estabilicen mediante la desintegración radiactiva emitiendo partículas y radiación.''',
  ),
  Question(
    id: 'tab_per_e10',
    topicId: 'cta_tabla_periodica',
    text:
        r'''A principios de la década de 1960, el descubrimiento del científico Neil Bartlett desmintió una creencia dogmática sobre los "Gases Inertes" (Gases Nobles). ¿Qué logró demostrar Bartlett?''',
    options: [
      r'''Que eran metales líquidos altamente corrosivos en secreto.''',
      r'''Que su núcleo estaba compuesto por antimateria.''',
      r'Que, bajo condiciones muy específicas de laboratorio, estos gases (que se creían totalmente no reactivos) sí pueden reaccionar y formar compuestos químicos.',
      r'''Que el Helio y el Neón podían respirarse en lugar del Oxígeno.''',
      r'''Que su símbolo atómico cambiaba al contacto con la luz.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Los gases del grupo 18 eran llamados inertes asumiendo que jamás reaccionaban. Neil Bartlett demostró (sintetizando fluoroplatinato de xenón) que, bajo ciertas presiones y reactivos extremos, estos gases sí pueden reaccionar y generar compuestos.''',
  ),
];
