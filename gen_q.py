import re

text = r"""
====== NIVEL FÁCIL ======
Pregunta 1: Según su estructura sintáctica, ¿qué alternativa presenta un claro ejemplo de oración unimembre?
A) Juan viene a almorzar.
B) Si estudias, triunfarás.
C) El clima nublado es mi favorito.
D) ¡Villarreal! ¡Villarreal!
E) Yo admiro y respeto a mis profesores.

D) Correcta
EXP: Las oraciones unimembres son las que cuentan con un solo miembro y carecen de la división en sujeto y predicado, como es el caso de interjecciones u onomatopeyas del tipo "¡Villarreal! ¡Villarreal!".

Pregunta 2: ¿Qué categoría gramatical tiene la función privativa y principal de desempeñarse como el núcleo del sintagma nominal o sujeto?
A) El verbo
B) El adjetivo
C) El sustantivo
D) El adverbio
E) La preposición

C) Correcta
EXP: El núcleo del sujeto forma parte de un sintagma nominal y suele ser, por excelencia, un sustantivo (común o propio) o un pronombre.

Pregunta 3: En la oración "Al fin llegó el Damián arreando las ovejas", ¿cuál es la estructura que cumple la función de sujeto?
A) Al fin llegó
B) arreando las ovejas
C) el Damián arreando las ovejas
D) llegó el Damián
E) el Damián

C) Correcta
EXP: Para reconocer el sujeto se pregunta al verbo "¿quién llegó?", a lo que la respuesta completa es "el Damián arreando las ovejas".

Pregunta 4: En la oración "María volvió a casa después de un año", identifique cuál es la palabra exacta que funciona como núcleo del predicado.
A) María
B) a casa
C) volvió
D) después
E) año

C) Correcta
EXP: El núcleo del predicado es el verbo principal conjugado que indica la acción realizada y concuerda con el sujeto. En este caso, el verbo conjugado es "volvió".

Pregunta 5: De las siguientes opciones, identifique la oración que se caracteriza por poseer un sujeto tácito o elíptico.
A) El verde del césped resplandecía.
B) Ellos tenían razón en lo que dijeron.
C) Sonó toda la noche la misma canción.
D) Estuvimos una semana en la costa.
E) Mi hermano es muy valiente.

D) Correcta
EXP: El sujeto tácito es aquel que no está mencionado explícitamente en la oración, pero se deduce por la desinencia verbal. En "Estuvimos", el sujeto tácito es "Nosotros".

Pregunta 6: ¿Cuál es el núcleo del sujeto en la oración "La mayor virtud de mi madre es la paciencia"?
A) Mayor
B) Madre
C) Paciencia
D) Virtud
E) La

D) Correcta
EXP: El sujeto es "La mayor virtud de mi madre". El sustantivo principal o centro de este sintagma nominal, de quien se habla, es "virtud".

Pregunta 7: Reconozca la oración que presenta un sujeto compuesto (es decir, que tiene dos o más núcleos).
A) El clima nublado y lluvioso es mi favorito.
B) Mi madre y yo nos llevamos muy bien.
C) El joven llegó tarde y no pudo entrar.
D) Iremos a cenar y después al cine.
E) El hombre escapó a toda velocidad.

B) Correcta
EXP: Si un sujeto tiene dos núcleos (en este caso "madre" y "yo"), se denomina sujeto compuesto.

Pregunta 8: Para encontrar el sujeto en la oración "Me gustan las asignaturas de matemáticas", ¿cuál es el procedimiento correcto y el sujeto hallado?
A) Preguntar "¿a quién?", el sujeto es "Me".
B) Preguntar "¿qué me gustan?", el sujeto es "las asignaturas de matemáticas".
C) El sujeto es tácito (Yo).
D) Preguntar "¿de qué?", el sujeto es "de matemáticas".
E) El sujeto es "matemáticas".

B) Correcta
EXP: Para reconocer el sujeto se le pregunta al verbo "¿qué o quién realiza la acción?". Al preguntar "¿qué me gustan?", la respuesta concordante en número plural es "las asignaturas de matemáticas".

Pregunta 9: En la oración "Bailamos y reímos toda la noche", indique la característica sintáctica principal de su estructura.
A) Es una oración unimembre.
B) Es una oración con sujeto expreso.
C) Es una oración con predicado compuesto.
D) Posee un predicado nominal.
E) El sujeto es compuesto.

C) Correcta
EXP: La oración tiene un sujeto tácito (Nosotros) y cuenta con dos verbos principales ("bailamos" y "reímos"), por lo que posee un predicado compuesto.

Pregunta 10: ¿Qué oración corresponde a un claro ejemplo de verbo impersonal, lo que la convierte en una oración unimembre?
A) Felipe fue siempre buen estudiante.
B) La asamblea redacta la nueva Constitución.
C) Ellos comieron una pizza.
D) Ayer llovió torrencialmente.
E) Nosotros saldremos hacia la costa.

D) Correcta
EXP: Los verbos meteorológicos (como llover, relampaguear o nevar) son impersonales, solo se conjugan en tercera persona del singular y forman oraciones unimembres al no poder dividirse lógicamente en sujeto y predicado.


====== NIVEL MEDIO ======
Pregunta 11: ¿A qué clase, según la actitud del hablante, pertenece la oración "Ojalá mañana no llueva"?
A) Dubitativa
B) Enunciativa afirmativa
C) Imperativa
D) Desiderativa
E) Exclamativa

D) Correcta
EXP: Las oraciones desiderativas son aquellas mediante las cuales el emisor expresa explícitamente un deseo, utilizando frecuentemente la palabra "ojalá".

Pregunta 12: Según la clasificación por la intención del emisor, la oración "Tal vez sea mejor que vengas a las siete" pertenece al grupo de oraciones:
A) Imperativas
B) Dubitativas
C) Interrogativas indirectas
D) Enunciativas
E) Exclamativas

B) Correcta
EXP: El hablante expresa una duda o probabilidad empleando fórmulas introductorias como adverbios y locuciones adverbiales (quizás, tal vez), por lo que es una oración dubitativa.

Pregunta 13: Identifique el tipo de oración, según la actitud del hablante, en el siguiente enunciado: "Cierra la puerta, por favor."
A) Desiderativa
B) Enunciativa
C) Dubitativa
D) Imperativa
E) Interrogativa

D) Correcta
EXP: Las oraciones imperativas (o exhortativas) dan una orden, mandato, ruego o consejo al receptor ("Cierra la puerta, por favor").

Pregunta 14: ¿Cuál de los siguientes enunciados representa claramente una oración interrogativa indirecta?
A) ¿Quién tiene el pelo ardiendo?
B) ¡Tienes el pelo ardiendo!
C) Me pregunto si me dejarás elegir a mí.
D) ¿Te parece bien?
E) Debes de estar loco.

C) Correcta
EXP: Las interrogativas indirectas expresan una pregunta pero no emplean signos de interrogación gráficos, sino que se introducen por medio de verbos de lengua como decir, preguntar o indagar ("Me pregunto si...").

Pregunta 15: La oración "Eso costará unos doscientos soles" se clasifica según la intención del hablante como una oración:
A) Imperativa
B) Desiderativa
C) Exclamativa
D) Enunciativa
E) Dubitativa

D) Correcta
EXP: El emisor está expresando un hecho o una idea afirmándola como una realidad objetiva ("Eso costará unos doscientos soles"), lo que la define como una oración enunciativa.

Pregunta 16: Lea el siguiente enunciado: "Debes de tener el pelo ardiendo". ¿Qué actitud del hablante se refleja en la oración?
A) Exclamativa
B) Desiderativa
C) Imperativa
D) Dubitativa
E) Enunciativa

D) Correcta
EXP: Aunque se usa el verbo deber, la estructura "deber de + infinitivo" (a diferencia de "deber + infinitivo") expresa una duda, posibilidad o suposición del hablante, por lo que es dubitativa.

Pregunta 17: Señale la opción que contiene una oración de tipo imperativa expresada a través de una fórmula de obligación.
A) Ojalá tengas el pelo ardiendo.
B) Tienes que quemarte el pelo.
C) Puede que tengas el pelo ardiendo.
D) No tienes el pelo ardiendo.
E) ¿Cuándo empieza la película?

B) Correcta
EXP: Las oraciones imperativas pueden usar verbos en modo imperativo o fórmulas de obligación como "Tener que + infinitivo" ("Tienes que quemarte el pelo") para transmitir una orden o mandato.

Pregunta 18: Identifique la alternativa que presenta una oración interrogativa parcial.
A) ¿Tienes el pelo ardiendo?
B) Me pregunto si tienes hambre.
C) ¿Te gusta el helado?
D) ¿Por qué tienes el pelo ardiendo?
E) Ojalá haya palomitas de colores.

D) Correcta
EXP: Las interrogativas parciales preguntan por una parte del contenido buscando una información en particular (causa, sujeto, tiempo) y utilizan partículas interrogativas como por qué, quién, cuándo. Las totales buscan como respuesta un sí o un no.

Pregunta 19: Si el hablante enuncia: "Nadie tiene el pelo ardiendo", estamos frente a una oración:
A) Dubitativa
B) Enunciativa negativa
C) Exhortativa
D) Enunciativa afirmativa
E) Desiderativa

B) Correcta
EXP: Las oraciones enunciativas expresan un hecho. Son negativas cuando niegan una idea usando adverbios (no, nunca) o pronombres indefinidos negativos como "nadie" o "nada".

Pregunta 20: ¿En cuál de las siguientes opciones se utiliza una oración para expresar una emoción de sorpresa o alegría, dándole fuerte énfasis al mensaje?
A) ¡Qué bonito es ese dibujo!
B) Salga de aquí.
C) ¿Dónde estudias?
D) El clima nublado es mi favorito.
E) Quizás tengas razón.

A) Correcta
EXP: Las oraciones exclamativas transmiten sentimientos y emociones profundas (alegría, sorpresa) y suelen utilizar signos de exclamación para dar énfasis ("¡Qué bonito es ese dibujo!").


====== NIVEL DIFÍCIL ======
Pregunta 21: En la oración "El computador de Marcos tiene muchos programas", ¿qué función sintáctica exacta cumple la estructura subrayada "de Marcos"?
A) Núcleo del Sujeto
B) Modificador Directo
C) Aposición
D) Modificador Indirecto
E) Objeto Directo

D) Correcta
EXP: El Modificador Indirecto aporta información extra y siempre está unido al núcleo del sintagma nominal a través de una preposición, en este caso la preposición "de".

Pregunta 22: En la oración "Julio, mi amigo, se mudó a la casa de la esquina", ¿cómo se denomina sintácticamente al segmento que va entre comas ("mi amigo")?
A) Modificador indirecto
B) Núcleo del predicado
C) Sujeto expreso
D) Complemento agente
E) Aposición

E) Correcta
EXP: Lo que va entre comas dentro del sujeto explicando, aclarando o repitiendo quién es el núcleo se llama aposición, y funciona como un modificador del sujeto.

Pregunta 23: En el sintagma nominal, ¿qué categorías gramaticales funcionan exclusivamente como modificadores directos (MD) del núcleo?
A) Verbos y adverbios
B) Preposiciones y conjunciones
C) El artículo y el adjetivo
D) Sustantivos y pronombres
E) Interjecciones y aposiciones

C) Correcta
EXP: Los modificadores directos acompañan directamente al núcleo sin preposiciones. Los artículos, determinantes y adjetivos cumplen esta función sintáctica.

Pregunta 24: Lea atentamente: "La carta fue recibida por el recepcionista". Según la voz de la oración, ¿qué tipo de sujeto presenta?
A) Sujeto Agente
B) Sujeto Paciente
C) Sujeto Tácito
D) Sujeto Compuesto
E) Sujeto Múltiple

B) Correcta
EXP: El sujeto es "La carta". Al estar la oración en voz pasiva ("fue recibida"), el sujeto no realiza la acción, sino que la recibe pasivamente, por lo cual se clasifica como Sujeto Paciente.

Pregunta 25: Identifique los modificadores directos (MD) presentes en el sujeto de la siguiente oración: "Mi carro nuevo es muy rápido".
A) muy, rápido
B) carro, es
C) Mi, nuevo
D) Mi, rápido
E) nuevo, rápido

C) Correcta
EXP: El sujeto es "Mi carro nuevo", donde el núcleo es "carro". Las palabras que lo modifican directamente sin nexos son el determinante posesivo "Mi" y el adjetivo "nuevo".

Pregunta 26: Analice la oración "Los libros fueron devueltos por los estudiantes". Determine qué clase de sujeto y voz posee.
A) Sujeto Agente - Voz activa
B) Sujeto Tácito - Voz pasiva
C) Sujeto Paciente - Voz pasiva
D) Sujeto Simple - Voz activa
E) Sujeto Compuesto - Voz pasiva

C) Correcta
EXP: En las oraciones en voz pasiva, el sujeto ("Los libros") no realiza la acción del verbo, sino que la sufre o recibe de un agente ("los estudiantes"), clasificándose como Sujeto Paciente.

Pregunta 27: En la oración "El cobarde atentado, que dejó grandes pérdidas, fue condenado por la opinión pública", determine cuál es el sujeto.
A) por la opinión pública
B) que dejó grandes pérdidas
C) fue condenado
D) grandes pérdidas
E) El cobarde atentado

E) Correcta
EXP: Preguntamos al verbo en voz pasiva "¿qué fue condenado por la opinión pública?". La respuesta y sujeto paciente de la oración es "El cobarde atentado".

Pregunta 28: En la oración "El señor Fernández, el arquitecto, revisó los planos", la estructura "el arquitecto" cumple la función de:
A) Modificador indirecto
B) Núcleo del sujeto
C) Objeto directo
D) Aposición
E) Circunstancial

D) Correcta
EXP: La expression encerrada entre comas que detalla o repite la identidad del núcleo del sujeto ("El señor Fernández") funciona como aposición.

Pregunta 29: Determine la veracidad de la siguiente afirmación respecto a los tipos de sujeto por su presencia: "El sujeto elíptico u omitido es aquel que no aparece escrito en la oración, pero se deduce por la forma verbal".
A) Falso, se trata del sujeto léxico.
B) Falso, se trata del sujeto expreso.
C) Verdadero.
D) Falso, se trata de la aposición.
E) Falso, se trata del sujeto paciente.

C) Correcta
EXP: El sujeto tácito, también llamado elíptico u omitido, es aquel que no se nombra explícitamente en el enunciado pero se colige a partir de la conjugación y desinencia del verbo principal.

Pregunta 30: En la oración "La inmensa llanura de las viñas sube un frescor grato y fragante" (variación sintáctica poética), si buscamos una estructura similar a "Los trabajadores de la empresa telefónica hicieron una huelga", el modificador indirecto del sujeto en este último ejemplo es:
A) Los trabajadores
B) de la empresa telefónica
C) hicieron una huelga
D) una huelga
E) ayer

B) Correcta
EXP: El modificador indirecto se reconoce por estar unido al núcleo del sintagma nominal mediante una preposición (en este caso "de"). Por tanto, "de la empresa telefónica" es el MI de "trabajadores".


====== NIVEL EXTREMO ======
Pregunta 31: En la oración "El cobarde atentado, que dejó grandes pérdidas, fue condenado por la opinión pública", determine la función sintáctica de la estructura subrayada "por la opinión pública".
A) Objeto directo
B) Objeto indirecto
C) Complemento agente
D) Atributo
E) Circunstancial de lugar

C) Correcta
EXP: El complemento agente es exclusivo de las oraciones en voz pasiva ("fue condenado"), va encabezado por la preposición "por" y señala a la entidad que materialmente ejecuta la acción verbal.

Pregunta 32: Analice la oración "Inés compró chocolates para su enamorado el día sábado". ¿Qué función sintáctica cumple la frase "para su enamorado"?
A) Objeto directo
B) Circunstancial de causa
C) Aposición
D) Objeto indirecto
E) Atributo

D) Correcta
EXP: El objeto indirecto designa a quien recibe el beneficio o daño de la acción. Responde a la pregunta "¿para quién compró?" y puede sustituirse por el pronombre átono "le" (Inés le compró).

Pregunta 33: Identifique el tipo de predicado en la siguiente oración: "El hombre es arquitecto".
A) Predicado verbal
B) Predicado nominal (o copulativo)
C) Predicado no verbal
D) Predicado compuesto
E) Predicado elíptico

B) Correcta
EXP: El predicado nominal o copulativo está formado obligatoriamente por un verbo copulativo (ser, estar, parecer) que funciona como enlace hacia un atributo (arquitecto).

Pregunta 34: Determine el Objeto Directo (OD) en la siguiente oración: "Hemos comprado pasteles para tu cumpleaños".
A) Hemos comprado
B) tu cumpleaños
C) pasteles
D) para
E) nosotros (tácito)

C) Correcta
EXP: El objeto directo se reconoce preguntando "¿qué?" al verbo ("¿qué hemos comprado?"). La respuesta es "pasteles", y se puede sustituir por el pronombre "los" (Los hemos comprado).

Pregunta 35: Señale la oración que presenta un verbo transitivo que exija obligatoriamente la presencia de un Objeto Directo.
A) Ayer llovió torrencialmente.
B) Yo como manzanas.
C) Marcos se parece mucho a su padre.
D) El avión aterrizó sin inconvenientes.
E) José y Hugo caminaron.

B) Correcta
EXP: Un verbo transitivo transfiere la acción hacia un objeto directo ("manzanas"). Al retirarlo ("Yo como"), la frase necesita el contexto del objeto para estar semánticamente completa.

Pregunta 36: En la oración "La empresa publicó una nota explicando el acuerdo", ¿cuál es el núcleo del predicado?
A) empresa
B) publicó
C) nota
D) explicando
E) acuerdo

B) Correcta
EXP: El núcleo del predicado, también llamado núcleo verbal, es el verbo principal conjugado que concuerda con el sujeto. En este caso es "publicó".

Pregunta 37: En el enunciado "No llegó por la enfermedad de su mamá", identifique la función sintáctica que cumple el sintagma preposicional "por la enfermedad de su mamá".
A) Objeto directo
B) Complemento circunstancial de causa
C) Complemento agente
D) Objeto indirecto
E) Atributo

B) Correcta
EXP: Este complemento responde a la pregunta "¿por qué (no llegó)?" e indica el motivo de la acción, constituyéndose como un complemento circunstancial de causa.

Pregunta 38: En la oración "Luisa preparó un postre apetitoso para los invitados", si se reemplaza el objeto directo por su pronombre correspondiente, ¿cómo quedaría estructurada la frase?
A) Luisa se los preparó para los invitados.
B) Luisa le preparó un postre apetitoso.
C) Luisa lo preparó para los invitados.
D) Luisa las preparó apetitoso.
E) Luisa les preparó un postre.

C) Correcta
EXP: El objeto directo es "un postre apetitoso" (masculino, singular). El pronombre átono que lo reemplaza de forma exacta es "lo", resultando en "Luisa lo preparó para los invitados".

Pregunta 39: Teniendo en cuenta la estructura "CC (Circunstancial) + OI (Objeto Indirecto) + OD (Objeto Directo) + NP (Núcleo del Predicado)", identifique la oración que se adapta perfectamente a este orden.
A) A mí sí me interesa.
B) Con alegría, entregó el regalo.
C) Yo no sé la respuesta.
D) Mañana se lo devolveré.
E) Su padre se lo advirtió ayer.

D) Correcta
EXP: Analizando "Mañana se lo devolveré": Mañana (CC de tiempo) + se (OI, pronombre) + lo (OD, pronombre) + devolveré (NP, verbo).

Pregunta 40: En una oración de voz pasiva como "El balón fue atrapado por el perro", si transformamos la oración a voz activa ("El perro atrapó el balón"), ¿qué función sintáctica pasa a cumplir "el balón"?
A) Sujeto agente
B) Objeto indirecto
C) Complemento agente
D) Modificador indirecto
E) Objeto directo

E) Correcta
EXP: En la conversión de voz pasiva a voz activa, el sujeto paciente ("El balón") asume la función de Objeto Directo de la nueva oración ("El perro atrapó el balón", donde "el balón" recibe la acción de atrapar).
"""

