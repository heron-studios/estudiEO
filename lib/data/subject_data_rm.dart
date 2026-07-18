import 'package:learn/models/question.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/models/topic.dart';

final Subject razonamientoMatematicoSubject = Subject(
  id: 'rm',
  name: 'Razonamiento Matemático',
  color: '#C1B5FE',
  icon: '🧮',
  topicIds: ['rm_sucesiones', 'rm_edades', 'rm_fracciones', 'rm_ecuaciones'],
);

final List<Question> razonamientoMatematicoQuestions = [
  Question(
    id: 'rm_q1',
    topicId: 'rm_sucesiones',
    text:
        '¿Cuál es el término que continúa en la siguiente sucesión: 7; 11; 15; 19; ...?',
    options: ['21', '23', '25', '27'],
    correctAnswer: 1,
    explanation:
        'La sucesión aumenta de 4 en 4 (progresión aritmética con razón r = 4). Por lo tanto, el siguiente término es 19 + 4 = 23.',
  ),
  Question(
    id: 'rm_q2',
    topicId: 'rm_sucesiones',
    text: 'Determine el número que sigue en la sucesión: 3; 6; 12; 24; 48; ...',
    options: ['60', '72', '96', '84'],
    correctAnswer: 2,
    explanation:
        'Se trata de una progresión geométrica donde cada término se multiplica por 2 (razón r = 2). El siguiente término es 48 × 2 = 96.',
  ),
  Question(
    id: 'rm_q3',
    topicId: 'rm_sucesiones',
    text:
        'Indique el término que continúa en la secuencia: 2; 5; 4; 10; 8; 20; 16; ...',
    options: ['32', '40', '24', '30'],
    correctAnswer: 1,
    explanation:
        'La sucesión está compuesta por dos secuencias intercaladas. La primera (posiciones impares): 2; 4; 8; 16; ... (se multiplica por 2). La segunda (posiciones pares): 5; 10; 20; ... (se multiplica por 2). El término buscado corresponde a la segunda secuencia: 20 × 2 = 40.',
  ),
  Question(
    id: 'rm_q4',
    topicId: 'rm_sucesiones',
    text:
        '¿Qué letra y número completan la siguiente serie: B; 4; D; 8; F; 16; H; ...?',
    options: ['J; 32', 'I; 24', 'J; 24', 'I; 32'],
    correctAnswer: 0,
    explanation:
        'Las letras avanzan dejando una letra de lado en el alfabeto: B (C) D (E) F (G) H (I) J. Los números se duplican en cada paso: 4, 8, 16, 32. Por ende, la combinación que continúa es J; 32.',
  ),
  Question(
    id: 'rm_q5',
    topicId: 'rm_sucesiones',
    text:
        'Halle el número que continúa en la siguiente sucesión: 15; 9; 3; -3; -9; ...',
    options: ['-15', '-12', '-18', '-21'],
    correctAnswer: 0,
    explanation:
        'Es una sucesión aritmética decreciente con una razón de -6. El siguiente término es -9 - 6 = -15.',
  ),
  Question(
    id: 'rm_q6',
    topicId: 'rm_sucesiones',
    text: '¿Qué número continúa en la secuencia: 3; 6; 4; 8; 6; 12; ...?',
    options: ['14', '10', '16', '8'],
    correctAnswer: 1,
    explanation:
        'El patrón alternado consiste en multiplicar por 2 y luego restar 2: 3 × 2 = 6; 6 - 2 = 4; 4 × 2 = 8; 8 - 2 = 6; 6 × 2 = 12. Por lo tanto, el término que continúa es 12 - 2 = 10.',
  ),
  Question(
    id: 'rm_q7',
    topicId: 'rm_sucesiones',
    text: '¿Qué letra continúa la serie: A; C; F; J; ...?',
    options: ['M', 'N', 'Ñ', 'O'],
    correctAnswer: 2,
    explanation:
        'Analizando la distancia entre letras en el alfabeto español: de A a C se salta 1 letra (B); de C a F se saltan 2 letras (D, E); de F a J se saltan 3 letras (G, H, I). Por lo tanto, de J al siguiente término se deben saltar 4 letras (K, L, M, N), resultando en la letra Ñ.',
  ),
  Question(
    id: 'rm_q8',
    topicId: 'rm_sucesiones',
    text: 'Indique el número que sigue en la serie: 1; 8; 27; 64; ...',
    options: ['100', '125', '81', '150'],
    correctAnswer: 1,
    explanation:
        'La secuencia corresponde a los cubos de los números enteros positivos consecutivos: 1³ = 1, 2³ = 8, 3³ = 27, 4³ = 64. El siguiente número es 5³ = 125.',
  ),
  Question(
    id: 'rm_q9',
    topicId: 'rm_sucesiones',
    text:
        'Determine el valor del término número 15 en la sucesión: 5; 8; 11; 14; 17; ...',
    options: ['44', '47', '50', '53'],
    correctAnswer: 1,
    explanation:
        'Es una sucesión aritmética con primer término t₁ = 5 y razón r = 3. La fórmula para el término n-ésimo es t_n = t₁ + (n - 1)r. Para n = 15: t₁₅ = 5 + (15 - 1) × 3 = 5 + 14 × 3 = 47.',
  ),
  Question(
    id: 'rm_q10',
    topicId: 'rm_sucesiones',
    text: '¿Cuál es el vigésimo término de la sucesión: 2; 7; 14; 23; 34; ...?',
    options: ['439', '421', '441', '419'],
    correctAnswer: 0,
    explanation:
        'Las diferencias de primer orden son 5, 7, 9, 11... y las diferencias de segundo orden son constantes e iguales a 2. La regla general es de la forma cuadrática t_n = n² + 2n - 1. Para n = 20: t₂₀ = 20² + 2(20) - 1 = 439.',
  ),
  Question(
    id: 'rm_q11',
    topicId: 'rm_sucesiones',
    text:
        'Indique los elementos que continúan en la serie: (A; 2), (D; 5), (H; 9), (M; 14), ...',
    options: ['(R; 20)', '(Q; 19)', '(R; 19)', '(S; 20)'],
    correctAnswer: 0,
    explanation:
        'Las letras avanzan dejando un número creciente de letras intermedias en el abecedario: A (B,C) D (E,F,G) H (I,J,K,L) M (N,Ñ,O,P,Q) R. Los números forman la secuencia 2, 5, 9, 14, donde las diferencias son +3, +4, +5, por lo que el siguiente término suma +6, resultando en 20.',
  ),
  Question(
    id: 'rm_q12',
    topicId: 'rm_sucesiones',
    text:
        'En la siguiente sucesión, halle el término que sigue: 1; 2; 4; 7; 13; 24; 44; ...',
    options: ['81', '88', '76', '92'],
    correctAnswer: 0,
    explanation:
        'Cada término a partir del cuarto es la suma de los tres términos anteriores (serie tipo Tribonacci). Así: 1 + 2 + 4 = 7; 2 + 4 + 7 = 13; 4 + 7 + 13 = 24; 7 + 13 + 24 = 44. El término que sigue es 13 + 24 + 44 = 81.',
  ),
  Question(
    id: 'rm_q13',
    topicId: 'rm_sucesiones',
    text:
        'Halle la suma de la serie infinita: S = 1/3 + 1/9 + 1/27 + 1/81 + ...',
    options: ['1/2', '2/3', '1/4', '3/4'],
    correctAnswer: 0,
    explanation:
        'Se trata de una serie geométrica decreciente infinita con primer término a = 1/3 y razón r = 1/3. La suma infinita es S = a / (1 - r) = (1/3) / (1 - 1/3) = 1/2.',
  ),
  Question(
    id: 'rm_q14',
    topicId: 'rm_sucesiones',
    text:
        'Halle el término que continúa en la sucesión: 100; 95; 88; 79; 68; ...',
    options: ['55', '57', '59', '61'],
    correctAnswer: 0,
    explanation:
        'Las diferencias sucesivas son números impares en orden decreciente: -5, -7, -9, -11. La siguiente diferencia debe ser -13, lo que nos da 68 - 13 = 55.',
  ),
  Question(
    id: 'rm_q15',
    topicId: 'rm_sucesiones',
    text:
        'Halle el par de elementos que continúa la secuencia: (C; 3), (F; 6), (I; 12), (L; 24), ...',
    options: ['(Ñ; 48)', '(O; 48)', '(N; 36)', '(Ñ; 36)'],
    correctAnswer: 0,
    explanation:
        'Las letras avanzan dejando dos letras intermedias: C (D,E) F (G,H) I (J,K) L (M,N) Ñ. Los números se duplican en cada paso: 3, 6, 12, 24, 48. Por lo tanto, el siguiente término es (Ñ; 48).',
  ),
  Question(
    id: 'rm_q16',
    topicId: 'rm_sucesiones',
    text:
        'Calcule el valor de la siguiente serie: S = 2 + 6 + 18 + 54 + ... + 1458.',
    options: ['2186', '2184', '2180', '1092'],
    correctAnswer: 0,
    explanation:
        'Es una progresión geométrica finita con primer término a = 2, razón r = 3 y último término t_n = 1458. La fórmula de la suma es S = (t_n * r - a) / (r - 1) = (1458 × 3 - 2) / 2 = 2186.',
  ),
  Question(
    id: 'rm_q17',
    topicId: 'rm_sucesiones',
    text: 'Determine el número que sigue en la secuencia: 2; 3; 7; 16; 32; ...',
    options: ['57', '48', '64', '53'],
    correctAnswer: 0,
    explanation:
        'Las diferencias entre términos consecutivos corresponden a los cuadrados de los números enteros consecutivos: 1² = 1, 2² = 4, 3² = 9, 4² = 16. La siguiente diferencia es 5² = 25, por lo que el siguiente término es 32 + 25 = 57.',
  ),
  Question(
    id: 'rm_q18',
    topicId: 'rm_sucesiones',
    text:
        'Encuentre el término que continúa en la secuencia: 1; 3; 8; 20; 43; 81; ...',
    options: ['132', '138', '141', '153'],
    correctAnswer: 1,
    explanation:
        'Analizando las diferencias sucesivas: 1er nivel: 2, 5, 12, 23, 38. 2do nivel: 3, 7, 11, 15 (razón +4). 3er nivel: 4, 4, 4 (razón constante). El siguiente término de la diferencia de 2do nivel es 15 + 4 = 19. El de 1er nivel es 38 + 19 = 57. El término que continúa la secuencia original es 81 + 57 = 138.',
  ),
  Question(
    id: 'rm_q19',
    topicId: 'rm_sucesiones',
    text: '¿Qué número continúa la secuencia: 2; 3; 10; 39; 172; ...?',
    options: ['885', '688', '865', '724'],
    correctAnswer: 0,
    explanation:
        'El patrón de formación es t_{n+1} = t_n × n + n². Así: t₂ = 2×1 + 1² = 3; t₃ = 3×2 + 2² = 10; t₄ = 10×3 + 3² = 39; t₅ = 39×4 + 4² = 172. Por lo tanto, t₆ = 172×5 + 5² = 860 + 25 = 885.',
  ),
  Question(
    id: 'rm_q20',
    topicId: 'rm_sucesiones',
    text:
        'Halle el número que continúa en la secuencia: 2; 2; 4; 12; 48; 240; ...',
    options: ['1440', '1200', '1080', '1680'],
    correctAnswer: 0,
    explanation:
        'Cada término se multiplica por un número entero creciente consecutivo: t₂ = t₁ × 1, t₃ = t₂ × 2, t₄ = t₃ × 3, t₅ = t₄ × 4, t₆ = t₅ × 5. El siguiente término es 240 × 6 = 1440.',
  ),
  Question(
    id: 'rm_q21',
    topicId: 'rm_sucesiones',
    text: 'Halle el número que sigue en la secuencia: 4; 9; 20; 43; 90; ...',
    options: ['185', '181', '187', '179'],
    correctAnswer: 0,
    explanation:
        'La ley de formación es t_{n+1} = 2 × t_n + n. Así, t₂ = 2×4 + 1 = 9; t₃ = 2×9 + 2 = 20; t₄ = 2×20 + 3 = 43; t₅ = 2×43 + 4 = 90. Por lo tanto, el siguiente número es t₆ = 2×90 + 5 = 185.',
  ),
  Question(
    id: 'rm_q22',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 6, 9, 12, 15, ...?',
    options: ['18', '19', '21', '17'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q23',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 10, 12, 14, 16, ...?',
    options: ['18', '19', '20', '17'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q24',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 4, 9, 14, 19, ...?',
    options: ['24', '25', '29', '23'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q25',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 12, 15, 18, ...?',
    options: ['21', '22', '24', '20'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q26',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 6, 8, 10, 12, ...?',
    options: ['14', '15', '16', '13'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q27',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 7, 9, 11, 13, ...?',
    options: ['15', '16', '17', '14'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q28',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 11, 13, 15, ...?',
    options: ['17', '18', '19', '16'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q29',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 12, 15, 18, ...?',
    options: ['21', '22', '24', '20'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q30',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 7, 11, 15, 19, ...?',
    options: ['23', '24', '27', '22'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q31',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 11, 13, 15, ...?',
    options: ['17', '18', '19', '16'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q32',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 1, 4, 7, 10, ...?',
    options: ['13', '14', '16', '12'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q33',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 7, 11, 15, 19, ...?',
    options: ['23', '24', '27', '22'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q34',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 13, 17, 21, ...?',
    options: ['25', '26', '29', '24'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q35',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 2, 5, 8, 11, ...?',
    options: ['14', '15', '17', '13'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q36',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 8, 13, 18, 23, ...?',
    options: ['28', '29', '33', '27'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q37',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 14, 19, 24, ...?',
    options: ['29', '30', '34', '28'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q38',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 13, 17, 21, ...?',
    options: ['25', '26', '29', '24'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q39',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 8, 14, 20, 26, ...?',
    options: ['32', '33', '38', '31'],
    correctAnswer: 0,
    explanation: 'La razón es +6.',
  ),
  Question(
    id: 'rm_q40',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 1, 6, 11, 16, ...?',
    options: ['21', '22', '26', '20'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q41',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 4, 10, 16, 22, ...?',
    options: ['28', '29', '34', '27'],
    correctAnswer: 0,
    explanation: 'La razón es +6.',
  ),
  Question(
    id: 'rm_q42',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 2, 5, 8, 11, ...?',
    options: ['14', '15', '17', '13'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q43',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 2, 5, 8, 11, ...?',
    options: ['14', '15', '17', '13'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q44',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 3, 8, 13, 18, ...?',
    options: ['23', '24', '28', '22'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q45',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 5, 10, 15, 20, ...?',
    options: ['25', '26', '30', '24'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q46',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 6, 12, 18, 24, ...?',
    options: ['30', '31', '36', '29'],
    correctAnswer: 0,
    explanation: 'La razón es +6.',
  ),
  Question(
    id: 'rm_q47',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 5, 10, 15, 20, ...?',
    options: ['25', '26', '30', '24'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q48',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 1, 3, 5, 7, ...?',
    options: ['9', '10', '11', '8'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q49',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 3, 7, 11, 15, ...?',
    options: ['19', '20', '23', '18'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q50',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 5, 11, 17, 23, ...?',
    options: ['29', '30', '35', '28'],
    correctAnswer: 0,
    explanation: 'La razón es +6.',
  ),
  Question(
    id: 'rm_q51',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 1, 6, 11, 16, ...?',
    options: ['21', '22', '26', '20'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q52',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 7, 9, 11, 13, ...?',
    options: ['15', '16', '17', '14'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q53',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 3, 6, 9, 12, ...?',
    options: ['15', '16', '18', '14'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q54',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 10, 14, 18, 22, ...?',
    options: ['26', '27', '30', '25'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q55',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 10, 14, 18, 22, ...?',
    options: ['26', '27', '30', '25'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q56',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 1, 7, 13, 19, ...?',
    options: ['25', '26', '31', '24'],
    correctAnswer: 0,
    explanation: 'La razón es +6.',
  ),
  Question(
    id: 'rm_q57',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 4, 9, 14, 19, ...?',
    options: ['24', '25', '29', '23'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q58',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 2, 6, 10, 14, ...?',
    options: ['18', '19', '22', '17'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q59',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 5, 10, 15, 20, ...?',
    options: ['25', '26', '30', '24'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q60',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 2, 7, 12, 17, ...?',
    options: ['22', '23', '27', '21'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q61',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 5, 11, 17, 23, ...?',
    options: ['29', '30', '35', '28'],
    correctAnswer: 0,
    explanation: 'La razón es +6.',
  ),
  Question(
    id: 'rm_q62',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 6, 12, 18, 24, ...?',
    options: ['30', '31', '36', '29'],
    correctAnswer: 0,
    explanation: 'La razón es +6.',
  ),
  Question(
    id: 'rm_q63',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 6, 10, 14, 18, ...?',
    options: ['22', '23', '26', '21'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q64',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 13, 17, 21, ...?',
    options: ['25', '26', '29', '24'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q65',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 3, 6, 9, 12, ...?',
    options: ['15', '16', '18', '14'],
    correctAnswer: 0,
    explanation: 'La razón es +3.',
  ),
  Question(
    id: 'rm_q66',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 2, 7, 12, 17, ...?',
    options: ['22', '23', '27', '21'],
    correctAnswer: 0,
    explanation: 'La razón es +5.',
  ),
  Question(
    id: 'rm_q67',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 6, 8, 10, 12, ...?',
    options: ['14', '15', '16', '13'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q68',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 11, 13, 15, ...?',
    options: ['17', '18', '19', '16'],
    correctAnswer: 0,
    explanation: 'La razón es +2.',
  ),
  Question(
    id: 'rm_q69',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 10, 14, 18, 22, ...?',
    options: ['26', '27', '30', '25'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q70',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 6, 10, 14, 18, ...?',
    options: ['22', '23', '26', '21'],
    correctAnswer: 0,
    explanation: 'La razón es +4.',
  ),
  Question(
    id: 'rm_q71',
    topicId: 'rm_sucesiones',
    text: 'FIJA RM: ¿Qué número sigue en la sucesión: 9, 15, 21, 27, ...?',
    options: ['33', '34', '39', '32'],
    correctAnswer: 0,
    explanation: 'La razón es +6.',
  ),
  Question(
    id: 'rm_q72',
    topicId: 'rm_edades',
    text:
        'Si al doble de la edad que tendré dentro de 5 años le resto el doble de la edad que tenía hace 5 años, obtengo mi edad actual. ¿Qué edad tengo?',
    options: ['20 años', '15 años', '25 años', '30 años'],
    correctAnswer: 0,
    explanation:
        'Sea x la edad actual. Planteando la ecuación: 2(x + 5) - 2(x - 5) = x. Al resolver: 2x + 10 - 2x + 10 = x, por lo tanto x = 20 años.',
  ),
  Question(
    id: 'rm_q73',
    topicId: 'rm_edades',
    text:
        'Se reparte una herencia de 120 000 soles entre tres hermanos de modo que el mayor recibe el doble del segundo, y el segundo recibe el triple del menor. ¿Cuánto recibe el menor?',
    options: ['12 000 soles', '15 000 soles', '10 000 soles', '18 000 soles'],
    correctAnswer: 0,
    explanation:
        'Sea x lo que recibe el menor. El segundo recibe 3x y el mayor recibe 2(3x) = 6x. La suma total es x + 3x + 6x = 120 000 => 10x = 120 000 => x = 12 000 soles.',
  ),
  Question(
    id: 'rm_q74',
    topicId: 'rm_edades',
    text:
        'La diferencia de las edades de dos hermanos es de 6 años. Si hace 4 años la suma de sus edades era de 24 años, ¿cuál es la edad actual del hermano mayor?',
    options: ['19 años', '16 años', '15 años', '20 años'],
    correctAnswer: 0,
    explanation:
        'Sean x e y sus edades actuales, con x > y. Su diferencia es constante: x - y = 6. Hace 4 años: (x - 4) + (y - 4) = 24 => x + y = 32. Sumando ambas ecuaciones: 2x = 38 => x = 19 años.',
  ),
  Question(
    id: 'rm_q75',
    topicId: 'rm_edades',
    text:
        'Se sabe que Lucía es mayor que María, pero menor que Julia. Además, Sofía es mayor que Lucía, pero menor que Julia. Si todas tienen edades diferentes, ¿quién es la segunda de menor edad en el grupo?',
    options: ['Lucía', 'María', 'Sofía', 'Julia'],
    correctAnswer: 0,
    explanation:
        'Lucía es mayor que María (Lucía > María). Lucía es menor que Julia (Julia > Lucía). Sofía es mayor que Lucía pero menor que Julia (Julia > Sofía > Lucía). Combinando todo, el orden de menor a mayor es: María < Lucía < Sofía < Julia. Por ende, la segunda de menor edad es Lucía.',
  ),
  Question(
    id: 'rm_q76',
    topicId: 'rm_edades',
    text:
        "Tres amigas (Ana, Beatriz y Carla) conversan sobre sus edades. Se sabe que aquellas que son mayores de edad dicen siempre la verdad, mientras que las menores de edad siempre mienten. Sus afirmaciones son: Ana: 'Beatriz es menor de edad'; Beatriz: 'Carla es menor de edad'; Carla: 'Ana es mayor de edad'. Si se sabe que exactamente una de las tres es menor de edad, ¿quiénes son mayores de edad?",
    options: [
      'Solo Carla',
      'Ana y Beatriz',
      'Ana y Carla',
      'Las tres son mayores de edad',
    ],
    correctAnswer: 2,
    explanation:
        "Si Beatriz es la única menor de edad (y por ende la única que miente): la declaración de Ana ('Beatriz es menor') es verdadera (consistente con Ana siendo mayor); la declaración de Beatriz ('Carla es menor') es falsa (consistente con Beatriz mintiendo); la declaración de Carla ('Ana es mayor') es verdadera (consistente con Carla siendo mayor). No hay contradicciones. Ana y Carla son las mayores.",
  ),
  Question(
    id: 'rm_q77',
    topicId: 'rm_edades',
    text:
        'En una reunión familiar se encuentran 2 padres, 2 hijos, 1 abuelo, 1 nieto, 1 suegro, 1 yerno y 2 hermanos. ¿Cuál es el menor número de personas que integran esta reunión?',
    options: ['3 personas', '4 personas', '5 personas', '6 personas'],
    correctAnswer: 1,
    explanation:
        'El número mínimo es 4 personas con la siguiente configuración: un abuelo, su yerno (casado con su hija ausente) y dos hermanos (hijos del yerno y nietos del abuelo). Esto cubre perfectamente todos los roles requeridos con el menor número de personas.',
  ),
  Question(
    id: 'rm_q78',
    topicId: 'rm_edades',
    text:
        'En una reunión de amigos, al despedirse, todos se saludaron con un apretón de manos. Si se contaron en total 28 apretones de manos, ¿cuántos amigos había en la reunión?',
    options: ['8', '7', '9', '10'],
    correctAnswer: 0,
    explanation:
        'Si hay n amigos, el número de apretones de manos está dado por las combinaciones de n personas elegidas de dos en dos: C(n, 2) = n(n-1)/2 = 28 => n(n-1) = 56. Dado que 8 × 7 = 56, concluimos que había 8 amigos.',
  ),
  Question(
    id: 'rm_q79',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 9 años tenía 9 años. ¿Qué edad tendré dentro de 7 años?',
    options: ['25', '18', '27', '16'],
    correctAnswer: 0,
    explanation: 'Edad actual = 9 + 9 = 18. En 7 años = 25.',
  ),
  Question(
    id: 'rm_q80',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 9 años tenía 14 años. ¿Qué edad tendré dentro de 3 años?',
    options: ['26', '23', '28', '17'],
    correctAnswer: 0,
    explanation: 'Edad actual = 14 + 9 = 23. En 3 años = 26.',
  ),
  Question(
    id: 'rm_q81',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 30 años. ¿Qué edad tendré dentro de 3 años?',
    options: ['36', '33', '38', '33'],
    correctAnswer: 0,
    explanation: 'Edad actual = 30 + 3 = 33. En 3 años = 36.',
  ),
  Question(
    id: 'rm_q82',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 4 años tenía 12 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['24', '16', '26', '20'],
    correctAnswer: 0,
    explanation: 'Edad actual = 12 + 4 = 16. En 8 años = 24.',
  ),
  Question(
    id: 'rm_q83',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 30 años. ¿Qué edad tendré dentro de 4 años?',
    options: ['37', '33', '39', '34'],
    correctAnswer: 0,
    explanation: 'Edad actual = 30 + 3 = 33. En 4 años = 37.',
  ),
  Question(
    id: 'rm_q84',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 5 años tenía 15 años. ¿Qué edad tendré dentro de 10 años?',
    options: ['30', '20', '32', '25'],
    correctAnswer: 0,
    explanation: 'Edad actual = 15 + 5 = 20. En 10 años = 30.',
  ),
  Question(
    id: 'rm_q85',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 30 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['45', '37', '47', '38'],
    correctAnswer: 0,
    explanation: 'Edad actual = 30 + 7 = 37. En 8 años = 45.',
  ),
  Question(
    id: 'rm_q86',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 37 años. ¿Qué edad tendré dentro de 4 años?',
    options: ['44', '40', '46', '41'],
    correctAnswer: 0,
    explanation: 'Edad actual = 37 + 3 = 40. En 4 años = 44.',
  ),
  Question(
    id: 'rm_q87',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 22 años. ¿Qué edad tendré dentro de 9 años?',
    options: ['38', '29', '40', '31'],
    correctAnswer: 0,
    explanation: 'Edad actual = 22 + 7 = 29. En 9 años = 38.',
  ),
  Question(
    id: 'rm_q88',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 4 años tenía 36 años. ¿Qué edad tendré dentro de 7 años?',
    options: ['47', '40', '49', '43'],
    correctAnswer: 0,
    explanation: 'Edad actual = 36 + 4 = 40. En 7 años = 47.',
  ),
  Question(
    id: 'rm_q89',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 33 años. ¿Qué edad tendré dentro de 4 años?',
    options: ['40', '36', '42', '37'],
    correctAnswer: 0,
    explanation: 'Edad actual = 33 + 3 = 36. En 4 años = 40.',
  ),
  Question(
    id: 'rm_q90',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 25 años. ¿Qué edad tendré dentro de 3 años?',
    options: ['36', '33', '38', '28'],
    correctAnswer: 0,
    explanation: 'Edad actual = 25 + 8 = 33. En 3 años = 36.',
  ),
  Question(
    id: 'rm_q91',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 5 años tenía 34 años. ¿Qué edad tendré dentro de 9 años?',
    options: ['48', '39', '50', '43'],
    correctAnswer: 0,
    explanation: 'Edad actual = 34 + 5 = 39. En 9 años = 48.',
  ),
  Question(
    id: 'rm_q92',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 9 años. ¿Qué edad tendré dentro de 6 años?',
    options: ['23', '17', '25', '15'],
    correctAnswer: 0,
    explanation: 'Edad actual = 9 + 8 = 17. En 6 años = 23.',
  ),
  Question(
    id: 'rm_q93',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 24 años. ¿Qué edad tendré dentro de 6 años?',
    options: ['37', '31', '39', '30'],
    correctAnswer: 0,
    explanation: 'Edad actual = 24 + 7 = 31. En 6 años = 37.',
  ),
  Question(
    id: 'rm_q94',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 23 años. ¿Qué edad tendré dentro de 5 años?',
    options: ['36', '31', '38', '28'],
    correctAnswer: 0,
    explanation: 'Edad actual = 23 + 8 = 31. En 5 años = 36.',
  ),
  Question(
    id: 'rm_q95',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 22 años. ¿Qué edad tendré dentro de 5 años?',
    options: ['35', '30', '37', '27'],
    correctAnswer: 0,
    explanation: 'Edad actual = 22 + 8 = 30. En 5 años = 35.',
  ),
  Question(
    id: 'rm_q96',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 23 años. ¿Qué edad tendré dentro de 3 años?',
    options: ['33', '30', '35', '26'],
    correctAnswer: 0,
    explanation: 'Edad actual = 23 + 7 = 30. En 3 años = 33.',
  ),
  Question(
    id: 'rm_q97',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 28 años. ¿Qué edad tendré dentro de 4 años?',
    options: ['40', '36', '42', '32'],
    correctAnswer: 0,
    explanation: 'Edad actual = 28 + 8 = 36. En 4 años = 40.',
  ),
  Question(
    id: 'rm_q98',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 15 años. ¿Qué edad tendré dentro de 7 años?',
    options: ['29', '22', '31', '22'],
    correctAnswer: 0,
    explanation: 'Edad actual = 15 + 7 = 22. En 7 años = 29.',
  ),
  Question(
    id: 'rm_q99',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 16 años. ¿Qué edad tendré dentro de 4 años?',
    options: ['28', '24', '30', '20'],
    correctAnswer: 0,
    explanation: 'Edad actual = 16 + 8 = 24. En 4 años = 28.',
  ),
  Question(
    id: 'rm_q100',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 17 años. ¿Qué edad tendré dentro de 3 años?',
    options: ['23', '20', '25', '20'],
    correctAnswer: 0,
    explanation: 'Edad actual = 17 + 3 = 20. En 3 años = 23.',
  ),
  Question(
    id: 'rm_q101',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 27 años. ¿Qué edad tendré dentro de 10 años?',
    options: ['45', '35', '47', '37'],
    correctAnswer: 0,
    explanation: 'Edad actual = 27 + 8 = 35. En 10 años = 45.',
  ),
  Question(
    id: 'rm_q102',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 24 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['39', '31', '41', '32'],
    correctAnswer: 0,
    explanation: 'Edad actual = 24 + 7 = 31. En 8 años = 39.',
  ),
  Question(
    id: 'rm_q103',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 8 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['23', '15', '25', '16'],
    correctAnswer: 0,
    explanation: 'Edad actual = 8 + 7 = 15. En 8 años = 23.',
  ),
  Question(
    id: 'rm_q104',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 14 años. ¿Qué edad tendré dentro de 9 años?',
    options: ['26', '17', '28', '23'],
    correctAnswer: 0,
    explanation: 'Edad actual = 14 + 3 = 17. En 9 años = 26.',
  ),
  Question(
    id: 'rm_q105',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 10 años tenía 7 años. ¿Qué edad tendré dentro de 5 años?',
    options: ['22', '17', '24', '12'],
    correctAnswer: 0,
    explanation: 'Edad actual = 7 + 10 = 17. En 5 años = 22.',
  ),
  Question(
    id: 'rm_q106',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 9 años tenía 25 años. ¿Qué edad tendré dentro de 7 años?',
    options: ['41', '34', '43', '32'],
    correctAnswer: 0,
    explanation: 'Edad actual = 25 + 9 = 34. En 7 años = 41.',
  ),
  Question(
    id: 'rm_q107',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 10 años tenía 14 años. ¿Qué edad tendré dentro de 7 años?',
    options: ['31', '24', '33', '21'],
    correctAnswer: 0,
    explanation: 'Edad actual = 14 + 10 = 24. En 7 años = 31.',
  ),
  Question(
    id: 'rm_q108',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 10 años tenía 24 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['42', '34', '44', '32'],
    correctAnswer: 0,
    explanation: 'Edad actual = 24 + 10 = 34. En 8 años = 42.',
  ),
  Question(
    id: 'rm_q109',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 6 años tenía 11 años. ¿Qué edad tendré dentro de 3 años?',
    options: ['20', '17', '22', '14'],
    correctAnswer: 0,
    explanation: 'Edad actual = 11 + 6 = 17. En 3 años = 20.',
  ),
  Question(
    id: 'rm_q110',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 4 años tenía 14 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['26', '18', '28', '22'],
    correctAnswer: 0,
    explanation: 'Edad actual = 14 + 4 = 18. En 8 años = 26.',
  ),
  Question(
    id: 'rm_q111',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 14 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['25', '17', '27', '22'],
    correctAnswer: 0,
    explanation: 'Edad actual = 14 + 3 = 17. En 8 años = 25.',
  ),
  Question(
    id: 'rm_q112',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 4 años tenía 23 años. ¿Qué edad tendré dentro de 6 años?',
    options: ['33', '27', '35', '29'],
    correctAnswer: 0,
    explanation: 'Edad actual = 23 + 4 = 27. En 6 años = 33.',
  ),
  Question(
    id: 'rm_q113',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 6 años tenía 11 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['25', '17', '27', '19'],
    correctAnswer: 0,
    explanation: 'Edad actual = 11 + 6 = 17. En 8 años = 25.',
  ),
  Question(
    id: 'rm_q114',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 11 años. ¿Qué edad tendré dentro de 4 años?',
    options: ['23', '19', '25', '15'],
    correctAnswer: 0,
    explanation: 'Edad actual = 11 + 8 = 19. En 4 años = 23.',
  ),
  Question(
    id: 'rm_q115',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 21 años. ¿Qué edad tendré dentro de 7 años?',
    options: ['31', '24', '33', '28'],
    correctAnswer: 0,
    explanation: 'Edad actual = 21 + 3 = 24. En 7 años = 31.',
  ),
  Question(
    id: 'rm_q116',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 5 años tenía 12 años. ¿Qué edad tendré dentro de 10 años?',
    options: ['27', '17', '29', '22'],
    correctAnswer: 0,
    explanation: 'Edad actual = 12 + 5 = 17. En 10 años = 27.',
  ),
  Question(
    id: 'rm_q117',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 5 años tenía 18 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['31', '23', '33', '26'],
    correctAnswer: 0,
    explanation: 'Edad actual = 18 + 5 = 23. En 8 años = 31.',
  ),
  Question(
    id: 'rm_q118',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 9 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['24', '16', '26', '17'],
    correctAnswer: 0,
    explanation: 'Edad actual = 9 + 7 = 16. En 8 años = 24.',
  ),
  Question(
    id: 'rm_q119',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 9 años tenía 27 años. ¿Qué edad tendré dentro de 7 años?',
    options: ['43', '36', '45', '34'],
    correctAnswer: 0,
    explanation: 'Edad actual = 27 + 9 = 36. En 7 años = 43.',
  ),
  Question(
    id: 'rm_q120',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 4 años tenía 31 años. ¿Qué edad tendré dentro de 10 años?',
    options: ['45', '35', '47', '41'],
    correctAnswer: 0,
    explanation: 'Edad actual = 31 + 4 = 35. En 10 años = 45.',
  ),
  Question(
    id: 'rm_q121',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 6 años tenía 11 años. ¿Qué edad tendré dentro de 8 años?',
    options: ['25', '17', '27', '19'],
    correctAnswer: 0,
    explanation: 'Edad actual = 11 + 6 = 17. En 8 años = 25.',
  ),
  Question(
    id: 'rm_q122',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 37 años. ¿Qué edad tendré dentro de 5 años?',
    options: ['45', '40', '47', '42'],
    correctAnswer: 0,
    explanation: 'Edad actual = 37 + 3 = 40. En 5 años = 45.',
  ),
  Question(
    id: 'rm_q123',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 4 años tenía 35 años. ¿Qué edad tendré dentro de 6 años?',
    options: ['45', '39', '47', '41'],
    correctAnswer: 0,
    explanation: 'Edad actual = 35 + 4 = 39. En 6 años = 45.',
  ),
  Question(
    id: 'rm_q124',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 10 años tenía 15 años. ¿Qué edad tendré dentro de 10 años?',
    options: ['35', '25', '37', '25'],
    correctAnswer: 0,
    explanation: 'Edad actual = 15 + 10 = 25. En 10 años = 35.',
  ),
  Question(
    id: 'rm_q125',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 3 años tenía 23 años. ¿Qué edad tendré dentro de 7 años?',
    options: ['33', '26', '35', '30'],
    correctAnswer: 0,
    explanation: 'Edad actual = 23 + 3 = 26. En 7 años = 33.',
  ),
  Question(
    id: 'rm_q126',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 4 años tenía 11 años. ¿Qué edad tendré dentro de 9 años?',
    options: ['24', '15', '26', '20'],
    correctAnswer: 0,
    explanation: 'Edad actual = 11 + 4 = 15. En 9 años = 24.',
  ),
  Question(
    id: 'rm_q127',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 8 años tenía 31 años. ¿Qué edad tendré dentro de 9 años?',
    options: ['48', '39', '50', '40'],
    correctAnswer: 0,
    explanation: 'Edad actual = 31 + 8 = 39. En 9 años = 48.',
  ),
  Question(
    id: 'rm_q128',
    topicId: 'rm_edades',
    text:
        'FIJA EDADES: Hace 7 años tenía 16 años. ¿Qué edad tendré dentro de 5 años?',
    options: ['28', '23', '30', '21'],
    correctAnswer: 0,
    explanation: 'Edad actual = 16 + 7 = 23. En 5 años = 28.',
  ),
  Question(
    id: 'rm_q129',
    topicId: 'rm_fracciones',
    text:
        'Se mezclan 20 litros de alcohol al 80% con 30 litros de alcohol al 60%. ¿Cuál es el grado de pureza alcohólica de la mezcla resultante?',
    options: ['68%', '70%', '66%', '72%'],
    correctAnswer: 0,
    explanation:
        'La cantidad total de alcohol puro es 20 × 0.80 + 30 × 0.60 = 16 + 18 = 34 litros. El volumen total es 20 + 30 = 50 litros. El grado de pureza es (34 / 50) × 100% = 68%.',
  ),
  Question(
    id: 'rm_q130',
    topicId: 'rm_fracciones',
    text:
        'Un farmacéutico tiene una solución salina al 10% y otra al 25%. ¿Cuántos litros de la solución al 25% debe mezclar con la de 10% para obtener 30 litros de una solución al 15%?',
    options: ['10 litros', '20 litros', '15 litros', '12 litros'],
    correctAnswer: 0,
    explanation:
        'Sea x el volumen de solución al 25%. Planteando: 0.25x + 0.10(30 - x) = 0.15(30) => 0.15x + 3 = 4.5 => 0.15x = 1.5 => x = 10 litros.',
  ),
  Question(
    id: 'rm_q131',
    topicId: 'rm_fracciones',
    text:
        'Un televisor se vende inicialmente con un recargo del 20%. Luego, debido a una promoción, se ofrece un descuento del 20% sobre el precio de venta recargado. Si al final se vendió a 960 soles, ¿cuál era el precio original del televisor?',
    options: ['1000 soles', '1200 soles', '960 soles', '1100 soles'],
    correctAnswer: 0,
    explanation:
        'Sea P el precio original. Con el 20% de recargo es 1.20P. Tras el 20% de descuento, el precio final es 0.80 × 1.20P = 0.96P. De 0.96P = 960 se obtiene P = 1000 soles.',
  ),
  Question(
    id: 'rm_q132',
    topicId: 'rm_fracciones',
    text:
        'Se tienen dos recipientes A y B. El recipiente A contiene 40 litros de vino y el B contiene 40 litros de agua. Se extraen 10 litros de vino de A y se vierten en B. Luego de mezclar uniformemente, se extraen 10 litros de la mezcla de B y se vierten en A. ¿Qué fracción del volumen total de A es vino puro al finalizar?',
    options: ['4/5', '3/4', '7/8', '9/10'],
    correctAnswer: 0,
    explanation:
        'Tras pasar 10L de vino a B, B tiene 10L vino y 40L agua (50L totales, proporción 1/5 vino). Al devolver 10L de esta mezcla a A, se regresan 10 × 1/5 = 2L de vino y 8L de agua. A queda con 30 + 2 = 32L de vino de un total de 40L. La fracción es 32/40 = 4/5.',
  ),
  Question(
    id: 'rm_q133',
    topicId: 'rm_fracciones',
    text:
        'En una oficina, el 60% de los empleados son mujeres. El 30% de las mujeres y el 20% de los varones hablan inglés. Si se elige un empleado al azar y habla inglés, ¿cuál es la probabilidad de que sea mujer?',
    options: ['9/13', '3/5', '2/3', '18/26'],
    correctAnswer: 0,
    explanation:
        'Usando el Teorema de Bayes: asumiendo 100 empleados en total, hay 60 mujeres (de las cuales 18 hablan inglés) y 40 varones (de los cuales 8 hablan inglés). El total de personas que hablan inglés es 18 + 8 = 26. La probabilidad de ser mujer dado que habla inglés es 18/26 = 9/13.',
  ),
  Question(
    id: 'rm_q134',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 75% de 150.',
    options: ['112', '122', '168', '107'],
    correctAnswer: 0,
    explanation: '75/100 * 150 = 112.',
  ),
  Question(
    id: 'rm_q135',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 75% de 80.',
    options: ['60', '70', '90', '55'],
    correctAnswer: 0,
    explanation: '75/100 * 80 = 60.',
  ),
  Question(
    id: 'rm_q136',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 10% de 120.',
    options: ['12', '22', '18', '7'],
    correctAnswer: 0,
    explanation: '10/100 * 120 = 12.',
  ),
  Question(
    id: 'rm_q137',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 20% de 100.',
    options: ['20', '30', '30', '15'],
    correctAnswer: 0,
    explanation: '20/100 * 100 = 20.',
  ),
  Question(
    id: 'rm_q138',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 10% de 100.',
    options: ['10', '20', '15', '5'],
    correctAnswer: 0,
    explanation: '10/100 * 100 = 10.',
  ),
  Question(
    id: 'rm_q139',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 60% de 500.',
    options: ['300', '310', '450', '295'],
    correctAnswer: 0,
    explanation: '60/100 * 500 = 300.',
  ),
  Question(
    id: 'rm_q140',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 25% de 300.',
    options: ['75', '85', '112', '70'],
    correctAnswer: 0,
    explanation: '25/100 * 300 = 75.',
  ),
  Question(
    id: 'rm_q141',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 60% de 200.',
    options: ['120', '130', '180', '115'],
    correctAnswer: 0,
    explanation: '60/100 * 200 = 120.',
  ),
  Question(
    id: 'rm_q142',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 50% de 150.',
    options: ['75', '85', '112', '70'],
    correctAnswer: 0,
    explanation: '50/100 * 150 = 75.',
  ),
  Question(
    id: 'rm_q143',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 40% de 200.',
    options: ['80', '90', '120', '75'],
    correctAnswer: 0,
    explanation: '40/100 * 200 = 80.',
  ),
  Question(
    id: 'rm_q144',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 60% de 300.',
    options: ['180', '190', '270', '175'],
    correctAnswer: 0,
    explanation: '60/100 * 300 = 180.',
  ),
  Question(
    id: 'rm_q145',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 80% de 300.',
    options: ['240', '250', '360', '235'],
    correctAnswer: 0,
    explanation: '80/100 * 300 = 240.',
  ),
  Question(
    id: 'rm_q146',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 25% de 100.',
    options: ['25', '35', '37', '20'],
    correctAnswer: 0,
    explanation: '25/100 * 100 = 25.',
  ),
  Question(
    id: 'rm_q147',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 60% de 80.',
    options: ['48', '58', '72', '43'],
    correctAnswer: 0,
    explanation: '60/100 * 80 = 48.',
  ),
  Question(
    id: 'rm_q148',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 50% de 150.',
    options: ['75', '85', '112', '70'],
    correctAnswer: 0,
    explanation: '50/100 * 150 = 75.',
  ),
  Question(
    id: 'rm_q149',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 40% de 150.',
    options: ['60', '70', '90', '55'],
    correctAnswer: 0,
    explanation: '40/100 * 150 = 60.',
  ),
  Question(
    id: 'rm_q150',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 50% de 300.',
    options: ['150', '160', '225', '145'],
    correctAnswer: 0,
    explanation: '50/100 * 300 = 150.',
  ),
  Question(
    id: 'rm_q151',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 40% de 50.',
    options: ['20', '30', '30', '15'],
    correctAnswer: 0,
    explanation: '40/100 * 50 = 20.',
  ),
  Question(
    id: 'rm_q152',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 30% de 50.',
    options: ['15', '25', '22', '10'],
    correctAnswer: 0,
    explanation: '30/100 * 50 = 15.',
  ),
  Question(
    id: 'rm_q153',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 30% de 40.',
    options: ['12', '22', '18', '7'],
    correctAnswer: 0,
    explanation: '30/100 * 40 = 12.',
  ),
  Question(
    id: 'rm_q154',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 75% de 80.',
    options: ['60', '70', '90', '55'],
    correctAnswer: 0,
    explanation: '75/100 * 80 = 60.',
  ),
  Question(
    id: 'rm_q155',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 50% de 50.',
    options: ['25', '35', '37', '20'],
    correctAnswer: 0,
    explanation: '50/100 * 50 = 25.',
  ),
  Question(
    id: 'rm_q156',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 25% de 400.',
    options: ['100', '110', '150', '95'],
    correctAnswer: 0,
    explanation: '25/100 * 400 = 100.',
  ),
  Question(
    id: 'rm_q157',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 50% de 120.',
    options: ['60', '70', '90', '55'],
    correctAnswer: 0,
    explanation: '50/100 * 120 = 60.',
  ),
  Question(
    id: 'rm_q158',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 30% de 250.',
    options: ['75', '85', '112', '70'],
    correctAnswer: 0,
    explanation: '30/100 * 250 = 75.',
  ),
  Question(
    id: 'rm_q159',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 10% de 120.',
    options: ['12', '22', '18', '7'],
    correctAnswer: 0,
    explanation: '10/100 * 120 = 12.',
  ),
  Question(
    id: 'rm_q160',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 20% de 500.',
    options: ['100', '110', '150', '95'],
    correctAnswer: 0,
    explanation: '20/100 * 500 = 100.',
  ),
  Question(
    id: 'rm_q161',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 10% de 500.',
    options: ['50', '60', '75', '45'],
    correctAnswer: 0,
    explanation: '10/100 * 500 = 50.',
  ),
  Question(
    id: 'rm_q162',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 25% de 80.',
    options: ['20', '30', '30', '15'],
    correctAnswer: 0,
    explanation: '25/100 * 80 = 20.',
  ),
  Question(
    id: 'rm_q163',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 60% de 150.',
    options: ['90', '100', '135', '85'],
    correctAnswer: 0,
    explanation: '60/100 * 150 = 90.',
  ),
  Question(
    id: 'rm_q164',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 60% de 150.',
    options: ['90', '100', '135', '85'],
    correctAnswer: 0,
    explanation: '60/100 * 150 = 90.',
  ),
  Question(
    id: 'rm_q165',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 75% de 200.',
    options: ['150', '160', '225', '145'],
    correctAnswer: 0,
    explanation: '75/100 * 200 = 150.',
  ),
  Question(
    id: 'rm_q166',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 40% de 500.',
    options: ['200', '210', '300', '195'],
    correctAnswer: 0,
    explanation: '40/100 * 500 = 200.',
  ),
  Question(
    id: 'rm_q167',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 40% de 150.',
    options: ['60', '70', '90', '55'],
    correctAnswer: 0,
    explanation: '40/100 * 150 = 60.',
  ),
  Question(
    id: 'rm_q168',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 60% de 400.',
    options: ['240', '250', '360', '235'],
    correctAnswer: 0,
    explanation: '60/100 * 400 = 240.',
  ),
  Question(
    id: 'rm_q169',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 75% de 400.',
    options: ['300', '310', '450', '295'],
    correctAnswer: 0,
    explanation: '75/100 * 400 = 300.',
  ),
  Question(
    id: 'rm_q170',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 75% de 50.',
    options: ['37', '47', '55', '32'],
    correctAnswer: 0,
    explanation: '75/100 * 50 = 37.',
  ),
  Question(
    id: 'rm_q171',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 80% de 120.',
    options: ['96', '106', '144', '91'],
    correctAnswer: 0,
    explanation: '80/100 * 120 = 96.',
  ),
  Question(
    id: 'rm_q172',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 10% de 40.',
    options: ['4', '14', '6', '-1'],
    correctAnswer: 0,
    explanation: '10/100 * 40 = 4.',
  ),
  Question(
    id: 'rm_q173',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 25% de 40.',
    options: ['10', '20', '15', '5'],
    correctAnswer: 0,
    explanation: '25/100 * 40 = 10.',
  ),
  Question(
    id: 'rm_q174',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 50% de 300.',
    options: ['150', '160', '225', '145'],
    correctAnswer: 0,
    explanation: '50/100 * 300 = 150.',
  ),
  Question(
    id: 'rm_q175',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 10% de 500.',
    options: ['50', '60', '75', '45'],
    correctAnswer: 0,
    explanation: '10/100 * 500 = 50.',
  ),
  Question(
    id: 'rm_q176',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 40% de 400.',
    options: ['160', '170', '240', '155'],
    correctAnswer: 0,
    explanation: '40/100 * 400 = 160.',
  ),
  Question(
    id: 'rm_q177',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 25% de 50.',
    options: ['12', '22', '18', '7'],
    correctAnswer: 0,
    explanation: '25/100 * 50 = 12.',
  ),
  Question(
    id: 'rm_q178',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 10% de 300.',
    options: ['30', '40', '45', '25'],
    correctAnswer: 0,
    explanation: '10/100 * 300 = 30.',
  ),
  Question(
    id: 'rm_q179',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 50% de 150.',
    options: ['75', '85', '112', '70'],
    correctAnswer: 0,
    explanation: '50/100 * 150 = 75.',
  ),
  Question(
    id: 'rm_q180',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 60% de 200.',
    options: ['120', '130', '180', '115'],
    correctAnswer: 0,
    explanation: '60/100 * 200 = 120.',
  ),
  Question(
    id: 'rm_q181',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 80% de 80.',
    options: ['64', '74', '96', '59'],
    correctAnswer: 0,
    explanation: '80/100 * 80 = 64.',
  ),
  Question(
    id: 'rm_q182',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 25% de 300.',
    options: ['75', '85', '112', '70'],
    correctAnswer: 0,
    explanation: '25/100 * 300 = 75.',
  ),
  Question(
    id: 'rm_q183',
    topicId: 'rm_fracciones',
    text: 'FIJA PORCENTAJES: Calcule el 10% de 500.',
    options: ['50', '60', '75', '45'],
    correctAnswer: 0,
    explanation: '10/100 * 500 = 50.',
  ),
  Question(
    id: 'rm_q184',
    topicId: 'rm_ecuaciones',
    text:
        'Halle el valor de la suma de los 20 primeros números impares positivos.',
    options: ['200', '400', '380', '420'],
    correctAnswer: 1,
    explanation:
        "La suma de los 'n' primeros números impares positivos está dada por la fórmula S = n². Para n = 20, la suma es 20² = 400.",
  ),
  Question(
    id: 'rm_q185',
    topicId: 'rm_ecuaciones',
    text:
        'Calcule la suma de los cuadrados de los primeros 10 números enteros positivos.',
    options: ['385', '330', '440', '285'],
    correctAnswer: 0,
    explanation:
        'Aplicando la fórmula de la suma de cuadrados S = n(n + 1)(2n + 1) / 6. Para n = 10, tenemos: S = 10 × 11 × 21 / 6 = 385.',
  ),
  Question(
    id: 'rm_q186',
    topicId: 'rm_ecuaciones',
    text:
        'Calcule el valor de la siguiente suma: S = 1/(1×2) + 1/(2×3) + 1/(3×4) + ... + 1/(29×30).',
    options: ['29/30', '14/15', '30/31', '15/16'],
    correctAnswer: 0,
    explanation:
        'Por descomposición en fracciones parciales, cada término se reescribe como 1/n - 1/(n+1). La serie se comporta como telescópica cancelando todos los términos intermedios y dejando solo S = 1 - 1/30 = 29/30.',
  ),
  Question(
    id: 'rm_q187',
    topicId: 'rm_ecuaciones',
    text:
        'Determine el valor de la siguiente suma infinita: S = 1/2 + 2/4 + 3/8 + 4/16 + 5/32 + ...',
    options: ['2', '3/2', '1', '4/3'],
    correctAnswer: 0,
    explanation:
        'Es una serie aritmético-geométrica. Restando S/2 a la ecuación original de S, se reduce a una serie geométrica decreciente clásica: S/2 = 1/2 + 1/4 + 1/8 + 1/16 + ... = 1. Multiplicando por 2, se obtiene S = 2.',
  ),
  Question(
    id: 'rm_q188',
    topicId: 'rm_ecuaciones',
    text:
        'En un corral hay gallinas y conejos. Si se cuentan 35 cabezas y 110 patas en total, ¿cuántos conejos hay?',
    options: ['15', '20', '25', '10'],
    correctAnswer: 1,
    explanation:
        'Sea g el número de gallinas y c el de conejos. Tenemos g + c = 35 y 2g + 4c = 110. Multiplicando la primera ecuación por 2 y restándola de la segunda: 2c = 40 => c = 20 conejos.',
  ),
  Question(
    id: 'rm_q189',
    topicId: 'rm_ecuaciones',
    text:
        'Si gastara la tercera parte de mi dinero y luego ganara 20 soles, tendría la misma cantidad que si desde el inicio hubiera perdido la mitad de mi dinero y luego ganara 45 soles. ¿Cuánto dinero tengo?',
    options: ['S/. 120', 'S/. 150', 'S/. 180', 'S/. 160'],
    correctAnswer: 1,
    explanation:
        'Sea x el dinero. Planteando: x - x/3 + 20 = x - x/2 + 45 => 2x/3 + 20 = x/2 + 45 => 2x/3 - x/2 = 25. Multiplicando por 6: 4x - 3x = 150 => x = 150 soles.',
  ),
  Question(
    id: 'rm_q190',
    topicId: 'rm_ecuaciones',
    text:
        'Tres números enteros consecutivos suman 126. ¿Cuál es el mayor de dichos números?',
    options: ['41', '42', '43', '44'],
    correctAnswer: 2,
    explanation:
        'Sean los números x, x+1 y x+2. Su suma es 3x + 3 = 126 => 3x = 123 => x = 41. Los números son 41, 42 y 43. El mayor de ellos es 43.',
  ),
  Question(
    id: 'rm_q191',
    topicId: 'rm_ecuaciones',
    text:
        'Si compro 8 libros me faltarían 14 soles, pero si compro solo 5 libros me sobrarían 22 soles. ¿Cuánto cuesta cada libro?',
    options: ['12 soles', '10 soles', '15 soles', '11 soles'],
    correctAnswer: 0,
    explanation:
        'Sea x el costo por libro. El dinero disponible se expresa como 8x - 14 y 5x + 22. Igualando las ecuaciones: 8x - 14 = 5x + 22 => 3x = 36 => x = 12 soles.',
  ),
  Question(
    id: 'rm_q192',
    topicId: 'rm_ecuaciones',
    text:
        'Una tía reparte propinas entre sus sobrinos. Si les da 5 soles a cada uno, le sobran 8 soles; pero si les da 6 soles a cada uno, le faltan 2 soles. ¿Cuántos sobrinos tiene?',
    options: ['10', '8', '12', '6'],
    correctAnswer: 0,
    explanation:
        'Sea x el número de sobrinos. El dinero disponible se representa por 5x + 8 o 6x - 2. Igualando las expresiones: 5x + 8 = 6x - 2 => x = 10 sobrinos.',
  ),
  Question(
    id: 'rm_q193',
    topicId: 'rm_ecuaciones',
    text:
        'Una empresa de transporte cobra una tarifa fija de 5 soles más 2.50 soles por kilómetro recorrido. Si un pasajero pagó 45 soles por un viaje, ¿cuántos kilómetros recorrió?',
    options: ['15 km', '16 km', '18 km', '20 km'],
    correctAnswer: 1,
    explanation:
        'Planteamos la ecuación lineal Costo = 5 + 2.5x. Reemplazando el costo de 45 soles: 45 = 5 + 2.5x => 40 = 2.5x => x = 16 km.',
  ),
  Question(
    id: 'rm_q194',
    topicId: 'rm_ecuaciones',
    text:
        'La suma de dos números es 84 y su cociente es 3. ¿Cuál es el menor de estos números?',
    options: ['21', '28', '63', '18'],
    correctAnswer: 0,
    explanation:
        'Sean los números x (mayor) e y (menor). Su cociente es x/y = 3, lo que implica x = 3y. Además, x + y = 84. Sustituyendo: 3y + y = 84 => 4y = 84 => y = 21.',
  ),
  Question(
    id: 'rm_q195',
    topicId: 'rm_ecuaciones',
    text:
        'Un depósito lleno de agua se vacía en tres horas. En cada hora se va la mitad de su contenido más 2 litros. ¿Cuál es la capacidad del depósito en litros?',
    options: ['24 litros', '28 litros', '30 litros', '32 litros'],
    correctAnswer: 1,
    explanation:
        'Aplicamos el método del cangrejo desde el volumen final (0 litros): 3ª hora: (0 + 2) × 2 = 4 litros; 2ª hora: (4 + 2) × 2 = 12 litros; 1ª hora: (12 + 2) × 2 = 28 litros. La capacidad inicial era de 28 litros.',
  ),
  Question(
    id: 'rm_q196',
    topicId: 'rm_ecuaciones',
    text:
        'El largo de un terreno rectangular excede a su ancho en 6 metros. Si el área del terreno es de 216 metros cuadrados, ¿cuánto mide el perímetro del terreno?',
    options: ['60 metros', '54 metros', '72 metros', '48 metros'],
    correctAnswer: 0,
    explanation:
        'Sean x el ancho y x + 6 el largo. El área es x(x + 6) = 216 => x² + 6x - 216 = 0. Factorizando la cuadrática: (x + 18)(x - 12) = 0. Como el ancho debe ser positivo, x = 12. Las dimensiones son 12 m y 18 m. El perímetro es 2 × (12 + 18) = 60 metros.',
  ),
  Question(
    id: 'rm_q197',
    topicId: 'rm_ecuaciones',
    text:
        'Dos ciclistas parten simultáneamente de dos puntos A y B distantes 150 km, dirigiéndose el uno hacia el otro. Si el que parte de A viaja a 22 km/h y el de B a 18 km/h, ¿después de cuántas horas se encontrarán?',
    options: [
      '3 horas y 45 minutos',
      '3 horas y 15 minutos',
      '4 horas',
      '3 horas y 30 minutos',
    ],
    correctAnswer: 0,
    explanation:
        'El tiempo de encuentro es t_e = D / (V_A + V_B) = 150 / (22 + 18) = 150 / 40 = 3.75 horas. Dado que 0.75 horas corresponde a 45 minutos, se encontrarán en 3 horas y 45 minutos.',
  ),
  Question(
    id: 'rm_q198',
    topicId: 'rm_ecuaciones',
    text:
        'Un comerciante compra un lote de camisas por un valor total de 1200 soles. Si hubiera comprado 10 camisas más por el mismo dinero, cada camisa le habría costado 20 soles menos. ¿Cuántas camisas compró originalmente?',
    options: ['20', '24', '25', '30'],
    correctAnswer: 0,
    explanation:
        'Sea x el número de camisas. Planteamos: 1200 / (x + 10) = 1200 / x - 20. Simplificando y reordenando: x² + 10x - 600 = 0. Factorizando la ecuación: (x + 30)(x - 20) = 0. Como la cantidad debe ser positiva, compró originalmente 20 camisas.',
  ),
  Question(
    id: 'rm_q199',
    topicId: 'rm_ecuaciones',
    text:
        'Un albañil puede construir una pared en 12 días, mientras que su ayudante tardaría 24 días en hacer el mismo trabajo. Si trabajan juntos, ¿en cuántos días construirán la pared?',
    options: ['8 días', '6 días', '9 días', '10 días'],
    correctAnswer: 0,
    explanation:
        'El rendimiento conjunto por día es 1/12 + 1/24 = 3/24 = 1/8 de la pared. Por lo tanto, tardarán 8 días en construirla por completo.',
  ),
  Question(
    id: 'rm_q200',
    topicId: 'rm_ecuaciones',
    text:
        'Un camión recorre una distancia de 240 km a velocidad constante. Si su velocidad hubiera sido 20 km/h mayor, habría tardado 1 hora menos en realizar el recorrido. ¿A qué velocidad en km/h viajó el camión?',
    options: ['60 km/h', '80 km/h', '50 km/h', '70 km/h'],
    correctAnswer: 0,
    explanation:
        'Sea v la velocidad. Planteando: (v + 20)(240/v - 1) = 240, lo cual simplifica a la ecuación cuadrática v² + 20v - 4800 = 0. Factorizando: (v + 80)(v - 60) = 0. Al tomar el valor positivo, la velocidad es 60 km/h.',
  ),
  Question(
    id: 'rm_q201',
    topicId: 'rm_ecuaciones',
    text:
        'Se desea pagar una deuda de 142 soles utilizando únicamente monedas de 5 soles y de 2 soles. ¿De cuántas formas distintas se puede realizar el pago si se deben usar al menos una moneda de cada denominación?',
    options: ['14', '13', '15', '12'],
    correctAnswer: 0,
    explanation:
        'Planteamos la ecuación diofántica 5x + 2y = 142. Una solución inicial con enteros positivos es x = 2, y = 66. Como los coeficientes son primos entre sí, x aumenta de 2 en 2 (x = 2, 4, 6, ..., 28) mientras y disminuye de 5 en 5. La cantidad de soluciones válidas es el número de términos pares entre 2 y 28 inclusive, lo que equivale a (28 - 2)/2 + 1 = 14 formas distintas.',
  ),
  Question(
    id: 'rm_q202',
    topicId: 'rm_ecuaciones',
    text:
        'Una tubería A llena un estanque en 3 horas y otra tubería B lo vacía en 6 horas. Si el estanque está vacío y se abren ambas tuberías simultáneamente, pero después de 2 horas se cierra la tubería de desagüe B, ¿en cuántas horas adicionales terminará de llenarse el estanque?',
    options: [
      '2 horas',
      '2 horas y 30 minutos',
      '3 horas',
      '1 hora y 45 minutos',
    ],
    correctAnswer: 0,
    explanation:
        'Juntas llenan (1/3 - 1/6) = 1/6 del estanque por hora. En 2 horas completan 2 × 1/6 = 1/3 del estanque. Queda 2/3 por llenar. A partir de entonces, solo trabaja A con un rendimiento de 1/3 por hora. El tiempo adicional es (2/3) / (1/3) = 2 horas.',
  ),
  Question(
    id: 'rm_q203',
    topicId: 'rm_ecuaciones',
    text:
        "Un comerciante estima que si vende un artículo a un precio 'x' soles, la ganancia mensual obtenida está dada por la función G(x) = -x² + 80x - 1200. ¿A qué precio debe vender el artículo para obtener la máxima ganancia posible?",
    options: ['S/. 40', 'S/. 50', 'S/. 35', 'S/. 45'],
    correctAnswer: 0,
    explanation:
        'La función es una parábola hacia abajo. La ganancia máxima ocurre en el vértice: x = -b / (2a) = -80 / (2 × -1) = 40 soles.',
  ),
  Question(
    id: 'rm_q204',
    topicId: 'rm_ecuaciones',
    text:
        'Un estanque se puede llenar por un grifo A en 4 horas y por un grifo B en 12 horas. Si se abre el grifo A por 1 hora y luego se abre también el grifo B, ¿cuánto tiempo adicional se requerirá para que el estanque quede completamente lleno?',
    options: [
      '2 horas y 15 minutos',
      '2 horas y 30 minutos',
      '1 hora y 45 minutos',
      '3 horas',
    ],
    correctAnswer: 0,
    explanation:
        'A llena 1/4 en la primera hora, restando 3/4 del volumen. Juntos tienen un rendimiento de 1/4 + 1/12 = 1/3 del estanque por hora. El tiempo adicional es (3/4) / (1/3) = 9/4 horas = 2 horas y 15 minutos.',
  ),
  Question(
    id: 'rm_q205',
    topicId: 'rm_ecuaciones',
    text:
        'Dos números reales positivos cumplen con que la suma de sus cuadrados es 170 y su producto es 77. ¿Cuál es el valor de la diferencia de estos dos números?',
    options: ['4', '3', '5', '6'],
    correctAnswer: 0,
    explanation:
        'Sabemos que (x - y)² = x² + y² - 2xy. Reemplazando los datos: (x - y)² = 170 - 2(77) = 170 - 154 = 16. La diferencia de los números positivos es √16 = 4.',
  ),
  Question(
    id: 'rm_q206',
    topicId: 'rm_ecuaciones',
    text:
        'En una urna hay 10 bolas rojas, 12 azules y 15 verdes. ¿Cuántas bolas se deben extraer al azar y como mínimo para tener la certeza de haber obtenido al menos una bola de cada color?',
    options: ['28', '27', '26', '29'],
    correctAnswer: 0,
    explanation:
        'Para asegurar al menos una bola de cada color, asumimos el peor de los casos: extraer primero todas las de los colores más abundantes. Extraemos las 15 verdes y luego las 12 azules (sumando 27). La siguiente bola extraída será necesariamente roja, completando al menos una de cada color. Total = 15 + 12 + 1 = 28.',
  ),
  Question(
    id: 'rm_q207',
    topicId: 'rm_ecuaciones',
    text:
        'Cuatro amigos (Andrés, Beto, Carlos y Daniel) viven en un edificio de cuatro pisos, cada uno en un piso diferente. Se sabe que Beto vive en el segundo piso, Andrés vive más arriba que Daniel, y Carlos vive inmediatamente debajo de Daniel. ¿En qué piso vive Andrés?',
    options: ['Primer piso', 'Tercer piso', 'Cuarto piso', 'Segundo piso'],
    correctAnswer: 2,
    explanation:
        'Beto vive en el 2° piso. Quedan libres los pisos 1, 3 y 4. Carlos vive inmediatamente debajo de Daniel, lo que significa que deben ocupar dos pisos contiguos libres. Los únicos pisos libres contiguos son el 1 y el 3 (ya que el 2 está ocupado por Beto). Por lo tanto, Carlos vive en el 1° y Daniel en el 3°. Andrés, que vive más arriba que Daniel, debe vivir en el 4° piso.',
  ),
  Question(
    id: 'rm_q208',
    topicId: 'rm_ecuaciones',
    text:
        "Tres sospechosos de un robo declaran lo siguiente ante un investigador: Alberto: 'Yo no cometí el robo'; Bernardo: 'César cometió el robo'; César: 'Lo que dice Bernardo es mentira'. Si se sabe que solo uno de ellos dice la verdad, ¿quién es el culpable del robo?",
    options: ['Alberto', 'Bernardo', 'César', 'No se puede determinar'],
    correctAnswer: 0,
    explanation:
        "Las declaraciones de Bernardo y César son contradictorias, lo que significa que necesariamente una es verdadera y la otra es falsa. Como las condiciones del problema establecen que 'solo uno dice la verdad', esta única verdad debe estar entre la afirmación de Bernardo y la de César. Por consecuencia directa, la afirmación de Alberto ('Yo no cometí el robo') debe ser falsa, lo que revela que Alberto es el culpable.",
  ),
  Question(
    id: 'rm_q209',
    topicId: 'rm_ecuaciones',
    text:
        '¿Qué parentesco tiene conmigo el único tío del hijo del único hermano de mi padre?',
    options: ['Mi padre', 'Mi tío', 'Mi abuelo', 'Mi hermano'],
    correctAnswer: 0,
    explanation:
        'Analizando de atrás hacia adelante: el único hermano de mi padre es mi tío. El hijo de mi tío es mi primo hermano. El único tío de mi primo hermano (por el lado paterno) tiene que ser mi propio padre.',
  ),
  Question(
    id: 'rm_q210',
    topicId: 'rm_ecuaciones',
    text:
        'Un estudiante tiene en su bolsillo 6 monedas de 1 sol, 8 monedas de 2 soles y 10 monedas de 5 soles. ¿Cuántas monedas debe extraer al azar y como mínimo para tener la certeza de haber extraído por lo menos 3 monedas del mismo valor?',
    options: ['7', '9', '8', '10'],
    correctAnswer: 0,
    explanation:
        'Para evitar tener 3 monedas del mismo valor en el peor de los casos, extraemos el máximo de monedas posibles sin cumplir el objetivo, que sería tener exactamente 2 monedas de cada una de las 3 denominaciones (total 6 monedas). La séptima moneda que se extraiga pertenecerá necesariamente a uno de los tres tipos, completando al menos 3 monedas de la misma denominación. Total = 6 + 1 = 7.',
  ),
  Question(
    id: 'rm_q211',
    topicId: 'rm_ecuaciones',
    text:
        "Cuatro niños son interrogados por romper un juguete: Gabriel: 'Lucas lo rompió'; Lucas: 'Mateo lo rompió'; Mateo: 'Lucas miente al acusarme'; Tomás: 'Yo no lo rompí'. Si solo uno de ellos miente y solo uno es el culpable, ¿quién rompió el juguete?",
    options: ['Mateo', 'Lucas', 'Gabriel', 'Tomás'],
    correctAnswer: 1,
    explanation:
        "Las declaraciones de Lucas ('Mateo lo rompió') y Mateo ('Lucas miente al acusarme') son contradictorias, lo que significa que una de ellas es verdadera y la otra es falsa. Como solo uno de los cuatro miente, el mentiroso debe ser o Lucas o Mateo. Por ende, Gabriel y Tomás dicen la verdad de forma obligatoria. Dado que la declaración de Gabriel ('Lucas lo rompió') es verdadera, concluimos que Lucas es el culpable.",
  ),
  Question(
    id: 'rm_q212',
    topicId: 'rm_ecuaciones',
    text:
        'En un cajón hay 8 pares de calcetines negros y 6 pares de calcetines blancos, todos desordenados. ¿Cuál es el menor número de calcetines individuales que se deben extraer al azar para tener la seguridad de obtener al menos un par del mismo color?',
    options: ['3', '15', '5', '4'],
    correctAnswer: 0,
    explanation:
        'Como solo hay dos colores de calcetines en el cajón (negros y blancos), al extraer 3 calcetines cualesquiera, por el principio del palomar (o de Dirichlet), al menos dos de ellos deben pertenecer al mismo color. Por lo tanto, 3 extracciones son suficientes.',
  ),
  Question(
    id: 'rm_q213',
    topicId: 'rm_ecuaciones',
    text:
        'Cuatro amigos (Álex, Blas, César y Daniel) se sientan alrededor de una mesa circular con cuatro asientos distribuidos simétricamente. Se sabe que: Álex se sienta frente a César, y Blas no se sienta a la izquierda de César. ¿Quién se sienta a la derecha de Álex?',
    options: ['Blas', 'César', 'Daniel', 'Nadie'],
    correctAnswer: 0,
    explanation:
        'Colocamos a César en la mesa y a Álex frente a él. Como Blas no se sienta a la izquierda de César, Blas se sienta obligatoriamente a su derecha. Por descarte, Daniel se sienta a la izquierda de César. Al mirar el arreglo desde la posición de Álex hacia el centro de la mesa, la derecha de Álex corresponde a la izquierda de César, donde se encuentra sentado Blas.',
  ),
  Question(
    id: 'rm_q214',
    topicId: 'rm_ecuaciones',
    text:
        'Tres amigas (Elena, Sandra y Patricia) tienen una profesión distinta cada una: ingeniera, médica y abogada. Se sabe que Sandra es menor que la ingeniera, Elena no es abogada, y la abogada es la mayor de las tres. ¿Qué profesión tiene Elena?',
    options: ['Médica', 'Ingeniera', 'Abogada', 'No se puede determinar'],
    correctAnswer: 1,
    explanation:
        'La abogada es la mayor. Como Sandra es menor que la ingeniera, Sandra no es la ingeniera, y Sandra tampoco es la abogada (la mayor), así que Sandra debe ser la médica. Quedan Elena y Patricia para ingeniera y abogada. Dado que Elena no es abogada, Elena es la ingeniera y Patricia es la abogada.',
  ),
  Question(
    id: 'rm_q215',
    topicId: 'rm_ecuaciones',
    text:
        'Si todos los filósofos son pensadores y algunos pensadores son científicos, ¿cuál de las siguientes afirmaciones es lógicamente necesaria?',
    options: [
      'Algunos filósofos son científicos',
      'Todos los científicos son filósofos',
      'No todos los pensadores son filósofos',
      'Ninguna de las anteriores es lógicamente necesaria',
    ],
    correctAnswer: 3,
    explanation:
        'El conjunto de filósofos está dentro del conjunto de pensadores. El conjunto de científicos tiene intersección con el de pensadores, pero esta intersección no tiene por qué solaparse necesariamente con el conjunto de filósofos. Tampoco hay garantía de que los pensadores no sean idénticos a los filósofos. Ninguna afirmación es necesaria.',
  ),
  Question(
    id: 'rm_q216',
    topicId: 'rm_ecuaciones',
    text:
        'En una bolsa hay caramelos del mismo tamaño: 15 de limón, 12 de naranja, 9 de menta y 6 de fresa. ¿Cuál es la cantidad mínima de caramelos que se deben extraer al azar para tener la certeza de haber obtenido al menos 5 caramelos de naranja?',
    options: ['35', '32', '37', '34'],
    correctAnswer: 0,
    explanation:
        'Asumimos el peor de los casos posibles: extraemos primero todos los caramelos de los sabores que no son naranja (15 limón + 9 menta + 6 fresa = 30 extracciones). Luego, extraemos solo 4 de naranja sin lograr el objetivo. Con 30 + 4 = 34 extracciones aún no hay certeza absoluta. La número 35 será necesariamente de naranja, completando los 5 requeridos.',
  ),
  Question(
    id: 'rm_q217',
    topicId: 'rm_ecuaciones',
    text:
        'Seis amigos (A, B, C, D, E y F) se sientan alrededor de una mesa circular con seis asientos distribuidos simétricamente. Se sabe que: A se sienta frente a D; B se sienta junto a A; E se sienta frente a B. ¿Quién se sienta necesariamente frente a C?',
    options: ['F', 'A', 'D', 'E'],
    correctAnswer: 0,
    explanation:
        'Los seis asientos se agrupan en tres parejas opuestas: {A, D} ocupa la primera, {B, E} ocupa la segunda. Por exclusión, la pareja restante {C, F} debe ocupar la tercera pareja de asientos opuestos. Por tanto, F siempre se sentará frente a C.',
  ),
  Question(
    id: 'rm_q218',
    topicId: 'rm_ecuaciones',
    text:
        'En una carrera de atletismo de cinco participantes, se sabe que: Mateo no llegó en primer lugar; Nicolás llegó inmediatamente después de Javier; Sergio llegó antes que Javier; Camilo llegó en tercer lugar. ¿Quién ganó la carrera?',
    options: ['Sergio', 'Javier', 'Mateo', 'Nicolás'],
    correctAnswer: 0,
    explanation:
        'Camilo llegó 3°. Javier y Nicolás deben llegar en puestos consecutivos (J y N). Como Sergio llegó antes que Javier, Javier y Nicolás no pueden ser 1° y 2°. Por lo tanto, Javier es 4° y Nicolás es 5°. Sergio y Mateo deben ser 1° y 2°. Como Mateo no ganó, Sergio es 1° y Mateo es 2°. Sergio es el ganador.',
  ),
  Question(
    id: 'rm_q219',
    topicId: 'rm_ecuaciones',
    text:
        'En un grupo de 100 estudiantes de idiomas, 60 estudian inglés, 45 estudian francés y 20 estudian ambos idiomas. ¿Cuántos estudiantes no estudian ninguno de los dos idiomas?',
    options: ['15', '25', '10', '20'],
    correctAnswer: 0,
    explanation:
        'Usando un diagrama de Venn: solo inglés = 60 - 20 = 40; solo francés = 45 - 20 = 25; ambos = 20. Los que estudian al menos un idioma son 40 + 25 + 20 = 85. Los que no estudian ninguno son 100 - 85 = 15.',
  ),
  Question(
    id: 'rm_q220',
    topicId: 'rm_ecuaciones',
    text:
        "Cuatro sospechosas de haber tomado un objeto ajeno declaran lo siguiente: Ana: 'Beatriz lo tomó'; Beatriz: 'Carla lo tomó'; Carla: 'Lo que dice Beatriz es mentira'; Diana: 'Yo no lo tomé'. Si se sabe que solo una de ellas dice la verdad y las otras tres mienten, ¿quién tomó el objeto?",
    options: ['Ana', 'Beatriz', 'Carla', 'Diana'],
    correctAnswer: 3,
    explanation:
        "Las declaraciones de Beatriz y Carla son contradictorias, por lo que una es verdadera y la otra es falsa. Como solo una de las cuatro dice la verdad, las declaraciones de Ana y Diana deben ser falsas. Puesto que la declaración de Diana ('Yo no lo tomé') es mentira, concluimos que Diana tomó el objeto.",
  ),
  Question(
    id: 'rm_q221',
    topicId: 'rm_ecuaciones',
    text:
        'En un edificio de 6 pisos viven seis amigos: Mario, Néstor, Orlando, Patricio, Renato y Samuel, cada uno en un piso diferente. Se sabe que: Mario vive en un piso adyacente al de Néstor y al de Orlando; Patricio vive en el quinto piso; Renato vive dos pisos más arriba que Samuel; Orlando vive en el primer piso. ¿En qué piso vive Renato?',
    options: ['Sexto piso', 'Cuarto piso', 'Tercer piso', 'Segundo piso'],
    correctAnswer: 0,
    explanation:
        'Orlando vive en el 1° piso. Como Mario es adyacente a Orlando y Néstor, Mario debe estar en el 2° y Néstor en el 3° piso. Patricio vive en el 5°. Los pisos libres son 4° y 6°. Como Renato vive dos pisos más arriba que Samuel, la única opción es que Samuel viva en el 4° y Renato en el 6° piso.',
  ),
  Question(
    id: 'rm_q222',
    topicId: 'rm_ecuaciones',
    text:
        "Tres personas inteligentes (A, B y C) son colocadas en fila, de modo que A ve a B y a C, B solo ve a C, y C no ve a ninguno. Se les coloca un sombrero de un conjunto de 3 negros y 2 blancos. A dice: 'No sé el color de mi sombrero'. B dice: 'Tampoco sé'. C dice: 'Ya sé el color de mi sombrero'. ¿De qué color es el sombrero de C?",
    options: ['Negro', 'Blanco', 'Rojo', 'No se puede determinar'],
    correctAnswer: 0,
    explanation:
        'Si B y C tuvieran sombreros blancos, A vería los únicos dos blancos y sabría que el suyo es negro. Como A no sabe, B y C no son ambos blancos. B lo deduce: si C tuviera sombrero blanco, B sabría que el suyo es negro (ya que ambos no son blancos). Al no saber B tampoco, C no tiene sombrero blanco. Así, C deduce que su sombrero es negro.',
  ),
  Question(
    id: 'rm_q223',
    topicId: 'rm_ecuaciones',
    text:
        'En la figura, una línea horizontal divide a un triángulo principal por la mitad de su altura, y tres líneas verticales parten del vértice superior hasta la base. ¿Cuántos triángulos en total se pueden contar en esta figura?',
    options: ['12', '10', '8', '6'],
    correctAnswer: 0,
    explanation:
        'La base inferior tiene 3 segmentos simples, que forman n(n+1)/2 = 3(4)/2 = 6 triángulos. La división horizontal crea un segundo nivel en la mitad superior de idénticas proporciones que forma otros 6 triángulos. En total hay 12 triángulos.',
  ),
  Question(
    id: 'rm_q224',
    topicId: 'rm_ecuaciones',
    text:
        'Si un cubo clásico de seis caras numeradas del 1 al 6 se despliega en el plano en forma de cruz, ¿cuál de las siguientes afirmaciones sobre las caras opuestas es siempre correcta?',
    options: [
      'La cara 1 siempre es opuesta a la 2',
      'Las caras opuestas nunca comparten una arista común en el cubo armado',
      'Dos caras opuestas pueden estar una al lado de la otra en el despliegue directo',
      'Las caras opuestas suman siempre un número par',
    ],
    correctAnswer: 1,
    explanation:
        'Por la naturaleza geométrica tridimensional del cubo, las caras opuestas se sitúan en planos paralelos y, por ende, nunca comparten una arista ni un vértice en común.',
  ),
  Question(
    id: 'rm_q225',
    topicId: 'rm_ecuaciones',
    text:
        'Sobre una línea recta se marcan 6 puntos consecutivos. ¿Cuántos segmentos diferentes con extremos en estos puntos se pueden formar?',
    options: ['15', '20', '12', '30'],
    correctAnswer: 0,
    explanation:
        'El número de segmentos que se pueden formar con n puntos alineados equivale a combinar los puntos de dos en dos: C(n, 2) = n(n-1)/2. Para n = 6: 6 × 5 / 2 = 15 segmentos.',
  ),
  Question(
    id: 'rm_q226',
    topicId: 'rm_ecuaciones',
    text:
        'Si observamos una pirámide de base cuadrada directamente desde arriba (vista de planta), ¿qué figura geométrica se visualiza?',
    options: [
      'Un cuadrado con sus dos diagonales cruzadas',
      'Un cuadrado vacío',
      'Cuatro triángulos adyacentes al centro',
      'Un triángulo',
    ],
    correctAnswer: 0,
    explanation:
        'Al mirar una pirámide cuadrangular desde arriba, se ve la base cuadrada y las 4 aristas laterales que convergen hacia el punto de la cúspide, proyectadas exactamente como las dos diagonales cruzadas del cuadrado.',
  ),
  Question(
    id: 'rm_q227',
    topicId: 'rm_ecuaciones',
    text:
        'Se tiene una estructura formada por bloques cúbicos apoyados en el suelo. En la base hay una fila de 4 cubos, detrás de ella hay otra fila de 4 cubos, y encima de esta segunda fila se colocan 2 cubos más en una segunda capa. Si la estructura no tiene cubos flotando, ¿cuántos cubos la conforman en total?',
    options: ['8', '10', '12', '6'],
    correctAnswer: 1,
    explanation:
        'Sumamos los bloques de cada sección de la estructura compactada: 4 cubos (base delantera) + 4 cubos (base trasera) + 2 cubos (segundo nivel trasero) = 10 cubos en total.',
  ),
  Question(
    id: 'rm_q228',
    topicId: 'rm_ecuaciones',
    text:
        'Al armar un cubo a partir de su plantilla desplegada, se observa que la cara con un círculo está rodeada por un cuadrado, un triángulo, una estrella y un rombo. Si la cara opuesta al círculo tiene una cruz, ¿cuál de las siguientes combinaciones de tres caras visibles no es posible mostrar simultáneamente en una sola vista del cubo?',
    options: [
      'Círculo, Cuadrado, Triángulo',
      'Cruz, Estrella, Rombo',
      'Círculo, Cruz, Estrella',
      'Cuadrado, Triángulo, Estrella',
    ],
    correctAnswer: 2,
    explanation:
        'Puesto que el círculo y la cruz son caras opuestas, es físicamente imposible que sean visibles de manera simultánea desde cualquier ángulo de visión del cubo armado.',
  ),
  Question(
    id: 'rm_q229',
    topicId: 'rm_ecuaciones',
    text:
        'Un círculo es dividido por 5 diámetros que pasan por su centro. ¿Cuántos sectores circulares de cualquier tamaño se pueden contar en total en la figura?',
    options: ['45', '90', '60', '50'],
    correctAnswer: 1,
    explanation:
        'Los 5 diámetros dividen al círculo en 10 sectores simples. La cantidad de sectores circulares (de tamaño de 1 a 9 sectores simples) se calcula como n(n-1) donde n = 10. Esto da 10 × 9 = 90 sectores.',
  ),
  Question(
    id: 'rm_q230',
    topicId: 'rm_ecuaciones',
    text:
        'En una rejilla de 3×3 cuadrados pequeños, ¿cuántos rectángulos que NO sean cuadrados se pueden contar en total?',
    options: ['22', '26', '36', '14'],
    correctAnswer: 1,
    explanation:
        'El número total de cuadriláteros en una rejilla de 3×3 es (3×4/2) × (3×4/2) = 36. El número de cuadrados totales es 1² + 2² + 3² = 14. Restando obtenemos 36 - 14 = 26 rectángulos que no son cuadrados.',
  ),
  Question(
    id: 'rm_q231',
    topicId: 'rm_ecuaciones',
    text:
        'Al desplegar un cubo, tres caras consecutivas en una misma fila tienen dibujados los números 2, 4 y 6 en ese orden. ¿Cuál de las siguientes afirmaciones es correcta al volver a armar el cubo?',
    options: [
      'Las caras 2 y 6 son opuestas',
      'Las caras 2 y 4 son opuestas',
      'Las caras 4 y 6 son opuestas',
      'Ninguna de las caras es opuesta entre sí',
    ],
    correctAnswer: 0,
    explanation:
        'En la plantilla de despliegue de un cubo, dos caras que están alineadas en una misma dirección con una única cara de por medio serán opuestas entre sí cuando el cubo se ensamble tridimensionalmente.',
  ),
  Question(
    id: 'rm_q232',
    topicId: 'rm_ecuaciones',
    text:
        'Se construye un bloque compacto en forma de prisma rectangular que mide 4 cubitos de largo, 3 de ancho y 3 de alto. Si se pintan todas las caras externas de este bloque de color rojo y luego se desarma, ¿cuántos cubitos quedarán sin pintura alguna en ninguna de sus caras?',
    options: ['2', '4', '6', '8'],
    correctAnswer: 0,
    explanation:
        'Los cubitos sin pintar forman el núcleo interior del prisma, cuyas dimensiones son (Largo - 2) × (Ancho - 2) × (Alto - 2) = (4 - 2) × (3 - 2) × (3 - 2) = 2 × 1 × 1 = 2 cubitos.',
  ),
  Question(
    id: 'rm_q233',
    topicId: 'rm_ecuaciones',
    text:
        'Si una figura en forma de flecha apunta hacia el noreste (arriba y derecha) y se refleja respecto a un espejo vertical, ¿hacia qué dirección apunta la flecha reflejada?',
    options: ['Noroeste', 'Sureste', 'Suroeste', 'Noreste'],
    correctAnswer: 0,
    explanation:
        'La reflexión respecto a un espejo vertical invierte el eje de izquierda a derecha (el componente este pasa a oeste) pero mantiene el eje vertical inalterado (el norte se mantiene). Por lo tanto, la flecha apuntará al noroeste.',
  ),
  Question(
    id: 'rm_q234',
    topicId: 'rm_ecuaciones',
    text:
        "Una figura con forma de 'F' se encuentra dibujada en una hoja transparente. Si se gira la hoja 90 grados en sentido horario en el plano de la mesa y luego se le da la vuelta a la hoja (volteo horizontal), ¿cómo se verá la letra?",
    options: [
      'Un trazo largo horizontal con las barras cortas apuntando hacia abajo en el extremo izquierdo',
      'Un trazo largo horizontal con las barras cortas apuntando hacia abajo en el extremo derecho',
      'Un trazo largo vertical con las barras cortas apuntando hacia la izquierda en el extremo superior',
      'Un trazo largo vertical con las barras cortas apuntando hacia la derecha en el extremo inferior',
    ],
    correctAnswer: 0,
    explanation:
        "Al girar la 'F' 90° horario, el trazo largo queda horizontal con su extremo superior (de donde nacen las barras) a la derecha, y las barras apuntan hacia abajo. Al hacer el volteo horizontal (espejo izquierda-derecha), los lados se invierten, pasando el extremo con las barras a la izquierda, manteniéndose apuntadas hacia abajo.",
  ),
  Question(
    id: 'rm_q235',
    topicId: 'rm_ecuaciones',
    text:
        'En una rejilla de 4×4 cuadrados pequeños, ¿cuántos cuadrados en total (de cualquier tamaño: 1×1, 2×2, 3×3 y 4×4) se pueden contar?',
    options: ['16', '30', '26', '34'],
    correctAnswer: 1,
    explanation:
        'El número total de cuadrados en una rejilla n×n es la suma de los cuadrados de los enteros desde 1 hasta n. Para n = 4, tenemos: 1² + 2² + 3² + 4² = 1 + 4 + 9 + 16 = 30 cuadrados.',
  ),
  Question(
    id: 'rm_q236',
    topicId: 'rm_ecuaciones',
    text:
        'En una cuadrícula de 3×3 calles, ¿cuántos caminos de longitud mínima existen para ir del vértice inferior izquierdo al vértice superior derecho transitando solo por las líneas?',
    options: ['20', '10', '16', '12'],
    correctAnswer: 0,
    explanation:
        'Se deben dar exactamente 3 pasos hacia la derecha y 3 hacia arriba. La cantidad de caminos es el número de permutaciones con repetición de 6 elementos con 3 y 3 repetidos: P_R(6; 3,3) = 6! / (3! × 3!) = 720 / 36 = 20.',
  ),
  Question(
    id: 'rm_q237',
    topicId: 'rm_ecuaciones',
    text:
        'Un cubo tiene dibujada una flecha en cada una de sus 6 caras. Al desplegarlo, se observa que todas las flechas apuntan hacia la cara adyacente del norte en la plantilla. Al armar el cubo, ¿cuál de las siguientes situaciones es físicamente imposible?',
    options: [
      'Que cuatro de las flechas formen un circuito cerrado continuo alrededor del cubo',
      'Que todas las flechas apunten hacia un mismo vértice común',
      'Que dos flechas en caras opuestas apunten en direcciones opuestas entre sí',
      'Que tres flechas converjan apuntando hacia una misma cara común',
    ],
    correctAnswer: 1,
    explanation:
        'Cada vértice en un cubo es compartido por exactamente 3 caras. Por lo tanto, como máximo 3 flechas pueden converger apuntando hacia un mismo vértice común. Es físicamente imposible que las 6 flechas lo hagan.',
  ),
  Question(
    id: 'rm_q238',
    topicId: 'rm_ecuaciones',
    text:
        'Al lanzar dos dados comunes simultáneamente, ¿cuál es la probabilidad de que la suma de los puntos obtenidos sea exactamente 8?',
    options: ['5/36', '1/6', '7/36', '1/9'],
    correctAnswer: 0,
    explanation:
        'Los casos totales son 6 × 6 = 36. Los casos favorables para que sumen 8 son: (2,6), (3,5), (4,4), (5,3) y (6,2), es decir, 5 casos. Por tanto, la probabilidad es 5/36.',
  ),
  Question(
    id: 'rm_q239',
    topicId: 'rm_ecuaciones',
    text:
        '¿De cuántas formas distintas se pueden sentar 5 personas en una fila de 5 asientos?',
    options: ['24', '60', '120', '25'],
    correctAnswer: 2,
    explanation:
        'El orden importa y se deben ubicar 5 personas en 5 asientos. Esto equivale a las permutaciones lineales de 5 elementos distintos: P(5) = 5! = 5 × 4 × 3 × 2 × 1 = 120.',
  ),
  Question(
    id: 'rm_q240',
    topicId: 'rm_ecuaciones',
    text:
        'De una baraja estándar de 52 cartas, se extrae una carta al azar. ¿Cuál es la probabilidad de que la carta sea una figura (J, Q, K) o un As?',
    options: ['4/13', '3/13', '1/13', '5/13'],
    correctAnswer: 0,
    explanation:
        'En la baraja hay 12 figuras (J, Q, K de 4 palos) y 4 ases (1 por palo), sumando 16 cartas favorables. La probabilidad es 16/52, que simplificada da 4/13.',
  ),
  Question(
    id: 'rm_q241',
    topicId: 'rm_ecuaciones',
    text:
        'Una persona tiene 4 pantalones, 5 camisas y 3 pares de zapatos, todos de diferentes modelos. ¿De cuántas maneras distintas se puede vestir combinando un pantalón, una camisa y un par de zapatos?',
    options: ['60', '12', '45', '80'],
    correctAnswer: 0,
    explanation:
        'Aplicando el principio fundamental de la multiplicación, el número total de formas diferentes de vestirse es el producto del número de opciones de cada prenda: 4 × 5 × 3 = 60 combinaciones.',
  ),
  Question(
    id: 'rm_q242',
    topicId: 'rm_ecuaciones',
    text:
        'En un grupo de 8 personas se desea elegir un comité compuesto por 3 miembros. ¿Cuántos comités diferentes se pueden formar?',
    options: ['56', '336', '48', '24'],
    correctAnswer: 0,
    explanation:
        'Puesto que el orden de los miembros en el comité no altera al grupo seleccionado, se usan combinaciones: C(8, 3) = 8! / (3! × 5!) = (8 × 7 × 6) / (3 × 2 × 1) = 56.',
  ),
  Question(
    id: 'rm_q243',
    topicId: 'rm_ecuaciones',
    text:
        'Si se lanza una moneda tres veces consecutivas, ¿cuál es la probabilidad de obtener exactamente dos caras y un sello en cualquier orden?',
    options: ['3/8', '1/2', '1/4', '5/8'],
    correctAnswer: 0,
    explanation:
        'Los casos posibles son 2³ = 8. Los casos favorables con dos caras y un sello son: CCS, CSC, SCC (3 casos). Por lo tanto, la probabilidad es 3/8.',
  ),
  Question(
    id: 'rm_q244',
    topicId: 'rm_ecuaciones',
    text:
        'En una caja hay 5 esferas rojas y 4 esferas azules. Si se extraen 3 esferas al azar, ¿de cuántas maneras se pueden extraer exactamente 2 esferas rojas y 1 esfera azul?',
    options: ['40', '20', '30', '12'],
    correctAnswer: 0,
    explanation:
        'Elegir 2 rojas de 5 disponibles es C(5, 2) = 10 formas. Elegir 1 azul de 4 disponibles es C(4, 1) = 4 formas. Aplicando el principio de multiplicación, el número de maneras es 10 × 4 = 40.',
  ),
  Question(
    id: 'rm_q245',
    topicId: 'rm_ecuaciones',
    text:
        'Si se lanzan 4 monedas al mismo tiempo, ¿cuál es la probabilidad de obtener exactamente 3 caras y 1 sello?',
    options: ['1/4', '3/8', '1/8', '5/16'],
    correctAnswer: 0,
    explanation:
        'El número total de resultados posibles es 2⁴ = 16. La cantidad de casos con exactamente 3 caras y 1 sello equivale a elegir la posición del sello: C(4, 1) = 4 casos. La probabilidad es 4/16 = 1/4 (o 0.25).',
  ),
  Question(
    id: 'rm_q246',
    topicId: 'rm_ecuaciones',
    text:
        "¿Cuántas palabras distintas (con o sin sentido) se pueden formar ordenando todas las letras de la palabra 'CASA'?",
    options: ['12', '24', '6', '8'],
    correctAnswer: 0,
    explanation:
        "La palabra CASA contiene 4 letras en total con la letra 'A' repetida 2 veces. Aplicando permutaciones con repetición: P_R(4; 2) = 4! / 2! = (4 × 3 × 2 × 1) / (2 × 1) = 12 palabras distintas.",
  ),
  Question(
    id: 'rm_q247',
    topicId: 'rm_ecuaciones',
    text:
        'La probabilidad de que un estudiante apruebe un examen es de 0.75 y la de que apruebe un segundo examen es de 0.60. Si la aprobación de ambos exámenes es independiente, ¿cuál es la probabilidad de que no apruebe ninguno?',
    options: ['0.10', '0.15', '0.05', '0.25'],
    correctAnswer: 0,
    explanation:
        'La probabilidad de desaprobar el primer examen es 1 - 0.75 = 0.25. La de desaprobar el segundo es 1 - 0.60 = 0.40. Al ser eventos independientes, la probabilidad de que no apruebe ninguno es el producto de ambas probabilidades: 0.25 × 0.40 = 0.10.',
  ),
  Question(
    id: 'rm_q248',
    topicId: 'rm_ecuaciones',
    text:
        '¿De cuántas maneras diferentes se pueden sentar 6 personas alrededor de una mesa circular si dos de ellas en particular insisten en sentarse siempre juntas?',
    options: ['48', '24', '120', '96'],
    correctAnswer: 0,
    explanation:
        'Se considera a las dos personas que deben estar juntas como un bloque, reduciendo los elementos a ordenar circularmente de 6 a 5. El número de formas de ordenarlos es (5 - 1)! = 4! = 24. A su vez, las 2 personas en su bloque pueden intercambiar posiciones de 2! = 2 maneras. En total: 24 × 2 = 48 formas.',
  ),
  Question(
    id: 'rm_q249',
    topicId: 'rm_ecuaciones',
    text:
        'En un estante se van a ordenar 3 libros de Matemáticas, 2 de Física y 2 de Química, todos de autores distintos. ¿De cuántas formas se pueden ordenar si los libros de una misma materia deben permanecer siempre juntos?',
    options: ['144', '72', '288', '120'],
    correctAnswer: 0,
    explanation:
        'Se ordenan los 3 bloques de materias de 3! = 6 maneras. Dentro de cada bloque: matemáticas (3! = 6 formas), física (2! = 2 formas) y química (2! = 2 formas). Por el principio multiplicativo, el total es 6 × 6 × 2 × 2 = 144 formas.',
  ),
  Question(
    id: 'rm_q250',
    topicId: 'rm_ecuaciones',
    text:
        'En una urna hay 4 esferas rojas, 5 azules y 6 verdes. Si se extraen 3 esferas consecutivamente sin devolución, ¿cuál es la probabilidad de que la primera sea roja, la segunda azul y la tercera verde?',
    options: ['4/91', '3/91', '8/455', '12/455'],
    correctAnswer: 0,
    explanation:
        'La probabilidad conjunta es el producto de las probabilidades en cada extracción: 1ª (roja): 4/15; 2ª (azul, quedan 14 esferas): 5/14; 3ª (verde, quedan 13 esferas): 6/13. Multiplicando: (4/15) × (5/14) × (6/13) = 120 / 2730 = 12 / 273 = 4/91.',
  ),
  Question(
    id: 'rm_q251',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 43. Halle el número.',
    options: ['19', '20', '18', '38'],
    correctAnswer: 0,
    explanation: '2x + 5 = 43 -> 2x = 38 -> x = 19.',
  ),
  Question(
    id: 'rm_q252',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 19. Halle el número.',
    options: ['7', '8', '6', '14'],
    correctAnswer: 0,
    explanation: '2x + 5 = 19 -> 2x = 14 -> x = 7.',
  ),
  Question(
    id: 'rm_q253',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 33. Halle el número.',
    options: ['14', '15', '13', '28'],
    correctAnswer: 0,
    explanation: '2x + 5 = 33 -> 2x = 28 -> x = 14.',
  ),
  Question(
    id: 'rm_q254',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 33. Halle el número.',
    options: ['14', '15', '13', '28'],
    correctAnswer: 0,
    explanation: '2x + 5 = 33 -> 2x = 28 -> x = 14.',
  ),
  Question(
    id: 'rm_q255',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 35. Halle el número.',
    options: ['15', '16', '14', '30'],
    correctAnswer: 0,
    explanation: '2x + 5 = 35 -> 2x = 30 -> x = 15.',
  ),
  Question(
    id: 'rm_q256',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 31. Halle el número.',
    options: ['13', '14', '12', '26'],
    correctAnswer: 0,
    explanation: '2x + 5 = 31 -> 2x = 26 -> x = 13.',
  ),
  Question(
    id: 'rm_q257',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 45. Halle el número.',
    options: ['20', '21', '19', '40'],
    correctAnswer: 0,
    explanation: '2x + 5 = 45 -> 2x = 40 -> x = 20.',
  ),
  Question(
    id: 'rm_q258',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 33. Halle el número.',
    options: ['14', '15', '13', '28'],
    correctAnswer: 0,
    explanation: '2x + 5 = 33 -> 2x = 28 -> x = 14.',
  ),
  Question(
    id: 'rm_q259',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 19. Halle el número.',
    options: ['7', '8', '6', '14'],
    correctAnswer: 0,
    explanation: '2x + 5 = 19 -> 2x = 14 -> x = 7.',
  ),
  Question(
    id: 'rm_q260',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 33. Halle el número.',
    options: ['14', '15', '13', '28'],
    correctAnswer: 0,
    explanation: '2x + 5 = 33 -> 2x = 28 -> x = 14.',
  ),
  Question(
    id: 'rm_q261',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 17. Halle el número.',
    options: ['6', '7', '5', '12'],
    correctAnswer: 0,
    explanation: '2x + 5 = 17 -> 2x = 12 -> x = 6.',
  ),
  Question(
    id: 'rm_q262',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 45. Halle el número.',
    options: ['20', '21', '19', '40'],
    correctAnswer: 0,
    explanation: '2x + 5 = 45 -> 2x = 40 -> x = 20.',
  ),
  Question(
    id: 'rm_q263',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 35. Halle el número.',
    options: ['15', '16', '14', '30'],
    correctAnswer: 0,
    explanation: '2x + 5 = 35 -> 2x = 30 -> x = 15.',
  ),
  Question(
    id: 'rm_q264',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 21. Halle el número.',
    options: ['8', '9', '7', '16'],
    correctAnswer: 0,
    explanation: '2x + 5 = 21 -> 2x = 16 -> x = 8.',
  ),
  Question(
    id: 'rm_q265',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 31. Halle el número.',
    options: ['13', '14', '12', '26'],
    correctAnswer: 0,
    explanation: '2x + 5 = 31 -> 2x = 26 -> x = 13.',
  ),
  Question(
    id: 'rm_q266',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 29. Halle el número.',
    options: ['12', '13', '11', '24'],
    correctAnswer: 0,
    explanation: '2x + 5 = 29 -> 2x = 24 -> x = 12.',
  ),
  Question(
    id: 'rm_q267',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 41. Halle el número.',
    options: ['18', '19', '17', '36'],
    correctAnswer: 0,
    explanation: '2x + 5 = 41 -> 2x = 36 -> x = 18.',
  ),
  Question(
    id: 'rm_q268',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 17. Halle el número.',
    options: ['6', '7', '5', '12'],
    correctAnswer: 0,
    explanation: '2x + 5 = 17 -> 2x = 12 -> x = 6.',
  ),
  Question(
    id: 'rm_q269',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 39. Halle el número.',
    options: ['17', '18', '16', '34'],
    correctAnswer: 0,
    explanation: '2x + 5 = 39 -> 2x = 34 -> x = 17.',
  ),
  Question(
    id: 'rm_q270',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 29. Halle el número.',
    options: ['12', '13', '11', '24'],
    correctAnswer: 0,
    explanation: '2x + 5 = 29 -> 2x = 24 -> x = 12.',
  ),
  Question(
    id: 'rm_q271',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 39. Halle el número.',
    options: ['17', '18', '16', '34'],
    correctAnswer: 0,
    explanation: '2x + 5 = 39 -> 2x = 34 -> x = 17.',
  ),
  Question(
    id: 'rm_q272',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 23. Halle el número.',
    options: ['9', '10', '8', '18'],
    correctAnswer: 0,
    explanation: '2x + 5 = 23 -> 2x = 18 -> x = 9.',
  ),
  Question(
    id: 'rm_q273',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 39. Halle el número.',
    options: ['17', '18', '16', '34'],
    correctAnswer: 0,
    explanation: '2x + 5 = 39 -> 2x = 34 -> x = 17.',
  ),
  Question(
    id: 'rm_q274',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 37. Halle el número.',
    options: ['16', '17', '15', '32'],
    correctAnswer: 0,
    explanation: '2x + 5 = 37 -> 2x = 32 -> x = 16.',
  ),
  Question(
    id: 'rm_q275',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 25. Halle el número.',
    options: ['10', '11', '9', '20'],
    correctAnswer: 0,
    explanation: '2x + 5 = 25 -> 2x = 20 -> x = 10.',
  ),
  Question(
    id: 'rm_q276',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 43. Halle el número.',
    options: ['19', '20', '18', '38'],
    correctAnswer: 0,
    explanation: '2x + 5 = 43 -> 2x = 38 -> x = 19.',
  ),
  Question(
    id: 'rm_q277',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 27. Halle el número.',
    options: ['11', '12', '10', '22'],
    correctAnswer: 0,
    explanation: '2x + 5 = 27 -> 2x = 22 -> x = 11.',
  ),
  Question(
    id: 'rm_q278',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 27. Halle el número.',
    options: ['11', '12', '10', '22'],
    correctAnswer: 0,
    explanation: '2x + 5 = 27 -> 2x = 22 -> x = 11.',
  ),
  Question(
    id: 'rm_q279',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 17. Halle el número.',
    options: ['6', '7', '5', '12'],
    correctAnswer: 0,
    explanation: '2x + 5 = 17 -> 2x = 12 -> x = 6.',
  ),
  Question(
    id: 'rm_q280',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 33. Halle el número.',
    options: ['14', '15', '13', '28'],
    correctAnswer: 0,
    explanation: '2x + 5 = 33 -> 2x = 28 -> x = 14.',
  ),
  Question(
    id: 'rm_q281',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 23. Halle el número.',
    options: ['9', '10', '8', '18'],
    correctAnswer: 0,
    explanation: '2x + 5 = 23 -> 2x = 18 -> x = 9.',
  ),
  Question(
    id: 'rm_q282',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 19. Halle el número.',
    options: ['7', '8', '6', '14'],
    correctAnswer: 0,
    explanation: '2x + 5 = 19 -> 2x = 14 -> x = 7.',
  ),
  Question(
    id: 'rm_q283',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 33. Halle el número.',
    options: ['14', '15', '13', '28'],
    correctAnswer: 0,
    explanation: '2x + 5 = 33 -> 2x = 28 -> x = 14.',
  ),
  Question(
    id: 'rm_q284',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 39. Halle el número.',
    options: ['17', '18', '16', '34'],
    correctAnswer: 0,
    explanation: '2x + 5 = 39 -> 2x = 34 -> x = 17.',
  ),
  Question(
    id: 'rm_q285',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 23. Halle el número.',
    options: ['9', '10', '8', '18'],
    correctAnswer: 0,
    explanation: '2x + 5 = 23 -> 2x = 18 -> x = 9.',
  ),
  Question(
    id: 'rm_q286',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 21. Halle el número.',
    options: ['8', '9', '7', '16'],
    correctAnswer: 0,
    explanation: '2x + 5 = 21 -> 2x = 16 -> x = 8.',
  ),
  Question(
    id: 'rm_q287',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 23. Halle el número.',
    options: ['9', '10', '8', '18'],
    correctAnswer: 0,
    explanation: '2x + 5 = 23 -> 2x = 18 -> x = 9.',
  ),
  Question(
    id: 'rm_q288',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 15. Halle el número.',
    options: ['5', '6', '4', '10'],
    correctAnswer: 0,
    explanation: '2x + 5 = 15 -> 2x = 10 -> x = 5.',
  ),
  Question(
    id: 'rm_q289',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 37. Halle el número.',
    options: ['16', '17', '15', '32'],
    correctAnswer: 0,
    explanation: '2x + 5 = 37 -> 2x = 32 -> x = 16.',
  ),
  Question(
    id: 'rm_q290',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 17. Halle el número.',
    options: ['6', '7', '5', '12'],
    correctAnswer: 0,
    explanation: '2x + 5 = 17 -> 2x = 12 -> x = 6.',
  ),
  Question(
    id: 'rm_q291',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 15. Halle el número.',
    options: ['5', '6', '4', '10'],
    correctAnswer: 0,
    explanation: '2x + 5 = 15 -> 2x = 10 -> x = 5.',
  ),
  Question(
    id: 'rm_q292',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 33. Halle el número.',
    options: ['14', '15', '13', '28'],
    correctAnswer: 0,
    explanation: '2x + 5 = 33 -> 2x = 28 -> x = 14.',
  ),
  Question(
    id: 'rm_q293',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 25. Halle el número.',
    options: ['10', '11', '9', '20'],
    correctAnswer: 0,
    explanation: '2x + 5 = 25 -> 2x = 20 -> x = 10.',
  ),
  Question(
    id: 'rm_q294',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 29. Halle el número.',
    options: ['12', '13', '11', '24'],
    correctAnswer: 0,
    explanation: '2x + 5 = 29 -> 2x = 24 -> x = 12.',
  ),
  Question(
    id: 'rm_q295',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 27. Halle el número.',
    options: ['11', '12', '10', '22'],
    correctAnswer: 0,
    explanation: '2x + 5 = 27 -> 2x = 22 -> x = 11.',
  ),
  Question(
    id: 'rm_q296',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 25. Halle el número.',
    options: ['10', '11', '9', '20'],
    correctAnswer: 0,
    explanation: '2x + 5 = 25 -> 2x = 20 -> x = 10.',
  ),
  Question(
    id: 'rm_q297',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 31. Halle el número.',
    options: ['13', '14', '12', '26'],
    correctAnswer: 0,
    explanation: '2x + 5 = 31 -> 2x = 26 -> x = 13.',
  ),
  Question(
    id: 'rm_q298',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 31. Halle el número.',
    options: ['13', '14', '12', '26'],
    correctAnswer: 0,
    explanation: '2x + 5 = 31 -> 2x = 26 -> x = 13.',
  ),
  Question(
    id: 'rm_q299',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 37. Halle el número.',
    options: ['16', '17', '15', '32'],
    correctAnswer: 0,
    explanation: '2x + 5 = 37 -> 2x = 32 -> x = 16.',
  ),
  Question(
    id: 'rm_q300',
    topicId: 'rm_ecuaciones',
    text:
        'FIJA PLANTEO: El doble de un número, aumentado en 5, es igual a 37. Halle el número.',
    options: ['16', '17', '15', '32'],
    correctAnswer: 0,
    explanation: '2x + 5 = 37 -> 2x = 32 -> x = 16.',
  ),
];

final Map<String, Topic> razonamientoMatematicoTopics = {
  'rm_sucesiones': Topic(
    id: 'rm_sucesiones',
    subjectId: 'rm',
    name: '1. Sucesiones numericas',
    description: 'Progresiones aritmeticas, geometricas y series compuestas.',
    questionCount: 71,
  ),
  'rm_edades': Topic(
    id: 'rm_edades',
    subjectId: 'rm',
    name: '2. Problemas de edades',
    description: 'Planteo de tiempos en el pasado, presente y futuro.',
    questionCount: 57,
  ),
  'rm_fracciones': Topic(
    id: 'rm_fracciones',
    subjectId: 'rm',
    name: '3. Fracciones y porcentajes',
    description: 'Problemas de mezclas, descuentos y variaciones porcentuales.',
    questionCount: 55,
  ),
  'rm_ecuaciones': Topic(
    id: 'rm_ecuaciones',
    subjectId: 'rm',
    name: '4. Planteo de ecuaciones',
    description:
        'Problemas generales, razonamiento logico y metodos operativos.',
    questionCount: 117,
  ),
};
