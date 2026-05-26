const String redesVialesTheoryEasy = r"""
La infraestructura vial de la República del Perú está estructurada de manera jerárquica a través del Sistema Nacional de Carreteras (SINAC), que comprende todas las carreteras de dominio público y su correspondiente Derecho de Vía. El objetivo del SINAC es orientar las decisiones de inversión, organizar la logística del transporte terrestre y definir claramente las competencias institucionales para su mantenimiento, conservación y operación. De acuerdo a las normativas del Ministerio de Transportes y Comunicaciones (MTC), el SINAC se subdivide en tres niveles u órdenes:

Red Vial Nacional: Une las capitales de los 24 departamentos y la Provincia Constitucional del Callao. Es de competencia exclusiva del MTC (a través de Provías Nacional o empresas concesionarias). Físicamente se identifica con postes kilométricos blancos y negros, el uso del color rojo en los mapas viales, un emblema en forma de escudo y códigos que inician con el prefijo "PE" (Perú).

Red Vial Departamental o Regional: Integra a las provincias de una región y conecta las capitales de provincia. Su administración y conservación recaen legalmente en los Gobiernos Regionales. Se identifica gráficamente mediante el color azul, postes azules y blancos, un emblema departamental, y su codificación inicia con dos letras del departamento seguidas de una numeración comprendida entre el 100 y el 499.

Red Vial Provincial o Vecinal/Rural: Conecta las capitales de distrito dentro de una provincia. Está bajo la responsabilidad de las Municipalidades Provinciales y Distritales. Utiliza el color verde en los mapas, postes verdes y blancos, y en su codificación se asignan las dos letras de la región seguidas de una numeración del 500 en adelante.

Cabe resaltar que, en todos los niveles, los puentes que se ubican en una red vial específica asumen automáticamente la competencia de la entidad encargada de dicha red.
""";

const String redesVialesTheoryMedium = r"""
El diseño, nomenclatura y ordenamiento geométrico de la Red Vial Nacional exige precisión absoluta, ya que soporta el tránsito logístico de larga distancia y articula la geografía extrema del Perú. Esta red se divide funcionalmente en dos grandes tipos de ejes, de acuerdo con el Clasificador de Rutas del MTC:

Ejes Longitudinales: Son las carreteras vertebrales que recorren el territorio uniendo las fronteras limítrofes norte y sur del país. Numéricamente, el MTC ha estipulado que se identifican obligatoriamente con el prefijo "PE" seguido de una numeración impar de un solo dígito (ej. PE-1 para la Panamericana, PE-3 para la Longitudinal de la Sierra, y PE-5 para la Marginal de la Selva).

Ejes Transversales (o de penetración): Son carreteras cuya medición y desarrollo se hace de oeste a este. Tienen la vital función de atravesar transversalmente la geografía peruana conectando los ejes longitudinales de la Costa, la Sierra y la Selva, facilitando el acceso a puertos. Numéricamente, se identifican con una numeración par y, salvo excepciones documentadas, inician forzosamente en un punto notable del eje longitudinal de la costa.

El inicio topográfico y de medición kilométrica de los grandes ejes longitudinales se denomina oficialmente "Kilómetro 0" y está estandarizado en puntos notables del centro del país. Para el eje PE-1 (Costa) el Km 0 se ubica en el Puente Santa Anita (Lima); para el eje PE-3 (Sierra) inicia en la Repartición de La Oroya (Junín); y para el eje PE-5 (Selva), su Km 0 se encuentra establecido en el Puente Reither, en el distrito de Chanchamayo (Junín). Asimismo, por norma de infraestructura vial y diseño, la intersección entre un Eje Longitudinal con un Eje Transversal debe resolverse a través de una solución de continuidad geométrica fluida: un óvalo.
""";

