import 'package:learn/models/topic.dart';
import 'persona_familia_theory.dart';
import 'derechos_humanos_theory.dart';
import 'identidad_normas_theory.dart';
import 'autoestima_autocuidado_theory.dart';

final Map<String, Topic> pfrhTopics = {
  // Topics sin teoría (solo quiz) - comentados para ocultar del modo aprendizaje guiado
  // 'pfrh_t1': Topic(
  //   id: 'pfrh_t1',
  //   subjectId: 'pfrh',
  //   name: "1. Cultura de Paz y Gestion de Conflictos",
  //   description: "Dialogo, negociacion, mediacion, conciliacion, arbitraje, empatia y asertividad.",
  //   questionCount: 152,
  // ),
  // 'pfrh_t2': Topic(
  //   id: 'pfrh_t2',
  //   subjectId: 'pfrh',
  //   name: "2. Derechos Humanos",
  //   description: "Universalidad, indivisibilidad, inalienabilidad, imprescriptibilidad y dignidad humana.",
  //   questionCount: 152,
  // ),
  // 'pfrh_t3': Topic(
  //   id: 'pfrh_t3',
  //   subjectId: 'pfrh',
  //   name: "3. Identidad y Normas Sociales",
  //   description: "Identidad personal y nacional, simbolos patrios, normas morales, sociales y juridicas.",
  //   questionCount: 153,
  // ),
  // 'pfrh_t4': Topic(
  //   id: 'pfrh_t4',
  //   subjectId: 'pfrh',
  //   name: "4. Autoestima y Regulacion Emocional",
  //   description: "Autoconocimiento, autoconcepto, autoeficacia, autovaloracion e inteligencia emocional.",
  //   questionCount: 155,
  // ),
  // 'pfrh_t5': Topic(
  //   id: 'pfrh_t5',
  //   subjectId: 'pfrh',
  //   name: "5. Familia y sus Funciones",
  //   description: "Tipos de familia y funciones afectiva, socializadora, protectora, economica y educativa.",
  //   questionCount: 153,
  // ),
  // 'pfrh_t6': Topic(
  //   id: 'pfrh_t6',
  //   subjectId: 'pfrh',
  //   name: "6. Violencia Familiar",
  //   description: "Violencia fisica, psicologica, sexual, economica, patrimonial y medidas de proteccion.",
  //   questionCount: 150,
  // ),
  
  // Topics con teoría (modo aprendizaje guiado)
  'pfrh_persona_familia': Topic(
    id: 'pfrh_persona_familia',
    subjectId: 'pfrh',
    name: "1. Persona, Familia, Identidad y Convivencia Escolar",
    description: "Desarrollo humano, identidad personal y nacional, convivencia positiva, funciones familiares, mediación de conflictos y autocuidado.",
    questionCount: 40,
    theoryByLevel: personaFamiliaTheory,
  ),
  'pfrh_derechos_humanos': Topic(
    id: 'pfrh_derechos_humanos',
    subjectId: 'pfrh',
    name: "2. Derechos Humanos",
    description: "Garantías fundamentales, Declaración Universal de los Derechos Humanos, debido proceso, EDH, paz positiva y perspectivas críticas.",
    questionCount: 40,
    theoryByLevel: derechosHumanosTheory,
  ),
  'pfrh_identidad_normas': Topic(
    id: 'pfrh_identidad_normas',
    subjectId: 'pfrh',
    name: "3. Identidad Personal y Nacional. Normas Sociales.",
    description: "Identidad personal, identidad nacional, normas morales, sociales y jurídicas, diversidad cultural e interculturalidad.",
    questionCount: 40,
    theoryByLevel: identidadNormasTheory,
  ),
  'pfrh_autoestima_autocuidado': Topic(
    id: 'pfrh_autoestima_autocuidado',
    subjectId: 'pfrh',
    name: "4. Autoestima y Autocuidado",
    description: "Autoestima, autocuidado físico/emocional/mental/social, autorregulación, mindfulness, pilares de la autoestima y perspectiva de género.",
    questionCount: 40,
    theoryByLevel: autoestimaAutocuidadoTheory,
  ),
};
