import re
text = r'''
====== NIVEL FÁCIL ======
Pregunta 1: Según las normas de uso de la letra B, todos los verbos terminados en "-bir" se escriben con dicha consonante, salvo tres excepciones absolutas. ¿Cuáles son?
A) Percibir, concebir, recibir.
B) Prohibir, sucumbir, cohibir.
C) Hervir, servir, vivir.
D) Sobrevivir, exhibir, convivir.
E) Escribir, transcribir, revivir.

C) Correcta
EXP: La regla ortográfica estipula que los verbos con la terminación "-bir" se escriben con "b", siendo las únicas tres excepciones "hervir", "servir" y "vivir" (y sus derivados).

Pregunta 2: ¿Cómo se escribe correctamente el plural del sustantivo "lápiz" según las reglas de la Z y la C?
A) Lápizes
B) Lapizes
C) Lápices
D) Lápises
E) Lapices

C) Correcta
EXP: Los plurales de las palabras que terminan en Z se escriben cambiando la Z por la C, manteniendo la tilde si la regla general de acentuación lo exige (lápiz -> lápices).

Pregunta 3: De acuerdo a la actualización de la RAE de 2010, ¿cuántas letras conforman oficialmente el abecedario español y qué signos fueron excluidos?
A) 29 letras, se incluyeron la "ch" y la "ll".
B) 28 letras, se excluyó solo la "ch".
C) 27 letras, se excluyeron los dígrafos "ch" y "ll".
D) 26 letras, se excluyó la "ñ".
E) 27 letras, se excluyeron la "v" y la "w".

C) Correcta
EXP: El alfabeto quedó reducido a 27 letras oficiales en 2010 tras la exclusión definitiva de la "ch" y la "ll", ya que son dígrafos y no letras individuales.

Pregunta 4: Identifique la serie de palabras escritas correctamente según la regla de la terminación "-bilidad".
A) Havilidad, sensibilidad, movilidad.
B) Habilidad, sensivilidad, debilidad.
C) Habilidad, sensibilidad, debilidad.
D) Habilidad, sencibilidad, devilidad.
E) Avilidad, sensibilidad, debilidad.

C) Correcta
EXP: La terminación "-bilidad" siempre se escribe con B, salvo en derivados de palabras que llevan V en su raíz (como civilidad o movilidad, que no son el caso aquí). Habilidad, sensibilidad y debilidad son correctas.

Pregunta 5: ¿Cuál de las siguientes palabras está escrita correctamente aplicando la regla de la "M" antes de "P" y "B"?
A) Inperio
B) Anbiente
C) Embase
D) Ambiente
E) Conbatir

D) Correcta
EXP: La regla ortográfica indica que antes de P y B se escribe siempre M (ambiente, imperio, combatir). Antes de V se escribe N (envase).

Pregunta 6: Según las reglas de la letra S, ¿cómo deben escribirse los adjetivos terminados en el sonido "oso" u "osa"?
A) Con Z (hermozo).
B) Con C (hermoco).
C) Con S (hermoso).
D) Con X (hermoxo).
E) Depende de la raíz de la palabra.

C) Correcta
EXP: Los adjetivos terminados en "-oso" y "-osa" se escriben siempre con S, como por ejemplo amorosa, cenagoso, escandaloso.

Pregunta 7: Elija la palabra que utiliza correctamente la "H" delante de diptongos.
A) Yelo
B) Ueco
C) Hielo
D) Hia
E) Uérfano

C) Correcta
EXP: Delante de las secuencias "ia" o "ie" (y también "ua", "ue", "ui") al comienzo de la palabra o sílaba, siempre se escribe H, como en hielo, huevo o hueco.

Pregunta 8: Señale la oración que emplea correctamente las grafías V y B.
A) Tuvo mucha enbidia de su éxito.
B) El equipo se preparó para el adverso clima.
C) Ellos an andado por la calle.
D) Es obvio que no biene.
E) Le entregó el embase vacío.

B) Correcta
EXP: Detrás de N, D y B siempre se escribe V. Por lo tanto, "adverso", "envidia" y "obvio" son correctas con V. Las opciones A y E fallan en esto.

Pregunta 9: ¿En qué caso el uso de las letras mayúsculas exime de colocar la tilde ortográfica?
A) Cuando se escribe todo el texto en mayúsculas.
B) Cuando se trata de títulos o subtítulos.
C) Cuando se trata de un documento oficial de la PNP.
D) En los nombres propios y siglas únicamente.
E) En ningún caso; las mayúsculas siempre deben tildarse si la regla lo exige.

E) Correcta
EXP: No existe ninguna norma ortográfica de la RAE que exima a las letras mayúsculas de llevar tilde; estas deben acentuarse siempre que lo exijan las reglas generales.

Pregunta 10: Señale la palabra que incumple la regla del uso de la H inicial.
A) Huérfano
B) Hueso
C) Hiena
D) Uevo
E) Hielo

D) Correcta
EXP: La palabra "huevo" debe escribirse con H inicial porque comienza con el diptongo "ue", siguiendo la regla estricta de la RAE.

Pregunta 11: Identifique la serie de palabras agudas que llevan tilde correctamente aplicada.
A) Amor, reloj, pared.
B) Canción, compás, manatí.
C) Cántaro, joven, árbol.
D) Bistec, robot, zigzag.
E) Examen, imagen, origen.

B) Correcta
EXP: Las palabras agudas llevan tilde si terminan en vocal, N o S. "Canción" (termina en N), "compás" (termina en S) y "manatí" (termina en vocal) son correctas.

Pregunta 12: Según las reglas de acentuación de las palabras graves, ¿cuál de las siguientes opciones DEBE llevar tilde?
A) Joven
B) Examen
C) Zapato
D) Mártir
E) Sillas

D) Correcta
EXP: "Mártir" es grave y termina en R (que no es N, S ni vocal), por lo tanto lleva tilde obligatoriamente. "Joven", "examen", "zapato" y "sillas" terminan en N, S o vocal y por ello no se tildan.

Pregunta 13: Las palabras "matemáticas", "párroco" y "música" se tildan obligatoriamente porque pertenecen al grupo de las palabras:
A) Agudas
B) Graves
C) Esdrújulas
D) Sobresdrújulas
E) Monosílabas

C) Correcta
EXP: Todas son palabras esdrújulas, ya que tienen la sílaba tónica en la antepenúltima posición, y por regla general todas las esdrújulas se tildan sin excepción.

Pregunta 14: Elija la oración donde el monosílabo "el" / "él" esté correctamente tildado.
A) El me dijo que el perro escapó.
B) Él oficial ordenó el alto.
C) Él me dijo que el perro escapó.
D) El soldado se llevó él arma.
E) Ese libro es de el.

C) Correcta
EXP: "Él" se tilda cuando cumple la función de pronombre personal ("Él me dijo"), mientras que "el" no se tilda cuando funciona como artículo ("el perro").

Pregunta 15: Seleccione el enunciado con el uso correcto del tilde diacrítica en "tu" / "tú".
A) Tú debes traer tu uniforme.
B) Tu debes traer tú uniforme.
C) Tu debes traer tu uniforme.
D) Tú debes traer tú uniforme.
E) Tu informe es mejor que el de tú.

A) Correcta
EXP: "Tú" lleva tilde cuando es pronombre personal ("Tú debes..."), y va sin tilde cuando es adjetivo posesivo ("tu uniforme").

Pregunta 16: Señale la oración que presenta correcta tildación diacrítica de los monosílabos.
A) El té te lo sirvió a tí.
B) A mi me gusta mi nuevo trabajo.
C) Esto es para mí, y mi familia lo sabe.
D) El soldado dió fe de lo ocurrido.
E) El dió un paso al frente por tí.

C) Correcta
EXP: "Mí" (pronombre) lleva tilde, y "mi" (posesivo) no la lleva. Además, "ti", "dio" y "fe" son monosílabos que JAMÁS llevan tilde, lo que invalida las otras opciones.

Pregunta 17: Marque la opción que usa correctamente la tilde en "se" / "sé".
A) Se muy bien que el se fue.
B) Sé muy bien que él sé fue.
C) Sé muy bien que él se fue.
D) Se bueno y dáselo a el.
E) Ya se que no vienes.

C) Correcta
EXP: "Sé" se tilda cuando deriva de los verbos ser o saber ("Sé muy bien"). "Se" no se tilda cuando es pronombre reflexivo o átono ("se fue").

Pregunta 18: Identifique la oración correcta de acuerdo con la norma de la conjunción "o" entre números.
A) Se necesitan 20 ó 30 efectivos para el operativo.
B) Había 5 ó 6 sospechosos en la sala.
C) Asistieron 1 o 2 cadetes a la formación.
D) Compraremos 10 ó 15 carpetas.
E) Fueron 100 ó 200 personas a la marcha.

C) Correcta
EXP: La RAE suprimió de manera absoluta la tilde en la conjunción disyuntiva "o" cuando se escribe entre cifras, ya que la confusión con el cero es inexistente en la actualidad.

Pregunta 19: Seleccione la oración que emplea adecuadamente la tilde diacrítica en "mas" / "más".
A) Quiero mas tiempo para estudiar.
B) Intentó escapar, más la policía lo detuvo.
C) Tiene más fuerza, mas carece de técnica.
D) Habló mas fuerte de lo normal.
E) Dijo que quería mas, más no le dieron.

C) Correcta
EXP: "Más" lleva tilde cuando es adverbio de cantidad ("Tiene más fuerza"), y se escribe sin tilde "mas" cuando es conjunción equivalente a 'pero' ("mas carece de técnica").

Pregunta 20: Señale el uso correcto del monosílabo "de" / "dé".
A) Quiero que me de un poco de agua.
B) Dile que te dé el informe de guardia.
C) La medalla dé oro es tuya.
D) Espero que no de problemas.
E) Viene dé la Escuela de Oficiales.

B) Correcta
EXP: "Dé" lleva tilde cuando es la conjugación del verbo dar ("te dé el informe"), mientras que "de" va sin tilde cuando funciona como preposición ("informe de guardia").

Pregunta 21: Basándose en la normativa vigente de la RAE de 2010, ¿cuál de las siguientes oraciones es la única correcta?
A) Sólo tú sabes el verdadero motivo del delito.
B) Él llegó solo al puesto de control.
C) Ése oficial tiene un legajo intachable.
D) Aquél día llovió torrencialmente.
E) Resolvió los ejercicios él sólo.

B) Correcta
EXP: La RAE eliminó definitivamente la tilde diacrítica en la palabra "solo" (sea adjetivo o adverbio) y en los demostrativos (este, ese, aquel).

Pregunta 22: Identifique la oración que presenta correcta escritura del prefijo "ex" según las actualizaciones de la RAE.
A) El ex-ministro del Interior fue citado a declarar.
B) El ex General dio una entrevista en televisión.
C) El ex primer ministro aseguró que la ley será aprobada.
D) La ex-novia del sospechoso colaboró con la policía.
E) Habló el exComandante de la base naval.

C) Correcta
EXP: El prefijo "ex" se escribe separado de la base léxica únicamente cuando esta es pluriverbal (compuesta por varias palabras), como en "ex primer ministro". Si es una sola palabra, va unido sin guion (exministro, exnovio).

Pregunta 23: De acuerdo con el uso de mayúsculas y minúsculas dictado por la RAE, señale la oración correcta.
A) El Presidente de la República dará un mensaje hoy.
B) El Papa viajará a Brasil el próximo mes.
C) El Alcalde supervisó las obras del puente.
D) El ministro de economía anunció nuevas medidas.
E) El Ministro y el Presidente debatieron la propuesta.

D) Correcta
EXP: Los nombres que designan títulos, cargos o empleos de cualquier rango (presidente, papa, alcalde, ministro) se deben escribir siempre con minúscula inicial.

Pregunta 24: Elija la oración que emplea correctamente la tildación en adverbios terminados en "-mente".
A) Se acercó sigilosamente y lo detuvo rapidamente.
B) El operativo se resolvió fácilménte gracias a la información.
C) Sutilménte ingresó al edificio abandonado.
D) Resolvió el enigma hábilmente y escapó rápidamente.
E) Actuó docilmente ante las autoridades.

D) Correcta
EXP: Los adverbios en "-mente" conservan la tilde del adjetivo base. "Hábilmente" (de hábil) y "rápidamente" (de rápida) llevan tilde; "sutilmente" (de sutil) no la lleva.

Pregunta 25: Respecto a los extranjerismos y su adaptación al español, ¿qué opción representa la norma oficial de la RAE?
A) Se escribe "a grosso modo" siempre en minúsculas.
B) Todos los extranjerismos deben llevar tilde.
C) La palabra "carné" es un extranjerismo adaptado que se somete a las reglas de acentuación del español.
D) Se debe escribir "Iraq" con 'q' al final en español.
E) Se escribe "status quo" sin ninguna marca gráfica o cursiva.

C) Correcta
EXP: Los extranjerismos adaptados al español (como carné, del francés carnet) se someten a las reglas generales de acentuación. Los extranjerismos no adaptados o locuciones latinas deben ir en cursiva.

Pregunta 26: ¿Cuál de las siguientes afirmaciones sobre las actualizaciones de la RAE (2010) es verdadera?
A) Los pronombres demostrativos deben tildarse en caso de ambigüedad.
B) La palabra "solo" lleva tilde si equivale a "solamente".
C) La conjunción "o" lleva tilde si va entre números.
D) La letra "y" debe denominarse oficialmente "ye".
E) El abecedario español cuenta con 29 letras.

D) Correcta
EXP: La RAE recomendó una denominación única para ciertas letras, estableciendo que la "y" debe llamarse "ye" (no "i griega"), la "v" como "uve" y la "w" como "uve doble". Las opciones A, B y C son reglas derogadas.

Pregunta 27: Señale la oración con escritura correcta de prefijos y acentuación.
A) El ex-director de la academia llegó sólo a la ceremonia.
B) Asistirán 20 ó 30 personas a la reunión del ex presidente.
C) Este excomandante general afirmó que el documento es falso.
D) El ex primer ministro leyó el informe rápidamente.
E) Ése ex jefe policial actuó fuera de la ley.

D) Correcta
EXP: "Ex primer ministro" se escribe separado (base pluriverbal). "Rápidamente" lleva tilde (deriva de rápida). Las otras fallan al usar guiones (ex-director), tildar "ó", separar bases univerbales (ex presidente) o tildar demostrativos (Ése).

Pregunta 28: Teniendo en cuenta las reglas para los días, meses y cargos, marque la alternativa correcta.
A) El Lunes 15 de Enero el Alcalde visitó el colegio.
B) El próximo Martes, el Presidente dará un discurso.
C) El lunes 15 de enero el alcalde visitó el colegio.
D) El próximo martes, el presidente dará un discurso.
E) El ministro llegará a la ciudad el lunes de diciembre.

E) Correcta
EXP: Los cargos (ministro), días de la semana (lunes) y meses del año (diciembre) se escriben en minúscula según las normas ortográficas de la RAE, salvo que inicien oración.

Pregunta 29: ¿En qué caso la palabra "aun" debe escribirse SIN tilde?
A) Aun no llega el comandante.
B) Aun los cadetes lesionados terminaron la marcha.
C) No he recibido el informe aun.
D) Espero que aun tengas el valor de decirlo.
E) Dime si aun llueve en la ciudad.

B) Correcta
EXP: La palabra "aun" se escribe sin tilde cuando equivale a "incluso", "hasta" o "también" ("Incluso los cadetes lesionados..."). Se tilda ("aún") cuando puede ser reemplazada por "todavía".

Pregunta 30: Elija la oración que contiene una locución latina escrita correctamente según la RAE.
A) El juez actuó de motu propio.
B) Fue atrapado in fraganti por la patrulla.
C) Su currículum vite es impecable.
D) El acuerdo se firmó *de facto* sin consenso previo.
E) El problema fue resuelto a groso modo.

D) Correcta
EXP: Las locuciones latinas deben escribirse en cursiva para marcar su carácter foráneo (*de facto*). Además, expresiones como "a grosso modo" o "de motu propio" son errores comunes (lo correcto es "grosso modo" y "motu proprio").

Pregunta 31: Analice las reglas ortográficas excepcionales sobre terminaciones consonánticas y monosílabos. Identifique la oración correcta.
A) El jóven cadete desarrolló gran fuerza en el bícep.
B) El truhán elaboró un guión espectacular para la obra.
C) Hubo una explosión porque un ión generó interferencia.
D) Los robots avanzaban haciendo zigzags por el campo.
E) El médico utilizó los fórceps y él vió el resultado.

D) Correcta
EXP: "Robots" y "zigzags" NO llevan tilde porque son agudas terminadas en "s" precedida de consonante. "Truhán", "guión", "ión" y "vió" son monosílabos ortográficos y nunca se tildan. "Jóven" es grave terminada en n, no se tilda.

Pregunta 32: De acuerdo con la normativa sobre palabras terminadas en "S" precedida de consonante, señale la serie de palabras correctamente escrita.
A) Bíceps, fórceps, cómics.
B) Robóts, zigzágs, mamúts.
C) Biceps, forceps, comics.
D) Bíceps, robóts, fórceps.
E) Cómics, zigzágs, bíceps.

A) Correcta
EXP: Las palabras graves que terminan en "s" precedida de consonante sí llevan tilde obligatoriamente (bíceps, fórceps, cómics). Las agudas (robots, zigzags) no la llevan.

Pregunta 33: Señale la oración que presenta correcta escritura en verbos con pronombres enclíticos.
A) Entregaselo al superior inmediatamente.
B) Cómetelo todo y actúa rápidamente.
C) Llevatelo antes de que llegue el oficial.
D) Daselo a él, felizmente no hubo heridos.
E) Resuelvelo agilmente antes del amanecer.

B) Correcta
EXP: "Cómetelo" es una palabra sobresdrújula y, como tal, siempre se tilda. "Rápidamente" conserva la tilde de rápida. "Entrégaselo", "llévatelo", "dáselo" y "resuélvelo" fallan por carecer de sus tildes esdrújulas/sobresdrújulas obligatorias.

Pregunta 34: ¿Cuál de las siguientes palabras es un monosílabo ortográfico que la RAE estipula que NUNCA debe llevar tilde?
A) Qué
B) Él
C) Tú
D) Guion
E) Más

D) Correcta
EXP: "Guion" contiene un diptongo ortográfico y es considerado un monosílabo; a diferencia de los diacríticos (qué, él, tú, más), "guion" no requiere distinción y jamás se tilda.

Pregunta 35: Tomando en cuenta las reglas de prefijos, enclíticos y acentuación, marque la opción correcta.
A) El ex-ministro dijo que se lo dieramos a aquél.
B) El ex primer ministro ordenó: "¡Entrégaselo ahora mismo!".
C) Sólo el excomandante leyó el guión completo.
D) El jóven oficial guardó los cómics y los robóts.
E) El truhán robó el ión del laboratorio.

B) Correcta
EXP: "Ex primer ministro" va separado por ser pluriverbal, y "entrégaselo" se tilda por ser sobresdrújula. Las otras opciones fallan en "ex-ministro" (guion), "dieramos" (sin tilde), "aquél/sólo" (sin tilde), "guión/ión/truhán" (monosílabos sin tilde) y "jóven/robóts" (tildes incorrectas).

Pregunta 36: Analice morfológica y ortográficamente el siguiente verbo: "Cántaselo". ¿Por qué lleva tilde?
A) Porque es una palabra grave terminada en vocal.
B) Porque es aguda y termina en vocal.
C) Porque es una palabra esdrújula.
D) Porque es una palabra sobresdrújula y estas siempre se tildan.
E) Por tildación diacrítica para diferenciarla de "cantaselo".

D) Correcta
EXP: La unión del verbo imperativo "canta" con los pronombres átonos enclíticos "se" y "lo" forma "cán-ta-se-lo", cuya sílaba tónica recae antes de la antepenúltima sílaba, siendo sobresdrújula y tildándose siempre.

Pregunta 37: Identifique la oración que comete un error de tildación en un monosílabo ortográfico con diptongo.
A) El delincuente huyó por la ventana.
B) Juan rio mucho con la broma.
C) El truhán fue capturado ayer.
D) Siempre me guio por el instinto.
E) No me lio con esos problemas.

C) Correcta
EXP: "Truhán" tiene tilde, lo cual es un error ortográfico sancionado por la RAE, ya que es un monosílabo con diptongo ortográfico (truhan) y no debe llevar acento gráfico.

Pregunta 38: Indique la alternativa en la que encontramos un adverbio terminado en "-mente" correctamente tildado de acuerdo con la norma vigente.
A) Tristemente, el rehén falleció.
B) Felizmente, el exministro se salvó.
C) Exitosaménte, culminaron la marcha.
D) Tímidamente, se acercó al estrado.
E) Astutaménte, evadió la seguridad.

D) Correcta
EXP: El adverbio "tímidamente" lleva tilde porque el adjetivo original "tímida" (esdrújula) lleva tilde. "Feliz" y "triste" no llevan tilde, por lo que "felizmente" y "tristemente" tampoco. Las opciones C y E tildan "mente", lo cual es un error sintáctico.

Pregunta 39: En la oración "Aquel día, el ex primer ministro leyó el guion de su discurso y dio un paso al frente", si un postulante coloca tildes en "aquel", "guion" y "dio", estaría cometiendo:
A) Tres errores ortográficos.
B) Dos errores ortográficos.
C) Ningún error, ambas formas son válidas.
D) Un error de tildación diacrítica.
E) Un error de prefijación.

A) Correcta
EXP: Cometería tres errores ortográficos precisos según la RAE 2010: los pronombres demostrativos ("aquel") perdieron la tilde, los monosílabos con diptongo ortográfico ("guion") no se tildan, y "dio" es un monosílabo general que nunca lleva tilde.

Pregunta 40: Seleccione la afirmación FALSA respecto a la normativa de tildación de casos especiales (nivel extremo).
A) "Fórceps" lleva tilde porque es una palabra grave terminada en 's' precedida de consonante.
B) "Robots" no lleva tilde porque es una palabra aguda terminada en 's' precedida de consonante.
C) "Atiéndemelo" lleva tilde porque se convirtió en una palabra sobresdrújula al añadirle enclíticos.
D) "Ión" lleva tilde porque se produce un hiato acentual al pronunciarse en dos sílabas.
E) La palabra "solo" no se tilda ni cuando funciona como adverbio equivalente a "solamente".

D) Correcta
EXP: La afirmación falsa es la D. A efectos de acentuación gráfica, la palabra "ion" se considera monosílaba por contener un diptongo ortográfico y, como todo monosílabo sin diacrítico, NUNCA debe llevar tilde.
'''

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

final List<Question> reglasOrtograficasExt10qQuestions = [
"""
for i, q in enumerate(questions):
    opts_str = ',\n'.join(f'      r"""{opt}"""' for opt in q['options'])
    dart_code += f"""  Question(
    id: "ort_rae_10q_q{i+1}",
    topicId: "eo_pnp_reglas_ortograficas_ext_10q",
    text: r\"\"\"{q['text']}\"\"\",
    options: [
{opts_str}
    ],
    correctAnswer: {q['correct']},
    explanation: r\"\"\"{q['exp']}\"\"\",
  ),
"""

dart_code += "];\n"

with open(r'c:\Users\PC\Downloads\EstudiEO-flutter\lib\data\library\comunicacion\reglas_ortograficas_ext_10q_questions.dart', 'w', encoding='utf-8') as f:
    f.write(dart_code)
