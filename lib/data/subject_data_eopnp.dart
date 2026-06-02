import 'package:learn/models/question.dart';
import 'package:learn/models/topic.dart';
import 'package:learn/models/subject.dart';

final Subject eopnpSubject = Subject(
  id: 'eopnp',
  name: 'Aptitud EO PNP',
  color: '#FF6B6B',
  icon: '👮',
  topicIds: ['eopnp_t1'],
);

// -------------------------------------------------------------------------
// ARCHIVO GENERADO AUTOMÁTICAMENTE DESDE NOTEBOOKLM (Libreta: EO PNP 2026)
// -------------------------------------------------------------------------
// Este archivo es puramente pasivo. 
// Copia el contenido de `eopnpTopics` y `eopnpQuestions` a tus 
// archivos activos (ej. lib/data/subject_data_aptitud.dart) 
// cuando lo desees integrar a la app principal.

final Map<String, Topic> eopnpTopics = {
  'eopnp_t1': Topic(
    id: 'eopnp_t1',
    subjectId: 'aptitud',
    name: '1. Sintaxis del Español y Tabla Periódica',
    description: 'Resumen clave EO PNP: Análisis sintáctico y estructura periódica actual.',
    questionCount: 5,
    theoryByLevel: {
      1: '''¡Atención, futuro cadete! Soy tu profesor de élite y asesor estratégico para el proceso de admisión de la EO PNP. Nuestro único objetivo es que logres el primer puesto. Diagnóstico rápido: El prospecto oficial estructura el examen priorizando tus fuertes en Letras (donde debes asegurar el 100% de los puntos) y Ciencias/Aptitud Matemática (donde aplicaremos estrategia quirúrgica: solo los temas fijos y recurrentes). Empezaremos combinando un tema de tu mayor fortaleza y otro fundamental de ciencias: Sintaxis del Español y Química de la Tabla Periódica. Cero relleno, directo al examen.

**SINTAXIS DEL ESPAÑOL (Comunicación):**
La **oración** es la unidad mínima con sentido completo. Se divide en **unimembre** (no se divide en sujeto y predicado, ej: 'Hace frío') y **bimembre** (con Sujeto y Predicado).
- **Estructura del Sujeto:** Su núcleo (NS) es el sustantivo. Sus modificadores son el Modificador Directo (MD: artículos y adjetivos unidos sin nexos), el Modificador Indirecto (MI: se une al núcleo mediante un enlace o preposición) y la Aposición (explica o aclara el núcleo, va entre comas).
- **Estructura del Predicado:** Su núcleo (NP) es el verbo conjugado. Posee Objeto Directo (OD: recibe la acción directamente, se reemplaza por *lo, la, los, las*), Objeto Indirecto (OI: se beneficia o perjudica, se reemplaza por *le, les*) y Circunstanciales (lugar, tiempo, modo).

**TABLA PERIÓDICA (Química - Estrategia Directa):**
- **Ley Actual:** Mendeléiev la ordenó por masa atómica (con errores), pero Henry Moseley estableció la ley moderna ordenándola por el **número atómico (Z)** (cantidad de protones).
- **Estructura:** Se divide en 7 **Periodos** (filas horizontales que indican los niveles de energía del átomo) y 18 **Grupos o Familias** (columnas verticales; tienen propiedades químicas similares y la misma cantidad de electrones de valencia).
- **Familias Fijas:** Grupo IA (Metales Alcalinos: Li, Na, K), Grupo VIIA (Halógenos: flúor, cloro, muy reactivos) y Grupo VIIIA (Gases Nobles: Helio, Neón, Argón; estables porque tienen su octeto completo).
- **Trampa de Símbolos (Origen Latino):** Sodio (Na), Potasio (K), Hierro (Fe), Plata (Ag), Oro (Au).'''
    },
  ),
};

