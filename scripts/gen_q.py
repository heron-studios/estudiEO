import re

def parse_questions(text):
    questions = []
    # Regular expression to match each question block
    pattern = re.compile(
        r'Pregunta\s+\d+:\s*(.*?)\nA\)\s*(.*?)\nB\)\s*(.*?)\nC\)\s*(.*?)\nD\)\s*(.*?)\nE\)\s*(.*?)\n\n([A-E])\)\s*Correcta\nEXP:\s*(.*?)(?=\nPregunta\s+\d+:|\Z)',
        re.DOTALL
    )
    
    matches = pattern.findall(text)
    
    for match in matches:
        question_text = match[0].strip()
        options = [match[1].strip(), match[2].strip(), match[3].strip(), match[4].strip(), match[5].strip()]
        correct_letter = match[6].strip()
        explanation = match[7].strip()
        
        # Map letter to index (A=0, B=1, C=2, D=3, E=4)
        correct_index = ord(correct_letter) - ord('A')
        
        questions.append({
            'text': question_text,
            'options': options,
            'correct_index': correct_index,
            'explanation': explanation
        })
        
    return questions

def generate_dart_code(questions_data, var_name):
    dart_code = "import 'package:learn/models/question.dart';\n\n"
    dart_code += f"final List<Question> {var_name} = [\n"
    
    for i, q in enumerate(questions_data):
        dart_code += "  Question(\n"
        dart_code += f"    id: 'narr_est_10q_q{i+1}',\n"
        dart_code += f"    topicId: 'eo_pnp_narracion_ext_10q',\n"
        dart_code += f"    text: r'''{q['text']}''',\n"
        dart_code += "    options: [\n"
        for opt in q['options']:
            dart_code += f"      r'''{opt}''',\n"
        dart_code += "    ],\n"
        dart_code += f"    correctAnswer: {q['correct_index']},\n"
        dart_code += f"    explanation: r'''{q['explanation']}''',\n"
        dart_code += "  ),\n"
        
    dart_code += "];\n"
    return dart_code

