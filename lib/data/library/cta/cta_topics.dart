import 'package:learn/models/topic.dart';
import 'materia_energia_theory.dart';
import 'sistema_solar_theory.dart';
import 'tabla_periodica_theory.dart';
import 'vegetales_fotosintesis_theory.dart';
import 'fenomenos_cambioclimatico_theory.dart';

final Map<String, Topic> ctaTopics = {
  // Topics sin teoría (solo quiz) - comentados para ocultar del modo aprendizaje guiado
  // 'cta_t1': Topic(
  //   id: 'cta_t1',
  //   subjectId: 'cta',
  //   name: "1. Fisica y Cinematica",
  //   description: "Magnitudes, vectores, MRU, MRUV, leyes de Newton, trabajo, potencia y energia.",
  //   questionCount: 153,
  // ),
  // 'cta_t2': Topic(
  //   id: 'cta_t2',
  //   subjectId: 'cta',
  //   name: "2. Quimica de la Materia",
  //   description: "Materia, tabla periodica, carbono, biomoleculas, mezclas y sustancias.",
  //   questionCount: 155,
  // ),
  // 'cta_t3': Topic(
  //   id: 'cta_t3',
  //   subjectId: 'cta',
  //   name: "3. Mundo Viviente y Citologia",
  //   description: "Celula, organelos, transporte celular, reinos, organizacion biologica y fotosintesis.",
  //   questionCount: 153,
  // ),
  // 'cta_t4': Topic(
  //   id: 'cta_t4',
  //   subjectId: 'cta',
  //   name: "4. Cosmologia, Clima y Medio Ambiente",
  //   description: "Sistema solar, cambio climatico, capa de ozono, glaciares y conservacion ambiental.",
  //   questionCount: 154,
  // ),
  
  // Topics con teoría (modo aprendizaje guiado)
  'cta_materia_energia': Topic(
    id: 'cta_materia_energia',
    subjectId: 'cta',
    name: "1. Materia y Energía",
    description: "Propiedades de la materia, estados de agregación y transformaciones energéticas.",
    questionCount: 80,
    theoryByLevel: materiaEnergiaTheory,
  ),
  'cta_sistema_solar': Topic(
    id: 'cta_sistema_solar',
    subjectId: 'cta',
    name: "2. El sistema solar. Planeta Tierra.",
    description: "El sistema solar, astros y planetas. Dinámicas, movimientos y características de la Tierra.",
    questionCount: 40,
    theoryByLevel: sistemaSolarTheory,
  ),
  'cta_tabla_periodica': Topic(
    id: 'cta_tabla_periodica',
    subjectId: 'cta',
    name: "3. Tabla periódica de los elementos (símbolos y organización)",
    description: "Estructura, símbolos, organización en grupos/periodos y tendencias periódicas.",
    questionCount: 40,
    theoryByLevel: tablaPeriodicaTheory,
  ),
  'cta_vegetales_fotosintesis': Topic(
    id: 'cta_vegetales_fotosintesis',
    subjectId: 'cta',
    name: "4. Los vegetales y la fotosíntesis",
    description: "Procesos de fotosíntesis, fases luminosa y oscura, cloroplastos y ciclos bioquímicos.",
    questionCount: 40,
    theoryByLevel: vegetalesFotosintesisTheory,
  ),
  'cta_fenomenos_cambioclimatico': Topic(
    id: 'cta_fenomenos_cambioclimatico',
    subjectId: 'cta',
    name: "5. Los fenómenos naturales y el cambio climático",
    description: "Fenómenos naturales, efecto invernadero, calentamiento global y sus consecuencias socio-ambientales.",
    questionCount: 40,
    theoryByLevel: fenomenosCambioclimaticoTheory,
  ),
};
