import 'package:learn/models/question.dart';

final List<Question> redesVialesQuestions = [
  // ====== NIVEL FÁCIL ======
  Question(
    id: 'pfrh_rv_easy_1',
    topicId: 'cs_t5',
    text:
        r'''De acuerdo con el Reglamento de Jerarquización Vial y el SINAC, si un efectivo policial transita por una carretera que une a dos distritos dentro de una misma jurisdicción, y observa postes kilométricos pintados de verde y blanco, con una señalética que indica un código numérico superior a 500. ¿A qué red vial pertenece y qué nivel de gobierno tiene competencia legal sobre su mantenimiento?''',
    options: [
      r'''Pertenece a la Red Vial Nacional y es competencia de Provías Nacional bajo el MTC.''',
      r'''Pertenece a la Red Vial Departamental y es competencia del Gobierno Regional respectivo.''',
      r'''Pertenece a la Red Vial Provincial o Vecinal y se encuentra bajo la responsabilidad y competencia de las Municipalidades Provinciales y Distritales.''',
      r'''Pertenece a la Red Vial Concesionada y es competencia exclusiva de consorcios privados.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''La Red Vial Vecinal o Provincial une los distritos dentro de cada provincia, está a cargo de los gobiernos locales (municipalidades), sus mapas y postes usan el color verde, y su numeración obligatoria inicia a partir del número 500.''',
  ),

  Question(
    id: 'pfrh_rv_easy_2',
    topicId: 'cs_t5',
    text:
        r'''El Estado peruano delega competencias sobre el Sistema Nacional de Carreteras a diferentes entidades. ¿Qué organismo es el responsable exclusivo del planeamiento, operación y administración de la Red Vial Nacional, incluso si sus rutas atraviesan áreas urbanas?''',
    options: [
      r'''Las Municipalidades Provinciales, a través de sus oficinas de tránsito locales.''',
      r'''El Gobierno Regional, por estar dentro de la demarcación de su territorio geográfico.''',
      r'''La Superintendencia de Transporte Terrestre de Personas, Carga y Mercancías (SUTRAN).''',
      r'''El Gobierno Nacional a través del Ministerio de Transportes y Comunicaciones (MTC).''',
    ],
    correctAnswer: 3,
    explanation:
        r'''La normativa especifica que el MTC es la autoridad competente a cargo de la infraestructura de la Red Vial Nacional de manera exclusiva, incluso en los tramos donde estas carreteras de escala nacional atraviesan zonas urbanas.''',
  ),

  // ====== NIVEL MEDIO ======
  Question(
    id: 'pfrh_rv_medium_1',
    topicId: 'cs_t5',
    text:
        r'''Como policía de carreteras, es indispensable dominar la codificación del Sistema Nacional de Carreteras (SINAC) para la elaboración de atestados o partes por accidentes. ¿Cómo se distinguen numéricamente en la codificación nacional los "Ejes Longitudinales" frente a los "Ejes Transversales o de penetración"?''',
    options: [
      r'''Los longitudinales carecen de números, usando solo letras como "PE-N" o "PE-S", mientras los transversales usan numeración del 100 al 400.''',
      r'''Ambos usan números aleatorios superiores a 500 asignados por el Gobierno Regional donde nacen.''',
      r'''Los Ejes Longitudinales se identifican obligatoriamente con números impares de un solo dígito (Ej. PE-1, PE-3), mientras que los Transversales o de penetración utilizan numeración par.''',
      r'''Los Ejes Longitudinales están formados por números pares progresivos y los Ejes Transversales por números impares siempre acompañados por el emblema azul.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El Clasificador de Rutas establece que la Red Vial Nacional identifica a sus carreteras longitudinales (norte-sur) con números impares de un dígito, y a sus ejes transversales o de penetración (oeste-este) con numeración par.''',
  ),

  Question(
    id: 'pfrh_rv_medium_2',
    topicId: 'cs_t5',
    text:
        r'''El cálculo de los recorridos viales e indemnizaciones logísticas requiere ubicar topográficamente el punto de origen de una vía. Según el MTC, ¿en qué punto geográfico exacto se ha establecido oficialmente el "Kilómetro 0" (Km 0) del Eje Longitudinal de la Selva (Ruta Nacional PE-5)?''',
    options: [
      r'''En la frontera norte de Amazonas (Río Nieva).''',
      r'''En el Puente Santa Anita, ciudad de Lima.''',
      r'''En el Puerto de Yurimaguas, región Loreto.''',
      r'''En el Puente Reither, provincia de Chanchamayo (departamento de Junín).''',
    ],
    correctAnswer: 3,
    explanation:
        r'''Según la estructura formal del MTC, el Km 0 de la Longitudinal de la Selva (PE-5) se encuentra fijado oficialmente en el Puente Reither, distrito de Chanchamayo, región Junín.''',
  ),

  // ====== NIVEL DIFÍCIL ======
  Question(
    id: 'pfrh_rv_hard_1',
    topicId: 'cs_t5',
    text:
        r'''Según el Glosario y las definiciones técnicas vigentes del MTC para infraestructura terrestre, ¿cuál es el concepto jurídico exacto que define a la "faja de terreno de ancho variable destinada a alojar la carretera, sus elementos, futuras obras de ensanche y que preserva las zonas de seguridad para el usuario de la vía"?''',
    options: [
      r'''Plataforma Logística''',
      r'''Vía de evitamiento perimetral''',
      r'''Derecho de vía''',
      r'''Prisma vial''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El "Derecho de Vía" es el espacio jurídico y físico de ancho variable establecido por resolución para albergar a la carretera, resguardando el terreno para futuras ampliaciones y garantizando zonas de seguridad laterales para los usuarios.''',
  ),

  Question(
    id: 'pfrh_rv_hard_2',
    topicId: 'cs_t5',
    text:
        r'''Un Gobierno Regional solicita y obtiene una "Reclasificación Vial Temporal" de una carretera nacional en su territorio, aludiendo que tiene fondos del canon para asfaltarla. Basándose en la normativa del SINAC y el DS 015-2024-MTC, ¿cuál es la sanción legal que impone la norma si este Gobierno Regional retrasa el inicio del proyecto?''',
    options: [
      r'''Si la obra no concluye en 5 años, el Gobierno Regional es multado por la Contraloría, pero retiene el control de la vía para siempre.''',
      r'''Se le retira el presupuesto del canon minero, pasando automáticamente a otra región adyacente.''',
      r'''El tramo se convierte definitivamente en una vía vecinal bajo custodia de una empresa concesionaria privada.''',
      r'''Si transcurre más de un (1) año desde la Resolución Ministerial sin que el Gobierno Regional inicie o contrate las obras proyectadas, la reclasificación temporal pierde vigencia y la vía retorna a su jerarquía original.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El DS 015-2024-MTC estipula claramente que una reclasificación temporal caduca y queda sin efecto si transcurre más de un (1) año sin que la autoridad que la solicitó inicie o contrate las obras, debiendo devolver la ruta a su dueño correspondiente.''',
  ),

  // ====== NIVEL EXTREMO ======
  Question(
    id: 'pfrh_rv_extreme_1',
    topicId: 'cs_t5',
    text:
        r'''Una municipalidad provincial, en aras de disminuir la contaminación ambiental en su ciudad y mejorar el ordenamiento local, emite una ordenanza que prohíbe el tráfico pesado las 24 horas del día. Sin embargo, dicha medida corta el pase a la Ruta Longitudinal de la Sierra (Red Vial Nacional) que atraviesa el centro urbano de su ciudad. A la luz del DS 015-2024-MTC, ¿esta ordenanza municipal es legal y ejecutable?''',
    options: [
      r'''Sí, porque la Constitución otorga a las municipalidades poder absoluto sobre todo el tránsito que cruce su casco urbano, amparado en su autonomía edil.''',
      r'''Sí, siempre y cuando presenten a Provías Nacional un "Plan de Vías Alternas" con 30 días de anticipación y el aval del Ministerio del Ambiente.''',
      r'''No, es inaplicable, ya que la normativa señala que las medidas de restricción de áreas o vías de gobiernos locales o regionales no pueden comprender ni afectar la Red Vial Nacional, incluso al cruzar zonas urbanas, lo cual es competencia exclusiva del MTC.''',
      r'''No, es inaplicable debido a que las vías longitudinales solo pueden ser restringidas por el Comando Conjunto de las Fuerzas Armadas bajo Estado de Sitio.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El artículo 28 del DS 015-2024-MTC establece categóricamente que ninguna medida de restricción dictada por gobiernos subnacionales puede afectar a la Red Vial Nacional, inclusive en las áreas de travesía urbana, siendo una potestad única del MTC.''',
  ),

  Question(
    id: 'pfrh_rv_extreme_2',
    topicId: 'cs_t5',
    text:
        r'''El Sistema Nacional de Carreteras (SINAC) necesita tener su inventario de infraestructura formalizado para otorgar seguridad jurídica ante la concesión de redes viales. Según el reglamento de jerarquización vigente, ¿qué entidad gubernamental propone la actualización del "Clasificador de Rutas" y con qué frecuencia de tiempo máxima, y obligatoria, debe ser actualizado y aprobado mediante Decreto Supremo?''',
    options: [
      r'''Lo proponen los Gobiernos Regionales, siendo actualizado de forma anual en conjunto con el presupuesto de la República.''',
      r'''Lo propone la Presidencia del Consejo de Ministros (PCM) a través de INEI, siendo actualizado obligatoriamente cada diez (10) años, luego del censo nacional.''',
      r'''Lo propone SUTRAN, en coordinación con el INDECI, siendo actualizado cada cinco (5) años coincidiendo con el periodo presidencial.''',
      r'''Lo propone el MTC a través de su Dirección General de Programas y Proyectos de Transportes (DGPPT), y debe ser actualizado y aprobado mediante Decreto Supremo cada tres (3) años.''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El Clasificador de Rutas es el documento matriz del SINAC. La norma vigente determina que la DGPPT es responsable de elaborar y proponer su actualización vía Decreto Supremo cada tres (3) años, contados desde su última aprobación.''',
  ),
];
