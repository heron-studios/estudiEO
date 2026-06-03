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
        dart_code += f"    id: 'lit_per_10q_q{i+1}',\n"
        dart_code += f"    topicId: 'eo_pnp_literatura_peruana_ext_10q',\n"
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

raw_text = r"""
Pregunta 1: La literatura incaica presentó diversas características esenciales. ¿Cuál de los siguientes términos define su estrecha relación con las labores del campo, las siembras y cosechas?
A) Anónima
B) Clasista
C) Panteísta
D) Agrarista
E) Colectiva

D) Correcta
EXP: La literatura incaica era agrarista ya que sus manifestaciones (como el canto del haylli) estaban íntimamente ligadas al trabajo de la tierra y los ciclos agrícolas.

Pregunta 2: ¿Cómo se denominaba en la literatura lírica prehispánica al canto guerrero, agrario o religioso que expresaba triunfo y alegría colectiva?
A) Harawi
B) Ayataqui
C) Haylli
D) Huanca
E) Aymoray

C) Correcta
EXP: El Haylli era el himno de alegría que se entonaba en las celebraciones de triunfos militares, fiestas religiosas o éxitos agrarios.

Pregunta 3: Es el drama de la época incaica de autor anónimo que relata el amor prohibido de un general de origen plebeyo con la hija del Inca Pachacútec:
A) Uska Paukar
B) El hijo pródigo
C) Tragedia del fin de Atahualpa
D) Ollantay
E) Dioses y hombres de Huarochirí

D) Correcta
EXP: Ollantay es la máxima obra dramática de origen quechua y autor anónimo que narra la rebelión del general Ollantay por su amor hacia Cusi Coyllur.

Pregunta 4: ¿Qué ilustre escritor de la etapa de la Conquista es considerado históricamente como el "primer mestizo biológico y espiritual de América"?
A) Pedro Cieza de León
B) Juan de Betanzos
C) Inca Garcilaso de la Vega
D) Felipe Guamán Poma de Ayala
E) Blas Valera

C) Correcta
EXP: El Inca Garcilaso de la Vega recibe este apelativo por saber asumir, conciliar y expresar en su altísima prosa sus dos herencias culturales: la incaica y la española.

Pregunta 5: La monumental obra "Los Comentarios Reales de los Incas" del Inca Garcilaso de la Vega se dividió en dos grandes partes. ¿Cuál es el tema central de su primera parte publicada en 1609?
A) La destrucción del mundo andino y los abusos españoles.
B) Las guerras civiles entre los conquistadores Pizarro y Almagro.
C) La historia general de la llegada de los españoles al Perú.
D) La geografía y fauna exclusiva del imperio colonial.
E) La historia, costumbres e idolatría de la civilización incaica (idealizada).

E) Correcta
EXP: La primera parte de los Comentarios Reales trata sobre la historia preincaica e incaica exaltando la grandeza de este imperio, mientras que la segunda parte (Historia General del Perú) trata del descubrimiento y las guerras civiles.

Pregunta 6: Cronista indígena autor de una monumental carta al rey de España provista de casi 400 dibujos, donde denuncia la crítica situación de los indios bajo el dominio virreinal:
A) Inca Garcilaso de la Vega
B) Titu Cusi Yupanqui
C) Juan de Santa Cruz Pachacuti
D) Felipe Guamán Poma de Ayala
E) Blas Valera

D) Correcta
EXP: Felipe Guamán Poma de Ayala escribió "Nueva Corónica y Buen Gobierno", una extensa carta ilustrada dirigida al Rey reclamando un mejor trato para los indígenas.

Pregunta 7: Es considerado el precursor del Romanticismo peruano y ofrendó su vida siendo fusilado a los 24 años en la batalla de Umachiri luchando por la patria:
A) Carlos Augusto Salaverry
B) Ricardo Palma
C) Manuel González Prada
D) Mariano Melgar
E) José Faustino Sánchez Carrión

D) Correcta
EXP: Mariano Melgar, apodado el "Poeta Mártir", murió fusilado en 1815 luchando por la Emancipación, y literariamente es el máximo precursor romántico del Perú.

Pregunta 8: ¿Qué especie lírica mestiza, creada a partir de la fusión del harawi quechua con la métrica española, fue cultivada magistralmente por Mariano Melgar para expresar el dolor amoroso?
A) La elegía
B) La oda
C) El yaraví
D) El huayno
E) El epigrama

C) Correcta
EXP: Melgar adaptó el antiguo canto quechua de dolor (harawi) a los moldes y métricas españolas, instaurando de manera inmortal la especie poética del yaraví.

Pregunta 9: La musa inspiradora de los melancólicos yaravíes de Mariano Melgar, a quien el poeta canta su despecho amoroso, fue inmortalizada poéticamente bajo el nombre de:
A) Amarilis
B) Micaela
C) Silvia
D) Ismena
E) Laura

C) Correcta
EXP: La musa de Melgar fue María Santos Corrales, a quien él idealizó e inmortalizó en sus célebres poemas y yaravíes bajo el apelativo poético de Silvia.

Pregunta 10: En la cosmovisión andina que sustentaba a la literatura quechua, existía el "mundo de arriba", morada de dioses máximos como Wiracocha y el Sol. ¿Con qué nombre en quechua se le conocía a este plano divino?
A) Uku Pacha
B) Kay Pacha
C) Hanan Pacha
D) Pachacámac
E) Pariacaca

C) Correcta
EXP: La mitología inca dividía el mundo en el Hanan Pacha (mundo de arriba, de los dioses), el Kay Pacha (mundo terrenal, de los hombres) y el Uku Pacha (mundo de los muertos y fuerzas ocultas).

Pregunta 11: Máximo representante del costumbrismo anticriollista, poseedor de una actitud aristocrática que ridiculizaba los modales populares, autor del artículo de costumbres "Un viaje":
A) Manuel Ascencio Segura
B) Mariano Melgar
C) Manuel González Prada
D) Felipe Pardo y Aliaga
E) Ricardo Palma

D) Correcta
EXP: Felipe Pardo y Aliaga fue la figura central del anticriollismo, desdeñando a la clase popular a través de punzantes críticas como en su obra "Un viaje" (El niño Goyito).

Pregunta 12: Es reconocido históricamente como el "Padre del teatro nacional" peruano por representar magistralmente la idiosincrasia del pueblo en comedias como "Ña Catita":
A) Ricardo Palma
B) Carlos Augusto Salaverry
C) Manuel Ascencio Segura
D) José Santos Chocano
E) Felipe Pardo y Aliaga

C) Correcta
EXP: Manuel Ascencio Segura lideró la vertiente del criollismo costumbrista utilizando un lenguaje popular y festivo en comedias teatrales que retrataban a la clase media limeña.

Pregunta 13: Creador de un subgénero literario genuinamente peruano que fusiona la historia real con la ficción pícara, célebre por su encomiable labor de reconstruir la Biblioteca Nacional del Perú tras el saqueo chileno:
A) Manuel González Prada
B) Abraham Valdelomar
C) Inca Garcilaso de la Vega
D) Ricardo Palma
E) Julio Ramón Ribeyro

D) Correcta
EXP: Ricardo Palma, llamado "El Bibliotecario Mendigo" por su magna obra de restauración tras la Guerra del Pacífico, es el creador de las célebres Tradiciones Peruanas.

Pregunta 14: ¿Cuál es el nombre del género literario original creado por Ricardo Palma en el cual narra de forma jocosa anécdotas ocurridas en el virreinato, la conquista y la república?
A) Leyenda
B) Mito
C) Crónica
D) Tradición
E) Cuento costumbrista

D) Correcta
EXP: Palma inventó la "Tradición", una especie narrativa breve que amalgama datos históricos verídicos con ficción, refranes y chispazos de humor criollo.

Pregunta 15: Poeta cumbre del romanticismo sentimental peruano, autor del legendario poema "Acuérdate de mí", incluido en su poemario "Cartas a un Ángel":
A) Mariano Melgar
B) José Santos Chocano
C) Carlos Augusto Salaverry
D) César Vallejo
E) Abraham Valdelomar

C) Correcta
EXP: Carlos Augusto Salaverry es considerado el mayor poeta lírico del siglo XIX peruano, expresando el dolor romántico y la evocación nostálgica en obras como Cartas a un Ángel.

Pregunta 16: Figura central del Realismo peruano que, mediante feroces ensayos, criticó la descomposición moral de las autoridades tras la Guerra del Pacífico en su libro "Pájinas Libres":
A) Clorinda Matto de Turner
B) Manuel González Prada
C) Ricardo Palma
D) José Carlos Mariátegui
E) Abraham Valdelomar

B) Correcta
EXP: Manuel González Prada lideró el Realismo de posguerra denunciando la corrupción civil y religiosa de la época en incendiarios discursos y ensayos aglutinados en *Pájinas libres* e *Horas de lucha*.

Pregunta 17: "¿En qué discurso patriótico y de reivindicación juvenil Manuel González Prada pronuncia la inmortal arenga "¡Los viejos a la tumba, los jóvenes a la obra!"?
A) Discurso en el teatro Olimpo
B) Ensayo sobre el problema del indio
C) Discurso en el Politeama
D) Prólogo a Pájinas Libres
E) Discurso en San Marcos

C) Correcta
EXP: En 1888, González Prada expuso su célebre Discurso en el Politeama llamando a las nuevas generaciones a tomar las riendas de un país sumergido en el fracaso.

Pregunta 18: ¿Qué importante novela de Clorinda Matto de Turner escandalizó a la sociedad de fines del siglo XIX al denunciar abiertamente los abusos sexuales y económicos de las autoridades contra el indio en los Andes?
A) Matalaché
B) El padre Horán
C) Tradiciones cuzqueñas
D) Aves sin nido
E) Yawar Fiesta

D) Correcta
EXP: "Aves sin nido" (1889) es la primera novela peruana que expone la trágica situación real de la población quechua víctima de gobernadores locales y curas, prefigurando el indigenismo.

Pregunta 19: ¿Con qué apelativo histórico es mundialmente reconocido el poeta modernista peruano José Santos Chocano, por exaltar la geografía y el mestizaje del continente?
A) El Bibliotecario Mendigo
B) El Conde de Lemos
C) El Poeta Mártir
D) El Poeta Universal
E) El Cantor de América

E) Correcta
EXP: José Santos Chocano fue coronado poéticamente y es reconocido como "El Cantor de América" gracias a su obra épica y colorista centrada en el trópico y los Andes.

Pregunta 20: El poema que inicia con los versos: "Soy el cantor de América autóctono y salvaje / mi lira tiene un alma, mi canto un ideal", pertenece al insigne exponente del modernismo peruano:
A) Abraham Valdelomar
B) José María Eguren
C) José Santos Chocano
D) César Vallejo
E) Martín Adán

C) Correcta
EXP: Esos versos pertenecen a "Blasón", un poema autobiográfico y manifiesto estético que forma parte del libro *Alma América* del gran José Santos Chocano.

Pregunta 21: ¿Quién fue el director de la efímera pero sumamente influyente revista literaria *Colónida* (1916), grupo que atacó el academicismo rígido de su época e impulsó los aires de renovación literaria en el Perú?
A) José Santos Chocano
B) Abraham Valdelomar
C) Manuel González Prada
D) José Carlos Mariátegui
E) César Vallejo

B) Correcta
EXP: Abraham Valdelomar, líder de la generación posmodernista, fundó y dirigió la innovadora revista literaria Colónida, atrayendo a múltiples escritores jóvenes.

Pregunta 22: ¿Qué aclamado cuento de Abraham Valdelomar, ambientado en San Andrés de los Pescadores (Pisco), retrata con profundo tono nostálgico la épica victoria y consiguiente muerte de un valeroso gallo de pelea?
A) El vuelo de los cóndores
B) Los ojos de Judas
C) El Caballero Carmelo
D) Los hijos del sol
E) Evaristo, el sauce que murió de amor

C) Correcta
EXP: "El Caballero Carmelo" es el cuento fundacional de la estética provinciana de Valdelomar, y nos narra la gloriosa historia del veterano gallo Carmelo y su triunfo letal ante el Ajiseco.

Pregunta 23: Extraordinario poeta que mantuvo un espíritu insular y puro, en su obra abundan seres misteriosos infantiles e imágenes cromáticas sugerentes que plasman estados de ánimo. Autor de "Simbólicas" y "La canción de las figuras".
A) José Santos Chocano
B) Martín Adán
C) César Moro
D) José María Eguren
E) Alberto Hidalgo

D) Correcta
EXP: José María Eguren fue un poeta singular cercano a la estética del simbolismo europeo, creador de una poética de sugerencia musical y colorida imaginación (poesía pura).

Pregunta 24: Dentro de la literatura peruana de inicios del siglo XX, ¿qué obra representa la más colosal hazaña del Vanguardismo al violentar radicalmente el lenguaje, romper con la lógica y reinventar neologismos?
A) Fabla salvaje
B) La casa de cartón
C) Los heraldos negros
D) Poemas humanos
E) Trilce

E) Correcta
EXP: Trilce, de César Vallejo, publicada en 1922, es la cúspide vanguardista en lengua castellana; rompió todo esquema sintáctico, métrico y ortográfico precedente.

Pregunta 25: El profundo poema de César Vallejo que encabeza su primera publicación poética y que contiene el verso "Hay golpes en la vida, tan fuertes... ¡Yo no sé!", pertenece a su obra:
A) Los dados eternos
B) Poemas humanos
C) Los heraldos negros
D) Trilce
E) Masa

C) Correcta
EXP: "Los heraldos negros" (1919) es la magna obra de la etapa inicial modernista de Vallejo, siendo el poema homónimo el que refleja de forma angustiosa el inexplicable dolor humano.

Pregunta 26: ¿Qué obras conforman la tercera etapa de la producción poética de César Vallejo, caracterizada por un hondo humanismo marxista y una férrea solidaridad ante el dolor ajeno de la clase explotada?
A) Trilce y Escalas melografiadas
B) Poemas humanos y España, aparta de mí este cáliz
C) El tungsteno y Paco Yunque
D) Los heraldos negros y Trilce
E) Fabla salvaje y Rusia en 1931

B) Correcta
EXP: "Poemas humanos" y "España, aparta de mí este cáliz" son los últimos poemarios escritos por Vallejo en Europa bajo la fuerte influencia de su ideología comunista y la Guerra Civil Española (poesía social).

Pregunta 27: Se le considera el pionero de la corriente indigenista peruana, ya que con su libro *Cuentos andinos* (1920) retrató la psicología cruda y brutal de los indígenas desde su rol como juez penal de la sierra:
A) Clorinda Matto de Turner
B) Manuel Scorza
C) Ciro Alegría
D) Enrique López Albújar
E) José María Arguedas

D) Correcta
EXP: Enrique López Albújar, a través de su labor judicial, compiló historias sobre la violencia y criminalidad andina en *Cuentos andinos*, marcando el inicio del indigenismo del siglo XX.

Pregunta 28: En la novela monumental *El mundo es ancho y ajeno*, ¿cómo se llama el desalmado hacendado y gamonal corrupto que despoja ilegalmente de sus tierras a los comuneros de Rumi?
A) Benito Castro
B) Rosendo Maqui
C) Álvaro Amenábar
D) El Fiero Vásquez
E) Demetrio Sumallacta

C) Correcta
EXP: Álvaro Amenábar representa el poder explotador oligárquico de las haciendas andinas en la genial novela de Ciro Alegría, enfrentándose de forma implacable al alcalde indio Rosendo Maqui.

Pregunta 29: Considerado por la crítica internacional como el "escritor etnólogo", su narrativa indigenista destaca por mostrar el alma, la magia y el pensamiento del indio quechua "desde adentro", utilizando en sus diálogos una fusión lingüística quechua-española:
A) José Carlos Mariátegui
B) Julio Ramón Ribeyro
C) Ciro Alegría
D) José María Arguedas
E) Mario Vargas Llosa

D) Correcta
EXP: José María Arguedas, criado por sirvientes indígenas, asimiló de forma bilingüe y antropológica la visión mágico-religiosa del quechua, reflejándola íntimamente en su literatura.

Pregunta 30: En la famosa novela *Los ríos profundos* de José María Arguedas, Ernesto, un niño que oscila entre el mundo andino de sus cuidadores y el mundo criollo dominante, encuentra refugio espiritual y místico mediante un juguete. ¿Cuál es ese objeto?
A) Una honda
B) El zumbayllu (trompo)
C) Un retablo de madera
D) Un silbato andino
E) El huaco mágico

B) Correcta
EXP: El "Zumbayllu" es un trompo de fabricación andina que, para el personaje Ernesto, posee propiedades divinas y mágicas en el áspero ambiente del internado de Abancay.

Pregunta 31: En el marco literario de la Generación del 50 en el Perú, ¿qué fenómeno demográfico y sociocultural fundamental sirve de inspiración y contexto central para el desarrollo del llamado "realismo urbano"?
A) La migración interna masiva de pobladores de los Andes hacia Lima y la subsecuente aparición de las barriadas periféricas de extrema pobreza.
B) La reconstrucción económica producto de la inmensa venta del guano y salitre a mercados europeos de posguerra.
C) El choque violento armado durante las revueltas subversivas guerrilleras financiadas en la Amazonía peruana.
D) El impacto del cine comercial norteamericano en las élites criollas y su paulatina asimilación europea.
E) La implementación de las reformas de la revolución militar orientada a desarticular la oligarquía azucarera costeña.

A) Correcta
EXP: El realismo urbano de la Generación del 50 refleja el doloroso proceso de modernización de la capital y la gigantesca ola de marginados provocada por el violento y acelerado proceso de migración de la sierra a la costa.

Pregunta 32: Considerado el mejor exponente de la cuentística urbana hispanoamericana, bautizó su gran compilación de relatos como "La palabra del mudo" para brindarle voz narrativa a aquellos seres humanos invisibles, perdedores y marginados de la nueva urbe limeña. ¿De quién hablamos?
A) Mario Vargas Llosa
B) Alfredo Bryce Echenique
C) Ciro Alegría
D) Julio Ramón Ribeyro
E) Oswaldo Reynoso

D) Correcta
EXP: Julio Ramón Ribeyro es la cumbre indiscutible de la Generación del 50. Tituló toda su antología cuentística como "La palabra del mudo" porque sus relatos reivindicaban a los desposeídos y marginados.

Pregunta 33: Identifique el grupo de personajes que integran el desgarrador y marginal universo del clásico relato "Los gallinazos sin plumas", la gran obra maestra cuentística de Julio Ramón Ribeyro:
A) Ernesto, Zumbayllu, Froylán.
B) Cunce Maille, Calixto Garmendia, El Fiero Vásquez.
C) Efraín, Enrique, el cerdo Pascual y el abusivo abuelo Don Santos.
D) El Poeta, El Jaguar, El Esclavo y el Teniente Gamboa.
E) Zavalita, Carlitos, Cayo Bermúdez y Ambrosio.

C) Correcta
EXP: "Los gallinazos sin plumas" expone la cruel vida de Efraín y Enrique, forzados a escarbar en muladares de basura para dar de comer al cerdo Pascual bajo el autoritarismo patológico de su abuelo Don Santos.

Pregunta 34: ¿En cuál de sus renombradas novelas Mario Vargas Llosa desglosa y denuncia duramente las estructuras de poder militar, los pactos del machismo, la violencia institucionalizada y la traición adolescente, ambientándola dentro del colegio militar Leoncio Prado?
A) Pantaleón y las visitadoras
B) Los jefes
C) La tía Julia y el escribidor
D) La ciudad y los perros
E) La fiesta del Chivo

D) Correcta
EXP: "La ciudad y los perros" (1963) marcó un hito en el Boom narrativo. A través del Poeta, el Esclavo y el Jaguar, Vargas Llosa hace trizas el corrupto microcosmos formativo militar de la capital.

Pregunta 35: A través de los monólogos y diálogos de su personaje "Zavalita", quien arranca la novela con la icónica pregunta "¿En qué momento se había jodido el Perú?", Vargas Llosa critica despiadadamente la podredumbre civil bajo la dictadura de Manuel A. Odría. ¿Cómo se llama esta majestuosa obra?
A) La guerra del fin del mundo
B) Conversación en La Catedral
C) El pez en el agua
D) La casa verde
E) Cinco esquinas

B) Correcta
EXP: "Conversación en La Catedral" (1969) es el mayor diagnóstico político-narrativo de la época de Odría; los diálogos de Zavalita y Ambrosio revelan el descalabro del país de la Generación del 50.

Pregunta 36: Eminente novela irónica y nostálgica del año 1970 escrita por Alfredo Bryce Echenique, cuya temática es el contraste del vacío afectivo en la alta burguesía frente a la calidez de la servidumbre andina y afrodescendiente experimentada por un niño adinerado:
A) Un mundo para Julius
B) El huerto de mi amada
C) Los perros hambrientos
D) Redoble por Rancas
E) La palabra del mudo

A) Correcta
EXP: "Un mundo para Julius" consagra a Bryce Echenique como agudo y tierno retratista del fin de la decadente oligarquía limeña, oponiendo a sus sirvientes Vilma, Celso y Daniel con su familia clasista.

Pregunta 37: Obra literaria adscrita al "Neoindigenismo" cuyo telón de fondo histórico no es la vieja hacienda feudal, sino el crudo enfrentamiento de organizaciones campesinas modernas en Cerro de Pasco contra poderosos consorcios multinacionales mineros en el Perú central:
A) Todas las sangres
B) El mundo es ancho y ajeno
C) Matalaché
D) Raza de bronce
E) Redoble por Rancas

E) Correcta
EXP: "Redoble por Rancas", escrita por Manuel Scorza en 1970, eleva a novela el combate histórico y letal de las comunidades altoandinas cerreñas contra la Cerro de Pasco Corporation y el imperialismo norteamericano.

Pregunta 38: ¿Qué insigne poetisa peruana de la Generación del 50, dueña de una voz poética desgarradoramente introspectiva y reflexiva ante una cruda realidad y considerada una de las más trascendentes del siglo, escribió el magistral poemario "Ese puerto existe"?
A) Magda Portal
B) Clorinda Matto de Turner
C) Carmen Ollé
D) Blanca Varela
E) María Emilia Cornejo

D) Correcta
EXP: Blanca Varela es la cima de la poesía femenina del medio siglo; dotada de una visión existencial de alta condensación conceptual, irrumpe internacionalmente apadrinada por Octavio Paz con su libro *Ese puerto existe*.

Pregunta 39: En el marco del magistral "Boom Latinoamericano", Mario Vargas Llosa patentó diversas técnicas vanguardistas en sus narraciones. ¿Cómo se denomina técnicamente a la fusión sorpresiva y simultánea de múltiples diálogos correspondientes a distintos tiempos o lugares en un solo bloque narrativo, dotándolo de simultaneidad y atemporalidad estructural?
A) Dato escondido
B) Vasos comunicantes
C) Cajas chinas
D) Retrospección analéptica
E) Flashforward lineal

B) Correcta
EXP: La técnica de "vasos comunicantes" (o diálogos telescópicos y simultáneos) es el sello constructivista más complejo de Vargas Llosa, obligando al lector a participar en el salto violento entre distintos cronotopos amalgamados.

Pregunta 40: ¿Qué radical movimiento poético y vanguardista peruano nace en la "Generación del 70" (con fundadores como Jorge Pimentel, Juan Ramírez Ruiz y Enrique Verástegui), rechazando furibundamente toda la tradición artística literaria anterior de la burguesía y propugnando un lenguaje áspero del proletariado barrial bajo la forma del "poema integral"?
A) Grupo Gleba Literaria
B) Grupo Colónida
C) Movimiento Hora Zero
D) Grupo Kloaka
E) Generación Arielista

C) Correcta
EXP: El Movimiento Hora Zero irrumpió poéticamente en 1970 con su Manifiesto "Palabras Urgentes", exigiendo una revolución social y estética demoliendo las pautas de escritura convencionales del parnaso limeño y alzando las vivencias del suburbio obrero.
"""

questions_data = parse_questions(raw_text)

dart_code = generate_dart_code(questions_data, "literaturaPeruanaExt10qQuestions")

with open('lib/data/library/comunicacion/literatura_peruana_ext_10q_questions.dart', 'w', encoding='utf-8') as f:
    f.write(dart_code)

print(f"Generated {len(questions_data)} questions.")