final List<Question> eopnpQuestions = [
  Question(
    id: "eopnp_q1",
    topicId: "eopnp_t1",
    text: "Según la estructura del sujeto en la oración, ¿qué elemento se caracteriza por unirse al núcleo mediante un enlace o preposición?",
    options: [
      "A) Modificador Directo (MD)",
      "B) Aposición",
      "C) Modificador Indirecto (MI)",
      "D) Objeto Directo (OD)"
    ],
    correctAnswer: 2,
    explanation: "El Modificador Indirecto (MI) se une al núcleo del sujeto utilizando un enlace, específicamente una preposición (por ejemplo: de, con, sin).",
  ),
  Question(
    id: "eopnp_q2",
    topicId: "eopnp_t1",
    text: "En el predicado, ¿por qué pronombres se puede reemplazar el Objeto Directo (OD) para reconocerlo rápidamente en el examen?",
    options: [
      "A) le, les",
      "B) lo, la, los, las",
      "C) me, te, se",
      "D) mi, tu, su"
    ],
    correctAnswer: 1,
    explanation: "El Objeto Directo (OD) recibe directamente la acción del verbo y se puede reemplazar por los pronombres lo, la, los, las. (Ej: Juan compró pan -> Juan lo compró).",
  ),
  Question(
    id: "eopnp_q3",
    topicId: "eopnp_t1",
    text: "¿Cuál fue el criterio definitivo descubierto por Henry Moseley que se utiliza para ordenar los elementos en la Tabla Periódica actual?",
    options: [
      "A) La masa atómica de los elementos.",
      "B) El número de neutrones en el núcleo.",
      "C) El peso atómico establecido por Mendeléiev.",
      "D) El número atómico (Z)."
    ],
    correctAnswer: 3,
    explanation: "Henry Moseley corrigió los errores de Mendeléiev demostrando que las propiedades de los elementos dependen de su número atómico (Z), es decir, su cantidad de protones.",
  ),
  Question(
    id: "eopnp_q4",
    topicId: "eopnp_t1",
    text: "La Tabla Periódica está estructurada en filas y columnas. ¿Qué indican exactamente los 7 Periodos (filas horizontales)?",
    options: [
      "A) Las familias con propiedades químicas similares.",
      "B) Los niveles de energía (capas) que tiene el átomo.",
      "C) La cantidad de electrones de valencia.",
      "D) Únicamente los metales de transición."
    ],
    correctAnswer: 1,
    explanation: "Los 7 periodos son las filas horizontales y determinan la cantidad de niveles de energía que posee el átomo de un elemento.",
  ),
  Question(
    id: "eopnp_q5",
    topicId: "eopnp_t1",
    text: "Una de las 'trampas' comunes en el examen de conocimientos de la PNP son los símbolos químicos de origen latino. ¿A qué elemento corresponde el símbolo 'K'?",
    options: [
      "A) Kriptón",
      "B) Fósforo",
      "C) Sodio",
      "D) Potasio"
    ],
    correctAnswer: 3,
    explanation: "El s\u00edmbolo 'K' proviene del lat\u00edn 'Kalium' y corresponde al elemento Potasio. Es vital no confundirlo con Kript\u00f3n (Kr) o F\u00f3sforo (P).",
  ),
  Question(
    id: "eopnp_q6",
    topicId: "eopnp_t1",
    text: "En el an\u00e1lisis de oraciones, \u00bfcu\u00e1l es la funci\u00f3n principal del Objeto Indirecto (OI) dentro del predicado?",
    options: [
      "A) Recibir la acci\u00f3n verbal directamente.",
      "B) Indicar las circunstancias de la acci\u00f3n.",
      "C) Se\u00f1alar a qui\u00e9n beneficia o perjudica la acci\u00f3n del verbo.",
      "D) Modificar al n\u00facleo del sujeto de forma adyacente."
    ],
    correctAnswer: 2,
    explanation: "El Objeto Indirecto se\u00f1ala al destinatario o la persona/entidad que se beneficia o perjudica por la acci\u00f3n verbal (reconocible por las preposiciones 'a' o 'para').",
  ),
  Question(
    id: "eopnp_q7",
    topicId: "eopnp_t1",
    text: "\u00bfCu\u00e1l de las siguientes oraciones presenta un Sujeto T\u00e1cito?",
    options: [
      "A) Los postulantes estudiaron toda la noche.",
      "B) Caminamos r\u00e1pidamente hacia la academia policial.",
      "C) El examen de aptitud fue bastante riguroso.",
      "D) Lima es la capital del Per\u00fa."
    ],
    correctAnswer: 1,
    explanation: "El sujeto t\u00e1cito es aquel que no est\u00e1 presente expl\u00edcitamente en la oraci\u00f3n pero se sobreentiende por la desinencia verbal. En 'Caminamos', el sujeto es 'Nosotros'.",
  ),
  Question(
    id: "eopnp_q8",
    topicId: "eopnp_t1",
    text: "En la oraci\u00f3n: 'El cadete diligente entreg\u00f3 su reporte al instructor', la palabra 'diligente' funciona como:",
    options: [
      "A) Modificador Indirecto",
      "B) N\u00facleo del sujeto",
      "C) Aposici\u00f3n",
      "D) Modificador Directo"
    ],
    correctAnswer: 3,
    explanation: "Es un Modificador Directo (MD) porque es un adjetivo que se une directamente al n\u00facleo del sujeto ('cadete') sin enlaces ni preposiciones.",
  ),
  Question(
    id: "eopnp_q9",
    topicId: "eopnp_t1",
    text: "Identifica el n\u00facleo del predicado en: 'La polic\u00eda captur\u00f3 al delincuente en la avenida principal.'",
    options: [
      "A) polic\u00eda",
      "B) captur\u00f3",
      "C) delincuente",
      "D) avenida"
    ],
    correctAnswer: 1,
    explanation: "El n\u00facleo del predicado es siempre el verbo principal conjugado de la oraci\u00f3n, en este caso 'captur\u00f3'.",
  ),
  Question(
    id: "eopnp_q10",
    topicId: "eopnp_t1",
    text: "\u00bfQu\u00e9 tipo de circunstancial se presenta en la oraci\u00f3n: 'Realizaremos las pr\u00e1cticas ma\u00f1ana'?",
    options: [
      "A) De modo",
      "B) De lugar",
      "C) De tiempo",
      "D) De cantidad"
    ],
    correctAnswer: 2,
    explanation: "La palabra 'ma\u00f1ana' responde a la pregunta '\u00bfCu\u00e1ndo?', por lo que funciona como un Circunstancial de Tiempo.",
  ),
];

