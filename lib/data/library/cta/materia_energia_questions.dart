import 'package:learn/models/question.dart';

final List<Question> materiaEnergiaQuestions = [
  // Nivel Fácil
  Question(
    id: 'mat_ener_f1',
    topicId: 'cta_materia_energia',
    text: r'''¿Qué es la materia?''',
    options: [
      r'''La fuerza de gravedad de la Tierra.''',
      r'''La capacidad de realizar un trabajo.''',
      r'''Todo lo que tiene masa, ocupa un espacio y puede convertirse en energía.''',
      r'''La luz que emiten las estrellas.''',
      r'''El espacio vacío en el universo.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La materia es todo aquello que posee masa y volumen, y según la física moderna es interconvertible con la energía.''',
  ),
  Question(
    id: 'mat_ener_f2',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuáles son los estados de la materia más comunes en condiciones terrestres?''',
    options: [
      r'''Condensado, luz, fotón.''',
      r'''Sólido, líquido y gaseoso.''',
      r'''Radiante, eléctrico, magnético.''',
      r'''Fusión, ebullición, sublimación.''',
      r'''Extensivo, intensivo, mixto.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''En la Tierra, la materia se presenta habitualmente en estados sólido, líquido y gaseoso.''',
  ),
  Question(
    id: 'mat_ener_f3',
    topicId: 'cta_materia_energia',
    text: r'''¿Qué es la energía?''',
    options: [
      r'''La cantidad de electrones de un átomo.''',
      r'''El volumen que ocupa un cuerpo.''',
      r'''La resistencia de un objeto a moverse.''',
      r'''La capacidad de la materia para producir trabajo mecánico, movimiento, calor o luz.''',
      r'''El estado de agregación de un líquido.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''La energía se define clásicamente como la capacidad para realizar un trabajo o producir cambios en la materia.''',
  ),
  Question(
    id: 'mat_ener_f4',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué establece la Primera Ley de la termodinámica sobre la energía?''',
    options: [
      r'''Que la energía se agota rápidamente.''',
      r'''Que la energía se crea de la nada.''',
      r'''Que la energía no puede crearse ni destruirse, sino que se transforma de un tipo a otro.''',
      r'''Que toda la energía se convierte en luz.''',
      r'''Que la energía no sirve si no es eléctrica.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La ley de conservación de la energía indica que la energía total de un sistema aislado permanece constante; solo se transforma.''',
  ),
  Question(
    id: 'mat_ener_f5',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué propiedad general de la materia mide la cantidad de materia de un cuerpo?''',
    options: [
      r'''El volumen.''',
      r'''La temperatura.''',
      r'''La masa.''',
      r'''La inercia.''',
      r'''El peso.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La masa es la magnitud física que expresa la cantidad de materia que contiene un cuerpo.''',
  ),
  Question(
    id: 'mat_ener_f6',
    topicId: 'cta_materia_energia',
    text: r'''¿Cómo se define el volumen de un objeto?''',
    options: [
      r'''La suma de protones y neutrones.''',
      r'''La capacidad de deformarse y recuperar su forma.''',
      r'''La cantidad de espacio tridimensional que ocupa (encierra) un objeto.''',
      r'''La aceleración debida a la gravedad.''',
      r'''El grado de agitación térmica.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El volumen es la medida del espacio que ocupa un cuerpo en tres dimensiones.''',
  ),
  Question(
    id: 'mat_ener_f7',
    topicId: 'cta_materia_energia',
    text: r'''¿Cuál es la diferencia principal entre masa y peso?''',
    options: [
      r'''Son exactamente la misma medida.''',
      r'''El peso se mide en kilogramos y la masa en Newtons.''',
      r'''La masa es invariable, mientras que el peso es la fuerza gravitatoria que actúa sobre un cuerpo y depende del lugar.''',
      r'''La masa es una propiedad química y el peso es física.''',
      r'''El peso solo existe en los líquidos.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La masa es intrínseca a la materia y no cambia. El peso depende de la aceleración de la gravedad del lugar donde se mida.''',
  ),
  Question(
    id: 'mat_ener_f8',
    topicId: 'cta_materia_energia',
    text: r'''Menciona un ejemplo cotidiano de transformación de energía.''',
    options: [
      r'''El agua congelándose en hielo.''',
      r'''Una piedra inmóvil en el suelo.''',
      r'''El uso de una linterna a pilas, donde la energía química pasa a eléctrica y luego a radiante.''',
      r'''Un libro cerrado sobre una mesa.''',
      r'''El oxígeno en el aire.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''En una linterna, la energía química de la pila se convierte en energía eléctrica, que a su vez se convierte en luz (energía radiante).''',
  ),
  Question(
    id: 'mat_ener_f9',
    topicId: 'cta_materia_energia',
    text:
        r'''¿En qué unidades del Sistema Internacional (SI) se mide la masa?''',
    options: [
      r'''En litros.''',
      r'''En Newtons.''',
      r'''En Kelvin.''',
      r'''En el kilogramo.''',
      r'''En metros cúbicos.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El kilogramo (kg) es la unidad base de masa en el Sistema Internacional de Unidades.''',
  ),
  Question(
    id: 'mat_ener_f10',
    topicId: 'cta_materia_energia',
    text:
        r'''¿De qué están compuestas principalmente las moléculas que forman la materia?''',
    options: [
      r'''De células vivas.''',
      r'''De fotones.''',
      r'''De plasmas.''',
      r'''De combinaciones de átomos.''',
      r'''De antimateria.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Las moléculas son estructuras formadas por la unión de dos o más átomos mediante enlaces químicos.''',
  ),

  // Nivel Medio
  Question(
    id: 'mat_ener_m1',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuál es la diferencia fundamental entre las propiedades extensivas y las intensivas?''',
    options: [
      r'''Las extensivas miden peso, las intensivas volumen.''',
      r'''Las extensivas son siempre químicas y las intensivas físicas.''',
      r'''Las extensivas dependen de la cantidad de materia presente, y las intensivas no dependen de esta cantidad.''',
      r'''Las extensivas se usan en gases, las intensivas en sólidos.''',
      r'''Las intensivas miden el espacio, las extensivas la gravedad.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Las extensivas (masa, volumen) varían con la cantidad de sustancia, mientras que las intensivas (densidad, temperatura) son constantes independientemente de la cantidad.''',
  ),
  Question(
    id: 'mat_ener_m2',
    topicId: 'cta_materia_energia',
    text: r'''Da dos ejemplos de propiedades intensivas de la materia.''',
    options: [
      r'''Masa y volumen.''',
      r'''Inercia y peso.''',
      r'''Dureza y densidad.''',
      r'''Longitud y elasticidad.''',
      r'''Energía total y área.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La dureza y la densidad no cambian si tienes una pequeña o gran cantidad de material, por lo que son propiedades intensivas.''',
  ),
  Question(
    id: 'mat_ener_m3',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué es una propiedad física y cómo se diferencia de una propiedad química?''',
    options: [
      r'''La propiedad física describe cambios en la estructura y la química no.''',
      r'''Las propiedades físicas se observan o miden sin alterar la composición química de la sustancia, a diferencia de las químicas.''',
      r'''Las propiedades físicas solo aplican a los metales.''',
      r'''Las propiedades químicas dependen del tamaño del objeto.''',
      r'''No existe diferencia real.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Medir el punto de fusión (física) no cambia la sustancia, mientras que observar la combustión (química) sí la transforma.''',
  ),
  Question(
    id: 'mat_ener_m4',
    topicId: 'cta_materia_energia',
    text: r'''Menciona tres ejemplos de propiedades químicas de la materia.''',
    options: [
      r'''Textura, fragilidad, ductilidad.''',
      r'''Temperatura, elasticidad, inercia.''',
      r'''pH, combustión, estado de oxidación.''',
      r'''Punto de fusión, solubilidad, conductibilidad.''',
      r'''Volumen, masa, peso.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El pH, la inflamabilidad (combustión) y la capacidad de oxidación requieren que la sustancia sufra un cambio químico para ser observadas.''',
  ),
  Question(
    id: 'mat_ener_m5',
    topicId: 'cta_materia_energia',
    text: r'''¿En qué consiste el proceso de sublimación?''',
    options: [
      r'''El paso de estado líquido a gaseoso.''',
      r'''El endurecimiento de un líquido para ser sólido.''',
      r'''Es el paso directo de sólido a gas sin pasar por el estado líquido.''',
      r'''El paso de gas a plasma mediante calor.''',
      r'''El paso de gas a sólido por frío.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La sublimación ocurre en sustancias como el hielo seco (CO2 sólido) que pasa a gas directamente al absorber calor ambiental.''',
  ),
  Question(
    id: 'mat_ener_m6',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuál es la diferencia entre energía potencial y energía cinética?''',
    options: [
      r'''La potencial es calorífica, la cinética es sonora.''',
      r'''La energía potencial es la que está almacenada en un cuerpo según su posición o estado, y la cinética está asociada al movimiento.''',
      r'''La energía cinética no se transforma.''',
      r'''La potencial depende de los electrones y la cinética de los neutrones.''',
      r'''La energía cinética siempre es nuclear.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Un objeto en alto tiene energía potencial gravitatoria (almacenada). Al caer, esta se convierte en energía cinética (movimiento).''',
  ),
  Question(
    id: 'mat_ener_m7',
    topicId: 'cta_materia_energia',
    text: r'''¿Qué tipo de energía es el calor y a qué está asociado?''',
    options: [
      r'''Energía electromagnética asociada a la luz.''',
      r'''Energía nuclear asociada al núcleo del átomo.''',
      r'''Energía potencial asociada a resortes.''',
      r'''Energía térmica, que está asociada directamente al movimiento de átomos y moléculas.''',
      r'''Energía sonora asociada a la vibración del aire.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''A nivel microscópico, el calor es la energía cinética promedio del movimiento y vibración de las partículas (átomos y moléculas).''',
  ),
  Question(
    id: 'mat_ener_m8',
    topicId: 'cta_materia_energia',
    text: r'''¿Qué es el proceso de condensación de la materia?''',
    options: [
      r'''Cuando las partículas de un sólido se expanden.''',
      r'''El cambio directo de sólido a gas.''',
      r'''Cuando la temperatura baja o la presión aumenta, causando que el gas pase a estado líquido.''',
      r'''La pérdida de carga energética en el plasma.''',
      r'''El paso de líquido a sólido.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La condensación es el cambio de estado de gas a líquido, como ocurre con el vapor de agua en contacto con una superficie fría.''',
  ),
  Question(
    id: 'mat_ener_m9',
    topicId: 'cta_materia_energia',
    text:
        r'''Define qué son las fuentes de energía renovables y menciona dos ejemplos.''',
    options: [
      r'''Recursos limitados que se agotan con su uso; carbón y gas.''',
      r'''Energías que se regeneran de forma natural y no se agotan; solar y eólica.''',
      r'''Energías creadas en laboratorio; nuclear y magnética.''',
      r'''Combustibles extraídos del subsuelo; petróleo y biomasa.''',
      r'''Son únicamente las que provienen del movimiento del mar.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Las fuentes renovables, como el sol o el viento, son aquellas que provienen de recursos naturales virtualmente inagotables.''',
  ),
  Question(
    id: 'mat_ener_m10',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Por qué el petróleo y el carbón son considerados fuentes de energía no renovables?''',
    options: [
      r'''Porque no producen calor suficiente.''',
      r'''Porque no se encuentran en la Tierra.''',
      r'''Porque provienen de la descomposición orgánica de hace millones de años, son recursos limitados y se agotan con su uso.''',
      r'''Porque no pueden ser transportados fácilmente.''',
      r'''Porque su uso no contamina.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La tasa de consumo humano de los combustibles fósiles supera por millones de años a su lentísimo proceso natural de formación.''',
  ),

  // Nivel Difícil
  Question(
    id: 'mat_ener_d1',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué es el estado de plasma y cómo se origina a partir de un gas?''',
    options: [
      r'''Es un líquido superenfriado.''',
      r'''Es el gas que respiran las plantas.''',
      r'''Es la unión de varios metales nobles.''',
      r'''Es un gas ionizado a alta temperatura, generado cuando un gas se calienta y sus partículas se convierten en iones (cationes y electrones libres).''',
      r'''Es un sólido que se derrite rápidamente.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Al calentar un gas a temperaturas extremas, las colisiones arrancan los electrones de los átomos, generando el plasma.''',
  ),
  Question(
    id: 'mat_ener_d2',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Por qué se dice que el plasma es un conductor de electricidad si es eléctricamente neutro en su conjunto?''',
    options: [
      r'''Porque contiene mucho metal en su interior.''',
      r'''Porque es lo mismo que un cable de cobre.''',
      r'''Porque sus partículas individuales (iones y electrones) tienen carga eléctrica, lo que le permite conducir electricidad.''',
      r'''Porque siempre está congelado.''',
      r'''Porque rechaza los campos magnéticos.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Aunque el plasma tiene igual cantidad de cargas positivas y negativas (neutro a gran escala), sus portadores de carga libres permiten que fluya corriente.''',
  ),
  Question(
    id: 'mat_ener_d3',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué sucede cuando la materia común y la antimateria se encuentran?''',
    options: [
      r'''Se congelan instantáneamente.''',
      r'''Se vuelven invisibles y forman materia oscura.''',
      r'''Se aniquilan mutuamente liberando energía.''',
      r'''Se repelen como imanes.''',
      r'''Forman un gas noble.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El contacto entre materia y antimateria resulta en una aniquilación total, convirtiendo su masa combinada al 100% en energía pura (rayos gamma).''',
  ),
  Question(
    id: 'mat_ener_d4',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué característica principal define a la materia oscura y cómo detectan los científicos su presencia?''',
    options: [
      r'''Es muy brillante y se ve con telescopios ópticos.''',
      r'''Emite fuertes ondas de sonido en el espacio.''',
      r'''Es invisible porque no interactúa con la luz, pero se detecta por sus efectos gravitacionales en objetos visibles.''',
      r'''Está compuesta completamente de protones y neutrones líquidos.''',
      r'''Es la energía química de las estrellas.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La materia oscura no emite, absorbe ni refleja luz, pero su enorme masa ejerce una fuerte atracción gravitacional sobre galaxias visibles.''',
  ),
  Question(
    id: 'mat_ener_d5',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué establece la Segunda Ley de la Termodinámica sobre las transformaciones de energía?''',
    options: [
      r'''Que siempre se recupera el 100% de la energía empleada.''',
      r'''Que la energía cinética es la única energía útil.''',
      r'''Que el uso de la energía siempre la hace menos útil, perdiéndose en el proceso una cantidad en forma de energía térmica de baja temperatura.''',
      r'''Que la energía eléctrica siempre destruye materia.''',
      r'''Que no existe la energía potencial.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''En toda transformación energética, la entropía del universo aumenta. Parte de la energía se dispersa como calor no aprovechable.''',
  ),
  Question(
    id: 'mat_ener_d6',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Por qué la energía térmica de baja temperatura se considera la forma de energía menos útil?''',
    options: [
      r'''Porque genera demasiado movimiento mecánico.''',
      r'''Porque congela los sistemas.''',
      r'''Porque al intentar volver a convertirla en una forma de alta calidad, la energía útil siempre se pierde y nunca se recupera el 100%.''',
      r'''Porque siempre es radiactiva.''',
      r'''Porque reacciona con antimateria.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El calor de baja temperatura está altamente desordenado (entropía alta), lo que impide usarlo de forma eficiente para generar trabajo mecánico.''',
  ),
  Question(
    id: 'mat_ener_d7',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué es una propiedad física superveniente y por qué el color es un ejemplo de ella?''',
    options: [
      r'''Es una propiedad que cambia el volumen de los gases.''',
      r'''Es una medida exacta universal como la masa.''',
      r'''Es una propiedad basada en hechos físicos reales pero que no se puede determinar de forma clara por estar sujeta a aspectos secundarios o de interpretación particular, como la percepción del color.''',
      r'''Es el punto de fusión de los sólidos.''',
      r'''Es la capacidad de resistir rayaduras.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El color surge de la interacción de la luz (físico), pero su percepción final depende del cerebro del observador (superveniencia).''',
  ),
  Question(
    id: 'mat_ener_d8',
    topicId: 'cta_materia_energia',
    text:
        r'''Define el "potencial de ionización" como propiedad química de la materia.''',
    options: [
      r'''La capacidad de crear calor por combustión.''',
      r'''La velocidad a la que un gas se condensa.''',
      r'''Es la energía necesaria para separar a un electrón de un átomo.''',
      r'''Es el nivel de acidez de una disolución (pH).''',
      r'''Es la resistencia de un material a ser rayado.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El potencial o energía de ionización es la cantidad de energía requerida para arrancar el electrón más externo de un átomo gaseoso y aislado.''',
  ),
  Question(
    id: 'mat_ener_d9',
    topicId: 'cta_materia_energia',
    text:
        r'''En términos termodinámicos, ¿qué es la eficiencia energética de un sistema?''',
    options: [
      r'''Consumir la mayor cantidad de combustibles fósiles en el menor tiempo.''',
      r'''La capacidad de crear energía de la nada.''',
      r'''El desafío de minimizar el desperdicio de energía (como calor) y ser lo más eficiente posible en las conversiones.''',
      r'''Producir únicamente energía térmica de baja temperatura.''',
      r'''El uso de baterías químicas contaminantes.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La eficiencia es el cociente entre la energía útil obtenida y la energía total invertida, maximizando el rendimiento del proceso.''',
  ),
  Question(
    id: 'mat_ener_d10',
    topicId: 'cta_materia_energia',
    text:
        r'''¿En qué consiste el proceso de deposición o sublimación inversa?''',
    options: [
      r'''En el paso de sólido a plasma.''',
      r'''En enfriar un gas para volverlo líquido.''',
      r'''Es el cambio directo de un gas a sólido, por ejemplo, cuando se expone rápidamente a temperaturas muy bajas formando nieve o escarcha.''',
      r'''En separar el núcleo de un átomo.''',
      r'''En ionizar un gas con electricidad.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La deposición ocurre cuando el vapor se convierte directamente en sólido, saltándose la fase líquida, como la formación de escarcha.''',
  ),

  // Nivel Extremo
  Question(
    id: 'mat_ener_e1',
    topicId: 'cta_materia_energia',
    text:
        r'''Si un astronauta tiene una masa de 80 kg en la Tierra, ¿cuál será su masa y cómo variará su peso en la Luna justificando matemáticamente la respuesta?''',
    options: [
      r'''Su masa bajará a 13 kg y su peso será mayor.''',
      r'''Su masa y peso serán exactamente iguales en ambos lugares.''',
      r'''Su masa será de 80 kg invariablemente, pero su peso ($F_g = m \cdot g$) será mucho menor porque la aceleración de gravedad ($g$) en la Luna es menor que los 9,8 $m/s^2$ de la Tierra.''',
      r'''Su masa subirá a 160 kg y no tendrá peso.''',
      r'''Su masa será 80 kg y su peso será cero.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La masa (80 kg) es intrínseca. El peso es una fuerza: Peso = m × g. Como g en la Luna es aprox. 1.62 m/s², el peso lunar será mucho menor que en la Tierra (9.8 m/s²).''',
  ),
  Question(
    id: 'mat_ener_e2',
    topicId: 'cta_materia_energia',
    text:
        r'''Calcula de forma teórica el volumen de un cilindro de materia si conoces su radio ($r$) y su altura ($h$). ¿En qué unidad del Sistema Internacional debe expresarse?''',
    options: [
      r'''$V = m/d$, en gramos por centímetro cúbico.''',
      r'''$V = l \cdot a \cdot e$, en metros cuadrados.''',
      r'''Se calcula con la fórmula $V = \pi \cdot r^2 \cdot h$ y en el SI debe expresarse en metros cúbicos ($m^3$).''',
      r'''$V = 4/3 \pi \cdot r^3$, en litros.''',
      r'''$V = m \cdot g$, en Newtons.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El volumen de un cilindro depende del área de su base circular (πr²) multiplicada por su altura (h). La unidad estándar del SI es el m³.''',
  ),
  Question(
    id: 'mat_ener_e3',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué papel juegan los "electrones de valencia" en la ubicación de un elemento dentro de un grupo o familia de la tabla periódica?''',
    options: [
      r'''Determinan exclusivamente el número de protones y por ende el período.''',
      r'''Son inútiles para la clasificación moderna.''',
      r'''Son los electrones en la capa de energía más externa que determinan las propiedades físicas/químicas y justifican su agrupación vertical (familia) en la tabla.''',
      r'''Indican cuántos enlaces radiactivos tiene el elemento.''',
      r'''Diferencian la materia de la antimateria.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Los electrones del último nivel energético (valencia) definen cómo interactúa un átomo químicamente, siendo la base para clasificar los elementos en columnas (grupos/familias).''',
  ),
  Question(
    id: 'mat_ener_e4',
    topicId: 'cta_materia_energia',
    text:
        r'''Teniendo en cuenta la relación entre masa y energía en la física moderna, ¿cómo se concibe la naturaleza interdependiente de ambas magnitudes?''',
    options: [
      r'''Son magnitudes completamente ajenas que se anulan entre sí.''',
      r'''No son entidades aisladas, sino que toda materia tiene la capacidad intrínseca de transformarse en energía, siendo manifestaciones de un mismo tejido físico regido por leyes de conservación.''',
      r'''La masa destruye a la energía térmica.''',
      r'''Ambas aumentan cuando la temperatura disminuye.''',
      r'''La energía se mide en kilos y la masa en julios.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''Según la ecuación E = mc² de Einstein, la masa y la energía son manifestaciones diferentes de una misma realidad física, y bajo condiciones extremas pueden transformarse una en otra.''',
  ),
  Question(
    id: 'mat_ener_e5',
    topicId: 'cta_materia_energia',
    text:
        r'''Describe el proceso por el cual el proyecto europeo 3DScavenger propone utilizar la energía cinética y mecánica producida por el cuerpo humano.''',
    options: [
      r'''Instalando paneles solares en la ropa.''',
      r'''Usando baterías de uranio.''',
      r'''Mediante la microgeneración, recolectando energía de fuentes locales (fricción, calor o energía cinética al andar) para autoabastecer pequeños dispositivos electrónicos de forma autónoma.''',
      r'''Inyectando electrones libres en el torrente sanguíneo.''',
      r'''Hirviendo agua corporal para mover turbinas.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Este tipo de proyectos de "energy harvesting" buscan capturar minúsculas cantidades de energía disipada en el entorno para dar autonomía a sensores y dispositivos wearables.''',
  ),
  Question(
    id: 'mat_ener_e6',
    topicId: 'cta_materia_energia',
    text:
        r'''Si un metal posee alta "ductilidad" y "maleabilidad", ¿cómo se comportan sus enlaces atómicos o estructura frente a la tensión mecánica sin fracturarse?''',
    options: [
      r'''Los átomos se rompen y liberan neutrones.''',
      r'''El material se convierte inmediatamente en polvo y sublima.''',
      r'''Los átomos permiten la deformación de la estructura bajo fuerza para formar hilos o láminas sin oponer tanta resistencia a la ruptura frágil.''',
      r'''Se convierten en gases ionizados.''',
      r'''Producen un estado de oxidación extremo.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El enlace metálico permite que los planos de átomos se deslicen unos sobre otros sin que se rompa la unión general, lo que permite formar hilos (ductilidad) y láminas (maleabilidad).''',
  ),
  Question(
    id: 'mat_ener_e7',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Por qué en la ciencia termodinámica la temperatura debe medirse en la escala Kelvin en lugar de grados Celsius para evitar valores negativos?''',
    options: [
      r'''Porque a los científicos europeos no les gusta la escala Celsius.''',
      r'''Porque mide la energía potencial de un líquido.''',
      r'''Porque el cero Kelvin marca el cero absoluto donde el movimiento molecular cesa, alineándose con el grado de agitación térmica sin arrojar valores negativos matemáticos.''',
      r'''Porque solo se usa para calcular el volumen de gases nobles.''',
      r'''Porque un grado Kelvin equivale a diez grados Celsius.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La escala Kelvin es absoluta. Cero Kelvin significa la ausencia teórica de energía cinética molecular, por lo tanto no existen valores negativos que distorsionen las fórmulas termodinámicas.''',
  ),
  Question(
    id: 'mat_ener_e8',
    topicId: 'cta_materia_energia',
    text:
        r'''Explica el concepto físico de "inercia" en relación con la masa como resistencia al cambio en el estado de movimiento rectilíneo.''',
    options: [
      r'''La inercia acelera los cuerpos en reposo.''',
      r'''Es la fuerza magnética del núcleo atómico.''',
      r'''Es la propiedad por la cual un cuerpo intenta mantener su estado de reposo o velocidad constante, y la masa es la medida que cuantifica esta resistencia.''',
      r'''Es la capacidad de transformarse en plasma a altas velocidades.''',
      r'''Es un tipo de energía cinética.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La inercia es la tendencia natural de un cuerpo a resistir aceleraciones, y la masa inercial es el valor numérico que indica cuán fuerte es dicha resistencia.''',
  ),
  Question(
    id: 'mat_ener_e9',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuál es el rol del "estado de oxidación" de un átomo al momento de determinar su reactividad química con otra sustancia?''',
    options: [
      r'''Mide exactamente la temperatura de fusión.''',
      r'''Indica si la sustancia flota en agua.''',
      r'''Refleja el grado de oxidación y determina su capacidad para ceder o ganar electrones y alterar su estructura interna al formar enlaces químicos.''',
      r'''Mide la cantidad de masa por unidad de volumen.''',
      r'''Solo se aplica a las energías renovables.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El estado de oxidación indica la cantidad teórica de electrones que un átomo ha perdido o ganado, lo cual define cómo reaccionará en procesos redox frente a otros compuestos.''',
  ),
  Question(
    id: 'mat_ener_e10',
    topicId: 'cta_materia_energia',
    text:
        r'''Detalla el proceso químico por el cual un gas ionizado experimenta el proceso de "desionización" para volver a su estado base.''',
    options: [
      r'''Un sólido sublima debido a una fuente de calor intensa.''',
      r'''Un líquido se congela liberando protones.''',
      r'''El plasma, cargado eléctricamente, se enfría y sus partículas pierden la carga energética y recombinan electrones, regresando al estado gaseoso.''',
      r'''La materia colisiona con la antimateria.''',
      r'''El gas absorbe agua y genera conductibilidad.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La desionización ocurre cuando las partículas de plasma pierden energía cinética (por ej. enfriándose), permitiendo que los electrones libres sean capturados de nuevo por los núcleos, formando gas neutro.''',
  ),

  // Nivel Fácil Adicionales (11-20)
  Question(
    id: 'mat_ener_f11',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué estado de la materia se caracteriza por tener una forma y un volumen definidos y constantes?''',
    options: [r'Líquido.', r'Gaseoso.', r'Sólido.', r'Plasma.', r'Condensado.'],
    correctAnswer: 2,
    explanation:
        r'''El estado sólido es aquel que tiene una forma y un volumen definidos y estables debido a la fuerte atracción entre sus partículas.''',
  ),
  Question(
    id: 'mat_ener_f12',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuál de las siguientes opciones es un ejemplo de energía cinética en acción?''',
    options: [
      r'Una batería apagada.',
      r'Una piedra inmóvil en el suelo.',
      r'Un muelle comprimido.',
      r'Una corriente eléctrica o el viento en movimiento.',
      r'Un litro de gasolina en un barril.',
    ],
    correctAnswer: 3,
    explanation:
        r'''La energía cinética es la asociada al movimiento. Por lo tanto, el viento en movimiento o una corriente eléctrica son ejemplos claros de esta energía.''',
  ),
  Question(
    id: 'mat_ener_f13',
    topicId: 'cta_materia_energia',
    text:
        r'''Según las fuentes de energía, ¿cuál de los siguientes es un ejemplo de fuente renovable?''',
    options: [
      r'Petróleo.',
      r'Gas natural.',
      r'Carbón.',
      r'Uranio (Energía nuclear).',
      r'Luz solar (Energía solar).',
    ],
    correctAnswer: 4,
    explanation:
        r'''Las fuentes renovables son aquellas virtualmente inagotables, como la luz solar (energía solar) y el viento.''',
  ),
  Question(
    id: 'mat_ener_f14',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué nombre recibe el proceso físico por el cual la materia pasa de estado líquido a estado sólido?''',
    options: [
      r'Vaporización.',
      r'Fusión.',
      r'Condensación.',
      r'Solidificación.',
      r'Sublimación.',
    ],
    correctAnswer: 3,
    explanation:
        r'''El cambio de estado líquido a sólido por enfriamiento se denomina solidificación.''',
  ),
  Question(
    id: 'mat_ener_f15',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuál es el principal astro responsable de aportar casi toda la energía a nuestro planeta?''',
    options: [
      r'La Luna.',
      r'Júpiter.',
      r'El Sol.',
      r'Marte.',
      r'El centro de la Vía Láctea.',
    ],
    correctAnswer: 2,
    explanation:
        r'''El Sol es la principal fuente de energía lumínica y térmica de nuestro planeta, impulsando la vida y el clima.''',
  ),
  Question(
    id: 'mat_ener_f16',
    topicId: 'cta_materia_energia',
    text:
        r'''De acuerdo a la física elemental, ¿qué propiedad de la materia se define como el espacio tridimensional que encierra un objeto?''',
    options: [
      r'El peso.',
      r'La inercia.',
      r'El volumen.',
      r'La masa.',
      r'La divisibilidad.',
    ],
    correctAnswer: 2,
    explanation:
        r'''El volumen es la medida del espacio ocupado por un cuerpo en tres dimensiones.''',
  ),
  Question(
    id: 'mat_ener_f17',
    topicId: 'cta_materia_energia',
    text: r'''¿Qué tipo de energía es la energía potencial?''',
    options: [
      r'La que produce sonido a través del aire.',
      r'Aquella que está almacenada en un cuerpo dependiendo de su posición o estado.',
      r'La que fluye únicamente en las reacciones nucleares.',
      r'La que se asocia siempre al movimiento rápido.',
      r'La energía térmica de alta temperatura.',
    ],
    correctAnswer: 1,
    explanation:
        r'''La energía potencial es energía almacenada debido a la configuración o posición de un objeto, como la altura o la deformación elástica.''',
  ),
  Question(
    id: 'mat_ener_f18',
    topicId: 'cta_materia_energia',
    text:
        r'''En la vida diaria, el uso de una plancha para la ropa ejemplifica la transformación de:''',
    options: [
      r'Energía eléctrica a energía térmica.',
      r'Energía química a energía potencial.',
      r'Energía nuclear a energía luminosa.',
      r'Energía sonora a energía mecánica.',
      r'Energía magnética a energía hidroeléctrica.',
    ],
    correctAnswer: 0,
    explanation:
        r'''La plancha funciona mediante el paso de electricidad a través de una resistencia que produce calor (transformación de energía eléctrica a térmica).''',
  ),
  Question(
    id: 'mat_ener_f19',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuál de las siguientes afirmaciones sobre los combustibles fósiles es correcta?''',
    options: [
      r'Se regeneran todos los días de forma natural.',
      r'Provienen directamente de la luz del sol convertida en metal.',
      r'Provienen de la descomposición orgánica de hace millones de años y se agotan con su uso.',
      r'Son la fuente de energía más limpia y menos contaminante del planeta.',
      r'Son un ejemplo de energía undimotriz.',
    ],
    correctAnswer: 2,
    explanation:
        r'''Los combustibles fósiles como el carbón, gas y petróleo provienen de antiguos restos orgánicos y tardan millones de años en formarse, por lo que son no renovables.''',
  ),
  Question(
    id: 'mat_ener_f20',
    topicId: 'cta_materia_energia',
    text:
        r'''Si un cuerpo material no tiene forma fija, pero su volumen es constante y se adapta a la forma del recipiente que lo contiene, se encuentra en estado:''',
    options: [
      r'Sólido.',
      r'Gaseoso.',
      r'Líquido.',
      r'Plasmático.',
      r'Metálico.',
    ],
    correctAnswer: 2,
    explanation:
        r'''El estado líquido se caracteriza por no tener una forma fija (se adapta al recipiente), pero manteniendo un volumen definido y constante.''',
  ),

  // Nivel Medio Adicionales (11-20)
  Question(
    id: 'mat_ener_m11',
    topicId: 'cta_materia_energia',
    text:
        r'''¿En qué se diferencian principalmente las propiedades intensivas de las propiedades extensivas de la materia?''',
    options: [
      r'Las intensivas miden el espacio y las extensivas la gravedad.',
      r'Las propiedades intensivas no dependen de la cantidad de sustancia, mientras que las extensivas sí dependen de la cantidad de materia.',
      r'Las extensivas se usan solo en gases y las intensivas en sólidos.',
      r'Las intensivas siempre son químicas y las extensivas físicas.',
      r'Las intensivas cambian el pH, las extensivas no.',
    ],
    correctAnswer: 1,
    explanation:
        r'''Las propiedades intensivas (como la densidad o el punto de ebullición) no dependen de la cantidad de materia, a diferencia de las extensivas (como el volumen o la masa).''',
  ),
  Question(
    id: 'mat_ener_m12',
    topicId: 'cta_materia_energia',
    text: r'''Da un ejemplo claro de propiedad intensiva de la materia.''',
    options: [
      r'La masa.',
      r'El volumen.',
      r'La densidad.',
      r'El peso.',
      r'La inercia.',
    ],
    correctAnswer: 2,
    explanation:
        r'''La densidad es una propiedad intensiva porque permanece constante sin importar la cantidad de material analizado.''',
  ),
  Question(
    id: 'mat_ener_m13',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuál es la unidad de medida científica en el Sistema Internacional para expresar la temperatura evitando los valores negativos?''',
    options: [
      r'Celsius (ºC).',
      r'Fahrenheit (ºF).',
      r'Julios (J).',
      r'Kelvin (K).',
      r'Litros (L).',
    ],
    correctAnswer: 3,
    explanation:
        r'''El Kelvin (K) es la escala de temperatura absoluta en el Sistema Internacional, cuyo cero representa el cero absoluto sin valores negativos.''',
  ),
  Question(
    id: 'mat_ener_m14',
    topicId: 'cta_materia_energia',
    text:
        r'''En un aerogenerador (molino de viento), la principal conversión energética que ocurre es:''',
    options: [
      r'Energía térmica a química.',
      r'Energía eléctrica a magnética.',
      r'Energía solar a eólica.',
      r'Energía cinética (del viento) a energía eléctrica.',
      r'Energía química a energía potencial.',
    ],
    correctAnswer: 3,
    explanation:
        r'''El aerogenerador convierte la energía cinética del viento en energía mecánica de rotación y luego en electricidad.''',
  ),
  Question(
    id: 'mat_ener_m15',
    topicId: 'cta_materia_energia',
    text:
        r'''Según la termodinámica, ¿qué diferencia existe entre el calor y la temperatura?''',
    options: [
      r'El calor es un flujo de energía térmica de un cuerpo a otro, mientras que la temperatura es la medida del grado de agitación térmica de un cuerpo.',
      r'El calor se mide en Kelvin y la temperatura en Julios.',
      r'El calor es energía potencial y la temperatura es energía química.',
      r'No hay diferencia, son exactamente el mismo concepto científico.',
      r'El calor solo ocurre en sólidos y la temperatura en líquidos.',
    ],
    correctAnswer: 0,
    explanation:
        r'''El calor es la energía térmica en tránsito, mientras que la temperatura es una propiedad intensiva del cuerpo vinculada con la agitación molecular.''',
  ),
  Question(
    id: 'mat_ener_m16',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué cambio de estado ocurre durante la vaporización o evaporación?''',
    options: [
      r'De sólido a líquido.',
      r'De gas a sólido.',
      r'De plasma a gas.',
      r'De líquido a gaseoso.',
      r'De gas a líquido.',
    ],
    correctAnswer: 3,
    explanation:
        r'''La vaporización es la transición del estado líquido al estado gaseoso.''',
  ),
  Question(
    id: 'mat_ener_m17',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué propiedad física define la resistencia que opone un cuerpo a ser rayado por otro material?''',
    options: [
      r'La elasticidad.',
      r'La ductilidad.',
      r'La dureza.',
      r'La porosidad.',
      r'La maleabilidad.',
    ],
    correctAnswer: 2,
    explanation:
        r'''En ciencia de materiales, la dureza es la medida de la resistencia a la deformación plástica localizada, por ejemplo, al rayado.''',
  ),
  Question(
    id: 'mat_ener_m18',
    topicId: 'cta_materia_energia',
    text: r'''En el proceso de fotosíntesis, las plantas logran transformar:''',
    options: [
      r'Energía química en energía eléctrica.',
      r'Energía luminosa en energía química (azúcares).',
      r'Energía térmica en energía eólica.',
      r'Energía sonora en energía metabólica.',
      r'Energía de biomasa en energía nuclear.',
    ],
    correctAnswer: 1,
    explanation:
        r'''La fotosíntesis convierte energía luminosa (fotones) en energía química almacenada en enlaces de carbohidratos.''',
  ),
  Question(
    id: 'mat_ener_m19',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Cuál delos siguientes es un ejemplo de propiedad química de la materia?''',
    options: [
      r'El punto de fusión.',
      r'La densidad volumétrica.',
      r'La conductividad térmica.',
      r'El pH (medida de acidez o alcalinidad).',
      r'La textura organoléptica.',
    ],
    correctAnswer: 3,
    explanation:
        r'''El pH es una propiedad química porque determina la reactividad ácida o básica de una sustancia al reaccionar o disociarse en agua.''',
  ),
  Question(
    id: 'mat_ener_m20',
    topicId: 'cta_materia_energia',
    text:
        r'''Si la masa de una sustancia es de 10 kg y su volumen es de 2 m³, ¿qué propiedad intensiva estamos calculando al dividir la masa entre el volumen?''',
    options: [
      r'El calor de combustión.',
      r'La densidad.',
      r'La inercia.',
      r'El potencial de ionización.',
      r'La reactividad química.',
    ],
    correctAnswer: 1,
    explanation:
        r'''La densidad es la relación entre la masa de un cuerpo y el volumen que ocupa (d = m / V).''',
  ),

  // Nivel Difícil Adicionales (11-20)
  Question(
    id: 'mat_ener_d11',
    topicId: 'cta_materia_energia',
    text:
        r'''De acuerdo con la Segunda Ley de la Termodinámica, ¿por qué es imposible crear una máquina con un 100% de eficiencia energética?''',
    options: [
      r'Porque los aparatos mecánicos destruyen la materia que usan.',
      r'Porque las leyes de gravedad se oponen a la conservación eléctrica.',
      r'Porque en todo proceso útil de transformación, inevitablemente una parte de la energía se pierde o disipa como calor de baja calidad.',
      r'Porque la energía siempre vuelve a su estado primordial cinético.',
      r'Porque requiere de un generador de fusión nuclear.',
    ],
    correctAnswer: 2,
    explanation:
        r'''La Segunda Ley de la Termodinámica establece que la entropía siempre aumenta en procesos reales, por lo que parte de la energía se disipa en forma de calor y no se puede recuperar al 100%.''',
  ),
  Question(
    id: 'mat_ener_d12',
    topicId: 'cta_materia_energia',
    text:
        r'''En la Tabla Periódica actual, ¿cómo están clasificados mayoritariamente los elementos del Grupo 18 (VIII A)?''',
    options: [
      r'Halógenos altamente reactivos.',
      r'Tierras raras y actínidos.',
      r'Metales alcalinotérreos blandos.',
      r'Gases nobles con muy baja reactividad química.',
      r'Metales de transición pirofóricos.',
    ],
    correctAnswer: 3,
    explanation:
        r'''El grupo 18 contiene a los gases nobles, que tienen una configuración electrónica completa y muy baja reactividad.''',
  ),
  Question(
    id: 'mat_ener_d13',
    topicId: 'cta_materia_energia',
    text:
        r'''A la propiedad que permite a los metales la formación de hilos o alambres sin romperse se la denomina:''',
    options: [
      r'Porosidad.',
      r'Impenetrabilidad.',
      r'Ductilidad.',
      r'Solubilidad.',
      r'Ferromagnetismo.',
    ],
    correctAnswer: 2,
    explanation:
        r'''La ductilidad es la capacidad de un metal de deformarse plásticamente bajo tracción para formar hilos o alambres.''',
  ),
  Question(
    id: 'mat_ener_d14',
    topicId: 'cta_materia_energia',
    text:
        r'''Según los estudios históricos, ¿cuál fue uno de los mayores méritos de Dmitri Mendeléyev al crear su versión de la Tabla Periódica en 1869?''',
    options: [
      r'Descubrir todos los gases nobles por sí mismo en un solo día.',
      r'Dividir el núcleo atómico en protones y neutrones.',
      r'Comprobar que el agua es una mezcla de hidrógeno y oxígeno.',
      r'Dejar huecos vacíos para elementos no descubiertos y predecir exitosamente sus propiedades (como las del galio o el germanio).',
      r'Inventar el nombre de "átomo".',
    ],
    correctAnswer: 3,
    explanation:
        r'''Mendeléyev dejó huecos en su tabla para elementos desconocidos y predijo sus propiedades con gran exactitud basándose en las tendencias periódicas.''',
  ),
  Question(
    id: 'mat_ener_d15',
    topicId: 'cta_materia_energia',
    text:
        r'''En el interior del cloroplasto celular vegetal, ¿en qué estructura específica se desarrolla la "Fase Luminosa" de la fotosíntesis?''',
    options: [
      r'En el núcleo celular.',
      r'En el estroma.',
      r'En la pared celular de celulosa.',
      r'En la membrana de los tilacoides (granas).',
      r'En las mitocondrias respiratorias.',
    ],
    correctAnswer: 3,
    explanation:
        r'''La fase luminosa ocurre en los tilacoides (que forman las granas) porque allí se encuentran la clorofila y la cadena de transporte de electrones.''',
  ),
  Question(
    id: 'mat_ener_d16',
    topicId: 'cta_materia_energia',
    text:
        r'''El proceso térmico en el que una sustancia en estado sólido pasa directamente al estado gaseoso sin transitar por la fase líquida, como ocurre con el hielo seco, se llama:''',
    options: [
      r'Condensación invertida.',
      r'Fusión nuclear.',
      r'Deposición química.',
      r'Sublimación.',
      r'Vaporización iónica.',
    ],
    correctAnswer: 3,
    explanation:
        r'''El paso directo del estado sólido al gaseoso se denomina sublimación (ej. el CO2 sólido/hielo seco).''',
  ),
  Question(
    id: 'mat_ener_d17',
    topicId: 'cta_materia_energia',
    text:
        r'''Desde el punto de vista astronómico y físico, ¿qué es la energía undimotriz?''',
    options: [
      r'La energía mecánica producida por el movimiento de las olas oceánicas.',
      r'La energía derivada de la biomasa animal.',
      r'La energía térmica generada dentro de un volcán.',
      r'La radiación que emite el viento solar hacia la ionósfera.',
      r'El uso de corrientes de aire en las llanuras para molinos.',
    ],
    correctAnswer: 0,
    explanation:
        r'''La energía undimotriz es la captura de la energía del movimiento de las olas del mar para producir electricidad.''',
  ),
  Question(
    id: 'mat_ener_d18',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué características químicas definen a los elementos halógenos (Grupo 17 de la tabla periódica)?''',
    options: [
      r'Son conductores metálicos perfectos que no reaccionan.',
      r'Son gases radiactivos sintéticos descubiertos hace una década.',
      r'Son no metales altamente reactivos, grandes "productores de sales", con tendencia a ganar un electrón.',
      r'Tienen propiedades exclusivas de los alcalinos y flotan en agua.',
      r'Son tierras raras exclusivas del interior del manto terrestre.',
    ],
    correctAnswer: 2,
    explanation:
        r'''Los halógenos (F, Cl, Br, I, At) son no metales muy reactivos con 7 electrones de valencia, por lo que ganan un electrón fácilmente y forman sales al reaccionar con metales.''',
  ),
  Question(
    id: 'mat_ener_d19',
    topicId: 'cta_materia_energia',
    text:
        r'''¿Qué factor ambiental NO es considerado fundamental para que una planta lleve a cabo una alta eficiencia fotosintética?''',
    options: [
      r'La concentración atmosférica de Dióxido de Carbono (CO2).',
      r'La temperatura del ecosistema.',
      r'La intensidad y el periodo de luz (fotoperíodo).',
      r'La contaminación acústica y los niveles de ruido del área.',
      r'La humedad ambiental y disponibilidad de agua.',
    ],
    correctAnswer: 3,
    explanation:
        r'''Las plantas no utilizan ni dependen de las ondas sonoras del ruido cotidiano para realizar la fotosíntesis, a diferencia de la luz, CO2, agua y temperatura.''',
  ),
  Question(
    id: 'mat_ener_d20',
    topicId: 'cta_materia_energia',
    text:
        r'''Astronómicamente, el estado de la materia conocido como "plasma" presenta una característica vital a diferencia de un gas convencional. ¿Cuál es?''',
    options: [
      r'Está compuesto por átomos congelados a cero absoluto.',
      r'No tiene masa ni ocupa espacio en el universo.',
      r'Está constituido por partículas con cargas iónicas y electrones libres, lo que le permite ser un excelente conductor de la electricidad.',
      r'Su volumen siempre se mantiene perfectamente cúbico.',
      r'Solo ocurre en ausencia total de energía térmica.',
    ],
    correctAnswer: 2,
    explanation:
        r'''El plasma contiene iones y electrones libres debido a su alta temperatura, lo que lo hace altamente conductor de electricidad y reactivo a campos magnéticos.''',
  ),

  // Nivel Extremo Adicionales (11-20)
  Question(
    id: 'mat_ener_e11',
    topicId: 'cta_materia_energia',
    text:
        r'''Para calcular teóricamente el peso gravitatorio exacto de un objeto sólido sobre la superficie terrestre, debemos usar la expresión $F_g = m \cdot g$. Si $m = 10 \ kg$ y $g \approx 9,8 \ m/s^2$, ¿en qué magnitud del SI debe expresarse el resultado de dicha fuerza?''',
    options: [
      r'Metros cúbicos ($m^3$).',
      r'Pascales ($Pa$).',
      r'Voltios ($V$).',
      r'Newtons ($N$).',
      r'Julios ($J$).',
    ],
    correctAnswer: 3,
    explanation:
        r'''El peso es una fuerza, y la unidad de fuerza en el Sistema Internacional es el Newton (N).''',
  ),
  Question(
    id: 'mat_ener_e12',
    topicId: 'cta_materia_energia',
    text:
        r'''En la estructura atómica moderna, ¿qué partículas elementales y qué funciones definen a un elemento como "isótopo" en contraste con un átomo estándar del mismo elemento químico?''',
    options: [
      r'Son átomos con una capa electrónica completamente vacía.',
      r'Son átomos con igual número de protones y electrones, pero carecen de núcleo central.',
      r'Tienen exactamente el mismo número atómico (protones) pero diferente número másico (difieren en su cantidad de neutrones).',
      r'Son átomos con un número infinito de orbitales "f".',
      r'Se definen exclusivamente por ser partículas de antimateria con carga inversa.',
    ],
    correctAnswer: 2,
    explanation:
        r'''Los isótopos son átomos del mismo elemento (mismo número de protones/número atómico), pero difieren en su número de neutrones (y por ende en su número másico).''',
  ),
  Question(
    id: 'mat_ener_e13',
    topicId: 'cta_materia_energia',
    text:
        r'''Durante la fase oscura de la fotosíntesis (Ciclo de Calvin), ¿cuál es el papel bioquímico de las moléculas ATP y NADPH formadas previamente?''',
    options: [
      r'Liberar oxígeno al aire mediante la fotólisis del agua.',
      r'Absorber fotones ultravioleta directamente del Sol para calentar la célula.',
      r'Funcionar como moneda energética y poder reductor para poder "fijar" el carbono inorgánico (CO2) y sintetizar azúcares (glucosa).',
      r'Digerir las proteínas y grasas del estroma mediante enzimas catabólicas.',
      r'Evaporar el agua hacia las raíces para crear la savia bruta.',
    ],
    correctAnswer: 2,
    explanation:
        r'''El ATP aporta la energía necesaria y el NADPH transfiere los electrones (poder reductor) en las reacciones del Ciclo de Calvin para fijar el CO2 en carbohidratos.''',
  ),
  Question(
    id: 'mat_ener_e14',
    topicId: 'cta_materia_energia',
    text:
        r'''Si aplicamos la física moderna ($E=mc^2$) al entendimiento material del cosmos, la materia y la energía no son entes sin relación; ¿cómo se interrelacionan conceptualmente?''',
    options: [
      r'La energía destruye la materia en un bucle infinito que rompe la inercia.',
      r'No son entidades aisladas, sino manifestaciones de un mismo tejido físico interdependiente y transformable bajo leyes de conservación.',
      r'La masa aumenta inversamente al nivel de energía química del universo.',
      r'La antimateria es la única que tiene masa pero carece de energía.',
      r'Ambas provienen únicamente de las reacciones químicas del carbono orgánico.',
    ],
    correctAnswer: 1,
    explanation:
        r'''La física relativista demostró la equivalencia entre masa y energía ($E=mc^2$), revelando que son manifestaciones alternativas de una misma entidad física elemental.''',
  ),
  Question(
    id: 'mat_ener_e15',
    topicId: 'cta_materia_energia',
    text:
        r'''Desde el ámbito de las nuevas tecnologías energéticas, ¿cuál es el principio operativo de la "microgeneración" que propone el proyecto europeo 3DScavenger?''',
    options: [
      r'Crear inmensas represas hidroeléctricas en ríos microscópicos europeos.',
      r'Utilizar la fisión de átomos de uranio en pulseras portátiles.',
      r'Recolectar energía del entorno a pequeña escala, como la fricción generada al andar o el calor de la respiración, para abastecer autónomamente pequeños dispositivos y evitar baterías contaminantes.',
      r'Absorber la energía solar con satélites espaciales y enviarla por microondas a los teléfonos.',
      r'Comprimir biomasa humana para generar gas natural portátil.',
    ],
    correctAnswer: 2,
    explanation:
        r'''La microgeneración o recolección de energía a pequeña escala (energy harvesting) del cuerpo humano o ambiente busca alimentar dispositivos de bajo consumo de forma sostenible.''',
  ),
  Question(
    id: 'mat_ener_e16',
    topicId: 'cta_materia_energia',
    text:
        r'''En la Tabla Periódica, el bloque "d" agrupa a una serie de familias muy importantes para la industria (Grupos 3 al 12). ¿Cómo se les denomina químicamente a estos elementos como el Cobre, Plata, Oro o Hierro?''',
    options: [
      r'Alcalinotérreos puros.',
      r'Gases diatómicos nobles.',
      r'Lantanoides superpesados.',
      r'Metales de transición.',
      r'Carbonoideos y nitrogenoideos líquidos.',
    ],
    correctAnswer: 3,
    explanation:
        r'''Los elementos de los grupos 3 al 12, que ocupan el bloque d, son denominados metales de transición.''',
  ),
  Question(
    id: 'mat_ener_e17',
    topicId: 'cta_materia_energia',
    text:
        r'''A nivel molecular, cuando el agua (H2O) hierve y alcanza su punto de ebullición, ¿qué ocurre físicamente con las moléculas sin llegar a afectar sus enlaces químicos internos?''',
    options: [
      r'Adquieren la suficiente agitación térmica y energía cinética para vencer la atracción intermolecular y separarse al estado gaseoso, manteniendo su composición de H2O.',
      r'El hidrógeno se funde atómicamente y el oxígeno se precipita como sólido.',
      r'Los enlaces se rompen y se genera fuego y combustión inmediata.',
      r'Pierden su inercia y se transforman directamente en antimateria por la presión atmosférica.',
      r'Se agrupan densamente hasta formar un metal líquido muy estable.',
    ],
    correctAnswer: 0,
    explanation:
        r'''En los cambios de estado físicos, como la ebullición, solo se rompen las fuerzas intermoleculares (de atracción entre moléculas), sin destruir los enlaces covalentes internos de la molécula de H2O.''',
  ),
  Question(
    id: 'mat_ener_e18',
    topicId: 'cta_materia_energia',
    text:
        r'''La electronegatividad es una tendencia periódica vital para la formación de compuestos. Según la escala de Pauling en la tabla periódica, ¿cuál de las siguientes combinaciones representa un extremo de máxima electronegatividad?''',
    options: [
      r'El Francio (Fr).',
      r'El Sodio (Na).',
      r'El Flúor (F).',
      r'El Hierro (Fe).',
      r'El Carbono (C).',
    ],
    correctAnswer: 2,
    explanation:
        r'''El Flúor es el elemento más electronegativo de la tabla periódica, con un valor de 4.0 en la escala de Pauling.''',
  ),
  Question(
    id: 'mat_ener_e19',
    topicId: 'cta_materia_energia',
    text:
        r'''Dentro de la física del universo, la "Materia Oscura" representa un gran porcentaje cósmico. ¿Qué característica fundamental le da ese nombre y la diferencia de los elementos atómicos comunes?''',
    options: [
      r'Es un gas negro visible a simple vista por los telescopios ópticos.',
      r'Refleja totalmente la luz solar funcionando como espejos cósmicos.',
      r'Es la zona del espacio exterior que absorbe todo el calor del plasma.',
      r'Es invisible y no emite ni interactúa con la radiación electromagnética (luz), infiriéndose su existencia únicamente a través de los potentes efectos gravitacionales sobre la materia visible.',
      r'Solo se compone de agrupaciones puras del isótopo de carbono en estado sólido cristalino.',
    ],
    correctAnswer: 3,
    explanation:
        r'''La materia oscura se denomina así porque no interacciona con el espectro electromagnético, lo que la hace completamente invisible; su existencia se deduce por su tirón gravitacional en galaxias.''',
  ),
  Question(
    id: 'mat_ener_e20',
    topicId: 'cta_materia_energia',
    text:
        r'''Si analizamos la estructura química de los metales, la "maleabilidad" y "ductilidad" son posibles porque sus átomos:''',
    options: [
      r'Explotan bajo presión y luego se reagrupan.',
      r'Carecen totalmente de electrones en todas sus capas de energía.',
      r'Se organizan en estructuras donde los electrones de valencia se desplazan permitiendo la deformación del enlace metálico sin provocar una ruptura rígida de los átomos.',
      r'Crean un estado ácido plasmático al golpearlos fuertemente.',
      r'Adquieren la estructura de cristal de un gas noble en condiciones terrestres.',
    ],
    correctAnswer: 2,
    explanation:
        r'''El enlace metálico se modela como una red de cationes inmersos en un mar de electrones deslocalizados móviles, lo que amortigua desplazamientos atómicos por impacto sin que se fracture el enlace.''',
  ),
];