const String redesVialesTheoryHard = r"""
El Nuevo Reglamento de Jerarquización Vial (Decreto Supremo 015-2024-MTC) modernizó varios conceptos técnicos, normativos y jurídicos para adaptar las carreteras a un mundo interconectado y brindar seguridad jurídica para la inversión pública y privada. Entre los pilares definitorios se encuentran:

Derecho de vía: Es la faja de terreno de dominio público, de ancho variable, dentro del cual se aloja la carretera y todos sus elementos conformantes. Este espacio inalienable garantiza áreas previstas para futuros ensanches, construcción de servicios y, sobre todo, zonas de seguridad y retiro para salvaguardar la vida humana frente al tránsito. El ancho oficial se fija a través de una resolución emitida por la autoridad competente.

Corredor Logístico: Un modelo que busca integrar la red física. Es el conjunto o eje que articula infraestructuras de transporte terrestre, ferroviario, aéreo o multimodal desde un origen hacia un destino. Su finalidad primordial no es solo que transiten vehículos, sino facilitar el flujo de carga, información y pasajeros en óptimas condiciones comerciales, logrando tiempos reducidos y costos competitivos en los mercados.

El MTC prevé un mecanismo excepcional para dinamizar la inversión llamado "Reclasificación Vial Temporal". Este mecanismo permite que se cambie temporalmente la jerarquía de una ruta para posibilitar que una entidad, que no es la autoridad titular pero que cuenta con los recursos presupuestales demostrados, asuma la competencia transitoriamente y pueda ejecutar una obra vial planificada. Sin embargo, la norma establece una condición de caducidad estricta para evitar proyectos paralizados: si transcurre más de un (1) año desde la emisión de la Resolución Ministerial que dispuso esta reclasificación temporal, sin que la autoridad beneficiada inicie o contrate las intervenciones, la medida queda sin efecto, caduca, y la vía retorna a su dueño original y clasificación inicial. Cuando la obra vial o proyecto se concluye exitosamente, la carretera también retorna automáticamente a su jerarquía de origen.
""";

const String redesVialesTheoryExtreme = r"""
El ordenamiento territorial requiere mecanismos estrictos para proteger a la ciudadanía de externalidades negativas de alto impacto (costos sociales, contaminación o riesgos inminentes originados por el flujo del tránsito). Ante esto, el DS 015-2024-MTC instaura la "Declaración de áreas o vías de acceso restringido". Según el artículo 23 de dicho reglamento, una autoridad competente puede restringir la circulación en el dominio de sus vías si aplica criterios como:

Contaminación ambiental en niveles no permisibles (creando así zonas restringidas o de baja/cero emisiones).

Peligro inminente de desastre natural debido a causas de geodinámica interna o externa declarada oficialmente por INDECI o entidad competente.

Vulneración crítica a la Defensa Nacional, peso bruto vehicular excesivo para la estabilidad del asfalto o congestión vial que colapse el nivel de servicio.

A pesar de que las municipalidades y Gobiernos Regionales tienen prerrogativas sobre sus redes locales y la obligación de instalar dispositivos de control de tránsito que señalen restricciones, existe una prohibición drástica e infranqueable dictada por la normativa nacional: Ninguna autoridad de gobierno subnacional (Regional o Local) tiene permitido aplicar medidas de restricción de circulación que afecten o comprendan a las carreteras de la Red Vial Nacional. Esta restricción se mantiene incólume incluso cuando dichas carreteras nacionales atraviesan longitudinalmente cascos o zonas urbanas. La potestad absoluta de limitar, restringir o cortar el tráfico de la Red Vial Nacional es exclusiva e indelegable del MTC a través de la Dirección General de Políticas y Regulación en Transporte Multimodal (DGPRTM).

Finalmente, la seguridad legal y planificación del desarrollo logístico del Perú reposa en un "Libro Maestro" denominado Clasificador de Rutas del SINAC. Para garantizar que esta base cartográfica no quede desfasada con las realidades demográficas del país, el MTC se encuentra obligado, a través de la Dirección General de Programas y Proyectos de Transportes (DGPPT), a actualizarlo y proponer su aprobación vía Decreto Supremo, con una periodicidad máxima obligatoria de cada tres (3) años.
""";