questions = []
current_q = {}

blocks = re.split(r'Pregunta \d+:', text)
for block in blocks[1:]:
    block = block.strip()
    
    lines = block.split('\n')
    text_lines = []
    options = []
    correct_ans = -1
    explanation = ""
    
    idx = 0
    while idx < len(lines):
        line = lines[idx].strip()
        if line.startswith('A)') or line.startswith('B)') or line.startswith('C)') or line.startswith('D)') or line.startswith('E)'):
            options.append(line[2:].strip())
        elif 'Correcta' in line:
            ans_char = line[0]
            correct_ans = ord(ans_char) - ord('A')
        elif line.startswith('EXP:'):
            explanation = line[4:].strip()
        elif line == '':
            pass
        else:
            if not options:
                text_lines.append(line)
        idx += 1
        
    current_q['text'] = ' '.join(text_lines)
    current_q['options'] = options
    current_q['correct'] = correct_ans
    current_q['exp'] = explanation
    questions.append(current_q)
    current_q = {}

dart_code = """import 'package:learn/models/question.dart';

final List<Question> oracionGramaticalExt10qQuestions = [
"""
for i, q in enumerate(questions):
    opts_str = ',\n'.join(f"      r'''{opt}'''" for opt in q['options'])
    dart_code += f"""  Question(
    id: "ora_gram_10q_q{i+1}",
    topicId: "eo_pnp_oracion_gramatical_ext_10q",
    text: r'''{q['text']}''',
    options: [
{opts_str}
    ],
    correctAnswer: {q['correct']},
    explanation: r'''{q['exp']}''',
  ),
"""

dart_code += "];\n"

with open(r'c:\Users\PC\Downloads\EstudiEO-flutter\lib\data\library\comunicacion\oracion_gramatical_ext_10q_questions.dart', 'w', encoding='utf-8') as f:
    f.write(dart_code)