raw_text = """
Pregunta 1: Según la teoría narrativa general, ¿cuáles son los elementos fundamentales e indispensables que conforman toda narración?
A) Inicio, nudo, desenlace, moraleja y epílogo.
B) Prolepsis, analepsis, escena, pausa y sumario.
C) El narrador, los personajes, la trama (acciones), el tiempo y el espacio.
D) Protagonista, antagonista, testigo, lugar y época.
E) El autor, el lector, el mensaje, el canal y el código.

C) Correcta
EXP: Para que un texto sea considerado como una narración debe incluir una serie de elementos básicos: los personajes, el narrador, la trama o acciones, el tiempo y el espacio.

Pregunta 2: Dentro de la estructura general de la acción narrativa, ¿cómo se denomina a la parte inicial del relato donde se da a conocer a los personajes, sus objetivos y el escenario en el que se desenvuelve la historia?
A) Situación nuclear
B) Desenlace
C) Nudo
D) Introducción (o situación inicial)
E) Clímax

D) Correcta
EXP: La introducción, situación inicial o planteamiento es la parte donde se expone el contexto que antecede a la acción central y se presenta a los personajes y su entorno.

Pregunta 3: ¿Qué parte de la estructura de la trama suele ser la más extensa en los relatos largos y relata todas las acciones que realizan los protagonistas para intentar resolver el problema principal?
A) El epílogo
B) El planteamiento
C) La introducción
D) El desenlace
E) El nudo (situación nuclear)

E) Correcta
EXP: El nudo o situación nuclear es donde se desarrolla el problema que afecta a los personajes, y en relatos largos suele ser la parte más extensa formada por múltiples capítulos.

Pregunta 4: Dentro de la tipología del espacio narrativo, ¿cómo se clasifica a la atmósfera subjetiva (como la angustia, la alegría o la tristeza) en la que se ubica la acción y que se expresa en el interior de los personajes?
A) Espacio físico abierto
B) Espacio físico cerrado
C) Espacio psicológico
D) Espacio social
E) Entorno cultural

C) Correcta
EXP: El espacio psicológico es la atmósfera subjetiva en la que se ubican la acción y los personajes, expresando su interioridad, como angustia, alegría, incertidumbre o tristeza.

Pregunta 5: ¿Cuál es la función principal del personaje conocido como "antagonista" dentro de una narración?
A) Narrar la historia desde una perspectiva omnisciente.
B) Ayudar pasivamente al protagonista a alcanzar sus objetivos.
C) Oponerse directamente al protagonista y dificultarle alcanzar su meta.
D) Representar las características culturales y religiosas del espacio social.
E) Intervenir en la historia únicamente en el desenlace.

C) Correcta
EXP: De acuerdo a su rol, el antagonista es el personaje que se opone al protagonista y le dificulta alcanzar su meta dentro de la historia.

Pregunta 6: ¿Qué característica define esencialmente al "espacio físico cerrado" dentro de una narración?
A) Es un espacio exterior amplio y sin límites.
B) Determina la concepción del mundo mediante la religión y economía.
C) Refleja únicamente los pensamientos tristes de los personajes secundarios.
D) Es un lugar limitado que condiciona la acción de los personajes, como una prisión o habitación.
E) Es el momento histórico en que se ubica la obra.

D) Correcta
EXP: El espacio físico cerrado se define como aquel que es limitado y condiciona el accionar de los personajes, poniendo como ejemplos una prisión, habitación u hotel.

Pregunta 7: En el género narrativo predomina una función específica del lenguaje porque relata una historia sobre un tema en particular. ¿Qué función es esta?
A) Poética
B) Fática
C) Apelativa
D) Referencial
E) Metalingüística

D) Correcta
EXP: En el género narrativo predomina la función referencial del lenguaje, precisamente porque el objetivo principal es relatar una historia sobre un tema o referente en particular.

Pregunta 8: Dentro de las categorías de personajes de acuerdo a su nivel de importancia, ¿cómo se les llama a aquellos que son de acompañamiento o accidentales, y sin los cuales el núcleo del relato podría seguir existiendo?
A) Personajes principales
B) Personajes protagonistas
C) Personajes antagonistas
D) Personajes secundarios
E) Personajes narradores

D) Correcta
EXP: Según el nivel de importancia, los personajes secundarios son aquellos que fungen roles de acompañamiento o accidentales, a diferencia de los principales, sin los cuales no habría relato.

Pregunta 9: ¿Cómo se define el término "trama" en la estructura de los elementos narrativos?
A) La época histórica de la narración.
B) El lugar físico en el que suceden los hechos.
C) La voz en primera persona que cuenta sus vivencias.
D) El contenido del relato o el orden cronológico de las anécdotas y acciones que hacen avanzar la historia hasta su desenlace.
E) La opinión del autor respecto a la obra.

D) Correcta
EXP: La trama es el contenido del relato o el orden cronológico de todas las anécdotas y acciones que suceden y hacen avanzar la historia hacia su desenlace.

Pregunta 10: En la estructura de la acción narrativa, ¿qué evento marca el inicio formal del "desenlace" o situación final?
A) La presentación de los personajes y sus metas.
B) Cuando el narrador omnisciente describe el escenario.
C) Cuando se quiebra por primera vez la normalidad planteada.
D) Cuando se produce un hecho que reordena los elementos tras el punto de máxima tensión, volviendo a cierta "normalidad".
E) Cuando el protagonista conoce a su acompañante.

D) Correcta
EXP: El desenlace se inicia tras arribar al punto de máxima tensión del relato, cuando se produce un hecho que reordena los elementos y los personajes vuelven a una "normalidad".

Pregunta 11: Identifique el tipo de narrador que actúa como si fuera una divinidad: conoce todo lo que ocurre, los detalles más íntimos de los personajes, sus pensamientos, sentimientos, pasados y sus intenciones más secretas.
A) Narrador Testigo
B) Narrador Observador
C) Narrador Protagonista
D) Narrador Omnisciente
E) Monólogo interior

D) Correcta
EXP: El narrador omnisciente en tercera persona es aquel que sabe todo lo que sienten y piensan los personajes, comparándose con una divinidad que todo lo conoce en tiempo y lugar.

Pregunta 12: Dentro de las tipologías de personajes por su complejidad, ¿cómo se denomina a aquellos que son creados a partir de una única cualidad o defecto, son simples, predecibles y no evolucionan ni cambian en absoluto a lo largo de la narración?
A) Personajes principales
B) Personajes redondos
C) Personajes protagonistas
D) Personajes antagonistas
E) Personajes planos

E) Correcta
EXP: Los personajes planos son construidos a partir de una sola idea o defecto, son seres simples y típicos que no evolucionan ni cambian a lo largo de toda la historia.

Pregunta 13: En un relato, la historia es narrada por un personaje que participa de las acciones, pero él no es el centro del argumento, sino que se limita a contar, según su propia percepción y desde su óptica, todo lo que le ocurre al personaje principal. ¿A qué tipo de narrador corresponde esta definición?
A) Narrador en primera persona Protagonista
B) Narrador en primera persona Testigo
C) Narrador Omnisciente
D) Narrador Observador externo
E) Monólogo interior

B) Correcta
EXP: El narrador testigo relata en primera persona pero es un personaje secundario en la historia. Narra lo que le ocurre al protagonista actuando estrictamente como un observador.

Pregunta 14: ¿Cuál es el rasgo definitorio principal que diferencia a los personajes "redondos" de los personajes "planos" dentro de un relato?
A) Los redondos solo pueden ser protagonistas o antagonistas.
B) Los redondos no encarnan una sola cualidad, poseen profundidad psicológica y evolucionan o cambian a lo largo de la trama, sorprendiendo al lector.
C) Los redondos están basados obligatoriamente en personas reales e históricas.
D) Los redondos carecen de defectos humanos.
E) Los redondos son estáticos y siempre reaccionan de manera predecible y típica.

B) Correcta
EXP: Los personajes redondos se caracterizan por su profundidad psicológica; no encarnan un solo defecto o virtud, sino que evolucionan, muestran múltiples caras y sorprenden al lector.

Pregunta 15: Un relato está narrado en tercera persona, pero la voz narrativa no puede acceder a la mente, pensamientos ni emociones de los protagonistas. Solo se dedica a describir de forma neutra y externa las acciones físicas y los diálogos que observa, como si fuera una cámara de cine. Este es un ejemplo de:
A) Narrador omnisciente
B) Monólogo interior
C) Narrador observador (objetivista)
D) Narrador protagonista
E) Narrador testigo

C) Correcta
EXP: El narrador observador (u objetivista) narra en tercera persona externa, y solo conoce y descifra lo que los personajes dicen y hacen a simple vista, ignorando sus pensamientos íntimos.

Pregunta 16: Es el tipo de narrador en primera persona que busca plasmar los pensamientos del personaje en tiempo real, sin que su narración esté destinada a ningún oyente o lector más que a sí mismo:
A) Monólogo interior
B) Narrador omnisciente
C) Narrador testigo
D) Narrador observador
E) Narrador externo de segunda persona

A) Correcta
EXP: El monólogo interior es un narrador en primera persona cuya narración no está destinada a nadie más que a sí mismo, y que busca plasmar el pensamiento del personaje en tiempo real.

Pregunta 17: Señale la proposición correcta acerca de la diferencia teórica fundamental entre "Autor" y "Narrador":
A) Son exactamente la misma persona en cualquier novela autobiográfica.
B) El narrador es la persona real de carne y hueso que firma el libro y el autor es quien relata dentro del mismo.
C) El autor es la persona que crea la obra y decide quién va a ser el narrador (el ente ficticio o voz que cuenta la historia desde un punto de vista).
D) El narrador no es un elemento estructural del cuento, mientras que el autor sí lo es.
E) El autor y el narrador se diferencian únicamente en textos poéticos, pero no en narrativos.

C) Correcta
EXP: Autor y narrador no es lo mismo. El narrador es el elemento estructural o voz ficticia que cuenta los hechos, mientras que el autor es la persona real que decide quién y con qué características será dicho narrador.

Pregunta 18: Según la actitud valorativa y la opinión que emite sobre la historia, cuando el narrador interviene de manera constante en el relato juzgando los hechos que realizan los personajes (si son buenas o malas acciones) para dirigir la interpretación del lector, se le denomina:
A) Narrador omnisciente temporal
B) Narrador objetivo
C) Narrador de ritmo lento
D) Narrador subjetivo
E) Narrador indirecto libre

D) Correcta
EXP: Cuando el narrador interviene en el relato, valora los hechos dando su opinión e inclinando la balanza interpretativa, se dice que es un narrador "subjetivo".

Pregunta 19: Si en un relato histórico, un autor utiliza pronombres como "tú" para mantener un vínculo con el lector mientras cuenta los sucesos de forma externa o interna, nos encontramos frente a un narrador en:
A) Tercera persona omnisciente.
B) Primera persona monologal.
C) Primera persona testigo.
D) Segunda persona.
E) Tercera persona objetivista.

D) Correcta
EXP: El narrador en segunda persona utiliza el "tú" (y sus derivados) ya sea como observador externo omnisciente o interno, estableciendo de este modo un vínculo comunicativo directo.

Pregunta 20: Todo personaje es una entidad que interviene en el argumento de la narración, realizando acciones o sufriéndolas. Según la teoría narrativa, ¿qué entidades pueden ser legítimamente consideradas como personajes?
A) Exclusivamente personas reales o ficticias.
B) Personas y animales, descartando tajantemente a los objetos.
C) Personas, animales u objetos (siempre que ejecuten o sufran acciones en la historia).
D) Únicamente seres míticos o legendarios.
E) Solo las abstracciones psicológicas del narrador.

C) Correcta
EXP: Según la teoría narrativa, un personaje es cualquier entidad que lleva a cabo acciones en el argumento; por ende, pueden ser tanto personas como animales u objetos que adquieren características específicas.

Pregunta 21: ¿Cómo se denomina al tipo de disposición de los acontecimientos o narración que toma como punto de partida estricto el final o el desenlace definitivo de la historia cronológica?
A) Narración Ab Ovo
B) Narración In Media Res
C) Narración In Extrema Res
D) Final abierto
E) Estilo indirecto libre

C) Correcta
EXP: La narración "In extrema res" es aquella cuyo punto de partida del relato es el final de la historia o su desenlace, por lo que no corresponde a una disposición cronológica natural.

Pregunta 22: En una novela, el narrador resume con sus propias palabras, y en tercera persona, lo que los personajes han estado debatiendo en una asamblea, omitiendo los matices expresivos literales de estos y seleccionando solo la información importante. ¿Qué estilo de reproducción de voz se ha empleado?
A) Estilo directo
B) Estilo indirecto
C) Estilo indirecto libre
D) Monólogo interior
E) Corriente de la conciencia

B) Correcta
EXP: El estilo indirecto lo utiliza el narrador cuando resume, usando sus propias palabras en tercera persona, lo que dijeron o pensaron los personajes, perdiéndose así matices emocionales directos.

Pregunta 23: Identifique la afirmación correcta que delimita exactamente la diferencia teórica entre los conceptos de "historia" y "relato" dentro de la narratología.
A) La historia narra el espacio social, mientras que el relato narra el espacio físico.
B) La historia se refiere exclusivamente a eventos reales verídicos, y el relato a la ficción pura.
C) La historia es la secuencia de los hechos organizados lógicamente desde el principio al fin (el qué), mientras que el relato es el orden estético y artificial con que el autor decide presentarlos al lector (el cómo).
D) La historia siempre utiliza narradores en primera persona y el relato utiliza narradores omniscientes.
E) La historia se cuenta siempre In extrema res, mientras el relato es siempre Ab Ovo.

C) Correcta
EXP: La "historia" es la serie cronológica de hechos relacionados (diégesis), mientras que el "relato" es la estructura y el orden temporal que el autor define artísticamente para presentar esos hechos al lector.

Pregunta 24: Lea la siguiente definición: "El punto de partida del relato se ubica en una instancia intermedia y avanzada del argumento central, quebrando el orden natural para entrar de lleno al conflicto sin introducciones preliminares". ¿A qué tipo de disposición narrativa corresponde?
A) Narración "Ad Ovo"
B) Narración "In Extrema Res"
C) Narración lineal
D) Narración "In Media Res"
E) Estilo directo

D) Correcta
EXP: La narración "In Media Res" es aquella que no posee la clásica situación inicial, sino que comienza abruptamente en un punto intermedio, justo en la mitad de la trama argumental.

Pregunta 25: El narrador escribe: *"Caminaba deprisa bajo la lluvia. ¡Qué frío le calaba los huesos! ¿Acaso no llegaría nunca a casa?"*. Se advierte la voz del narrador relatando en tercera persona, pero se han introducido fluidamente, y sin guiones, exclamaciones e interrogaciones propias del sentir íntimo del personaje. Esto es un ejemplo característico del:
A) Estilo indirecto tradicional
B) Estilo directo
C) Monólogo interior
D) Diálogo literal
E) Estilo indirecto libre

E) Correcta
EXP: El estilo indirecto libre es una fusión donde el narrador relata en tercera persona, pero introduce exclamaciones, interrogaciones o expresiones que reproducen de cerca el pensamiento emocional del personaje.

Pregunta 26: ¿Qué término define la estructura narrativa en la que el autor relata todo cronológicamente, respetando inalterablemente la secuencia de los acontecimientos desde su origen natural y regido estrictamente por el principio causa-efecto?
A) Disposición In Media Res
B) Alteración temporal por Racconto
C) Disposición Ad Ovo (o Ab-Ovo)
D) Disposición In Extrema Res
E) Anacronía de Elipsis

C) Correcta
EXP: La narración "Ab-Ovo" o "Ad Ovo" sitúa como punto de partida el inicio lógico y natural de la historia, respondiendo siempre a un desenvolvimiento cronológico inalterado de causa-efecto.

Pregunta 27: Además del tiempo de la historia (TH) y el tiempo del discurso (TR), la teoría literaria contempla un "Tiempo referencial histórico". ¿Qué define exactamente a este concepto?
A) Es el tiempo psicológico que ocurre dentro del monólogo de un personaje.
B) Es el marco sociopolítico y el momento histórico real y cultural en el que se ubica la obra, y que condiciona a los personajes (ej. la Segunda Guerra Mundial).
C) Es la manipulación estructural que convierte el relato en in media res.
D) Es la cantidad de horas o días cronológicos exactos que dura la trama.
E) Es el año exacto en el que el autor publica el texto impreso.

B) Correcta
EXP: El tiempo referencial histórico es el momento histórico (con sus cualidades socioculturales) en el en el que se enmarca la historia y que determina la visión del mundo de los personajes y sus acciones.

Pregunta 28: En las técnicas de manipulación estructural, ¿cómo se le llama a la forma de desenlace de la narración en la cual el autor decide deliberadamente no revelar al lector cómo concluye el problema o el destino de los personajes?
A) Racconto
B) Nudo narrativo
C) Elipsis argumental
D) Final abierto
E) In media res

D) Correcta
EXP: El final abierto se produce cuando el autor decide deliberadamente no narrar o no contar el desenlace explícito de la trama argumental, induciendo a la imaginación del lector.

Pregunta 29: Cuando la voz de un personaje aparece reproducida de manera fidedigna, totalmente literal y tal cual fue dicha, sin modificación del narrador y precedida visualmente por el uso de guiones o comillas, estamos ante un:
A) Estilo indirecto libre
B) Estilo indirecto
C) Estilo retrospectivo
D) Fluir de la conciencia
E) Estilo directo

E) Correcta
EXP: El estilo directo se manifiesta cuando la voz, palabras o pensamientos de los personajes se reproduce de manera literal y exacta, figurando gráficamente mediante el uso de guiones o comillas.

Pregunta 30: ¿Qué estructura elemental de la narración agrupa formalmente al inicio (quiénes son los personajes, el problema, el tiempo y espacio), al nudo (narrando cómo se intenta resolver el problema) y el desenlace (el resultado final de las acciones)?
A) La estructura de la elipsis temporal.
B) El esquema del monólogo interior.
C) La estructura de la acción narrativa (o trama).
D) La velocidad del relato.
E) El espacio narrativo social.

C) Correcta
EXP: La estructura de la acción narrativa (o trama) se organiza tradicionalmente respondiendo al esquema de planteamiento (inicio o introducción), desarrollo (nudo o situación nuclear) y resolución (desenlace).

Pregunta 31: De acuerdo a la teoría del ritmo y las velocidades narrativas (relación TH y TR), ¿cómo se llama a la técnica empleada cuando el narrador suspende o detiene totalmente el avance de la acción o historia (TH=0) para dedicar el texto narrativo a realizar descripciones exhaustivas de un lugar o insertar reflexiones?
A) Escena
B) Sumario
C) Elipsis
D) Pausa
E) Analepsis

D) Correcta
EXP: La Pausa (donde el tiempo de la historia es 0 y el del relato es "x") se caracteriza por detener el tiempo de las acciones para ofrecer descripciones o comentarios, haciendo un ritmo lento.

Pregunta 32: Todo salto en el flujo del tiempo narrativo que rompa el orden natural cronológico de los acontecimientos recibe el nombre categórico de:
A) Anacronía
B) Prosopopeya
C) Diégesis
D) Sumario
E) Epíteto temporal

A) Correcta
EXP: La ruptura del orden lógico y lineal de la historia por parte del narrador, introduciendo temporalidades distintas, recibe el nombre general de Anacronía.

Pregunta 33: Si en un relato el narrador se anticipa y cuenta un hecho que aún no ha sucedido y pertenece a un momento futuro, y este salto o proyección es breve e instantáneo retornando rápidamente al presente, la figura exacta recibe el nombre de:
A) Analepsis - Racconto
B) Analepsis - Flash-back
C) Prolepsis - Premonición
D) Prolepsis - Flash-forward
E) Anacronía - Pausa

D) Correcta
EXP: La Prolepsis es una mirada al futuro; cuando dicha proyección hacia adelante en la línea de tiempo es breve e instantánea, se le denomina específicamente flash-forward.

Pregunta 34: *"El día en que lo iban a matar, Santiago Nasar se levantó a las 5:30 de la mañana para esperar el buque"*. Teniendo en cuenta que el protagonista en ese momento inicial sigue vivo realizando acciones matutinas cotidianas, revelar al lector desde el principio que en el futuro va a morir es un ejemplo estricto de:
A) Racconto
B) Analepsis
C) Monólogo interior
D) Disposición ad ovo
E) Prolepsis

E) Correcta
EXP: Mencionar un suceso (la muerte del personaje) anticipándose dramáticamente a hechos posteriores del presente temporal y narrativo constituye una prolepsis narrativa.

Pregunta 35: Dentro de las variaciones del tiempo narrativo según Genette, identifique el caso donde existe una compresión veloz del tiempo. El autor omite detalles no significativos para abarcar en unas cuantas oraciones acontecimientos que requirieron meses o años en la historia (TR < TH).
A) Escena
B) Sumario (o Resumen)
C) Elipsis
D) Racconto
E) Pausa

B) Correcta
EXP: El sumario o resumen representa una aceleración narrativa, comprimiendo o resumiendo acontecimientos largos en una duración corta y rápida del relato, siendo el tiempo del relato menor al de la historia (TR < TH).

Pregunta 36: Se utiliza un recurso temporal en el cual la narración da un salto abrupto hacia atrás hacia recuerdos de la infancia del personaje; sin embargo, no es veloz, sino que la evocación del recuerdo abarca varias páginas, ocupando un extenso e intrincado pasaje del relato antes de retornar a la línea argumental presente. A este subtipo preciso de salto retrospectivo se le denomina:
A) Flash-forward
B) Elipsis
C) Flash-back
D) Prolepsis
E) Racconto

E) Correcta
EXP: El "Racconto" es un tipo de analepsis (retroceso al pasado) que se caracteriza por ser muy extenso en el tiempo y recordar los acontecimientos con gran detalle antes del retorno narrativo al presente.

Pregunta 37: En el estudio de la temporalidad narrativa y el ritmo del relato, ¿en qué caso ocurre una relación de sincronía perfecta entre ambos tiempos, donde el "Tiempo de la Historia" es exactamente igual al "Tiempo del Relato" (TH = TR)?
A) Cuando se relata usando elipsis puras sin transición.
B) Cuando el narrador altera la estructura hacia la modalidad in extrema res.
C) Cuando se presentan escenas dialogadas en tiempo real entre personajes.
D) Cuando se comprimen tres años de guerra en un párrafo descriptivo.
E) Cuando el narrador entra en un prolongado monólogo descriptivo paralizando la acción.

C) Correcta
EXP: La Escena ocurre en relación de igualdad perfecta (coloquialmente "tiempo real"), donde existe sincronía; es decir, el tiempo del discurso se ajusta a lo que dura la conversación o la acción, tal como sucede en el diálogo.

Pregunta 38: Analice el siguiente fragmento: *"No creía confundirse, pero cuando señaló que hacía treinta años que no pisaba ese lugar, no mintió [...] Casi sintió el olor de los cardenales; y se vio de nuevo ahí, avergonzada de escuchar los gritos aborrecidos de su padre..."*. La alteración de la temporalidad aquí presente retrocede hacia lo acontecido en su niñez, correspondiendo formalmente a una:
A) Analepsis
B) Prolepsis
C) Anticipación
D) Disposición ad ovo
E) Disposición in extrema res

A) Correcta
EXP: La analepsis alude directamente a la retrospección (retroceso); se recuerdan y relatan sucesos acaecidos en un tiempo anterior al acontecimiento principal que fluye en el presente (como sus tiempos de infancia).

Pregunta 39: Existen fragmentos del relato donde el narrador silencia completamente el texto y opta por omitir por completo meses o años de acciones de los personajes porque no se consideran fundamentales ("cinco años más tarde, volvió..."). Este recurso del ritmo temporal, donde matemáticamente el tiempo del relato es nulo ante un tiempo histórico transcurrido, recibe el nombre de:
A) Flash-back
B) Racconto
C) Escena objetivista
D) Elipsis
E) Sumario referencial

D) Correcta
EXP: La Elipsis ocurre cuando una parte del tiempo de la historia cronológica no se cuenta en el texto literario en absoluto, por lo cual el "Tiempo del relato" es 0 respecto a esa porción omitida del "Tiempo de la historia".

Pregunta 40: Tanto el "flash-forward" como el "flash-back" son técnicas modernas, impulsadas notoriamente por la técnica cinematográfica, que logran desorganizar la disposición natural del relato. Sintetizando los conceptos literarios puros, el primero corresponde respectivamente a una ____________ y el segundo a una ____________.
A) Analepsis breve / Prolepsis extensa
B) Prolepsis instantánea / Analepsis veloz
C) Premonición / Racconto
D) Anacronía ad ovo / Anacronía in media res
E) Analepsis / Anticipación

B) Correcta
EXP: El "Flash-forward" es la proyección, avance o anticipación breve e instantánea al futuro, catalogada como Prolepsis. El "Flash-back" es un retroceso veloz al pasado, catalogado como Analepsis.
"""

questions_data = parse_questions(raw_text)

dart_code = generate_dart_code(questions_data, "narracionExt10qQuestions")

with open('lib/data/library/comunicacion/narracion_ext_10q_questions.dart', 'w', encoding='utf-8') as f:
    f.write(dart_code)

print(f"Generated {len(questions_data)} questions.")
