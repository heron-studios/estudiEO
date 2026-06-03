import json

with open('C:/Users/PC/Downloads/EstudiEO-flutter/assets/data/silogismos.json', 'r', encoding='utf-8') as f:
    qs = json.load(f)

new_qs = [
  {
    "id": 6,
    "texto": "Premisa 1: Ningún planeta es plano.\nPremisa 2: La Tierra es un planeta.\n¿Cuál es la conclusión lógica?",
    "opciones": {
      "A": "La Tierra no es plana.",
      "B": "La Tierra es redonda.",
      "C": "Algunos planetas son planos."
    },
    "puntos_opciones": { "A": 10, "B": 0, "C": 0 },
    "pista": "Aplicación directa de un principio universal negativo. Si ningún elemento de la categoría posee una cualidad, sus miembros tampoco.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 7,
    "texto": "Premisa 1: Todos los cetáceos son mamíferos.\nPremisa 2: Ningún mamífero respira branquialmente.\nConclusión:",
    "opciones": {
      "A": "Los cetáceos respiran branquialmente.",
      "B": "Ningún cetáceo respira branquialmente.",
      "C": "Algunos cetáceos son peces."
    },
    "puntos_opciones": { "A": 0, "B": 10, "C": 0 },
    "pista": "Silogismo condicional encadenado. Si A pertenece a B, y B no puede tener C, entonces A no puede tener C.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 8,
    "texto": "Premisa 1: Algunos vehículos son eléctricos.\nPremisa 2: Todos los vehículos tienen ruedas.\n¿Qué podemos concluir?",
    "opciones": {
      "A": "Todos los eléctricos tienen ruedas.",
      "B": "Algunos vehículos eléctricos tienen ruedas.",
      "C": "Todo lo que tiene ruedas es un vehículo."
    },
    "puntos_opciones": { "A": 0, "B": 10, "C": 0 },
    "pista": "Cuando combinas 'algunos' con 'todos', la conclusión solo puede referirse al subgrupo compartido.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 9,
    "texto": "Premisa 1: Si llueve, el piso se moja.\nPremisa 2: El piso no está mojado.\nPor lo tanto:",
    "opciones": {
      "A": "Llovió pero se secó.",
      "B": "No llovió.",
      "C": "El piso es impermeable."
    },
    "puntos_opciones": { "A": 0, "B": 10, "C": 0 },
    "pista": "Modus Tollens: Si A implica B, la ausencia de B indica lógicamente la ausencia de A.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 10,
    "texto": "Premisa 1: Todo ave tiene plumas.\nPremisa 2: El pingüino tiene plumas.\nConclusión válida:",
    "opciones": {
      "A": "El pingüino es un ave.",
      "B": "Ninguna de las opciones es concluyente lógicamente.",
      "C": "Todos los animales con plumas son aves."
    },
    "puntos_opciones": { "A": 0, "B": 10, "C": 0 },
    "pista": "Falacia de afirmación del consecuente. Aunque en la realidad el pingüino es un ave, lógicamente solo con esas dos premisas no se puede afirmar que lo sea solo por tener plumas.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 11,
    "texto": "Premisa 1: Los metales son buenos conductores de calor.\nPremisa 2: La madera no es un metal.\nPor lo tanto:",
    "opciones": {
      "A": "La madera no es buena conductora de calor.",
      "B": "La madera no conduce calor.",
      "C": "No se puede concluir lógicamente nada de la madera."
    },
    "puntos_opciones": { "A": 0, "B": 0, "C": 10 },
    "pista": "Falacia de negación del antecedente. Que los metales sean buenos conductores no excluye que otras cosas también puedan serlo.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 12,
    "texto": "Premisa 1: Todo triángulo tiene 3 lados.\nPremisa 2: Esta figura no tiene 3 lados.\nConclusión:",
    "opciones": {
      "A": "Esta figura es un círculo.",
      "B": "Esta figura no es un triángulo.",
      "C": "Ninguna de las anteriores."
    },
    "puntos_opciones": { "A": 0, "B": 10, "C": 0 },
    "pista": "Si se niega la propiedad esencial y definitoria (tener 3 lados), se rechaza la pertenencia al grupo.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 13,
    "texto": "Premisa 1: Si estudias, aprobarás el examen.\nPremisa 2: Aprobaste el examen.\nConclusión:",
    "opciones": {
      "A": "Por lo tanto, estudiaste.",
      "B": "Estudiar fue inútil.",
      "C": "No se puede concluir que estudiaste lógicamente."
    },
    "puntos_opciones": { "A": 0, "B": 0, "C": 10 },
    "pista": "Nuevamente afirmación del consecuente. Podrías haber aprobado por otro motivo que no haya sido estudiar.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 14,
    "texto": "Premisa 1: Ningún mortal vive mil años.\nPremisa 2: Sócrates es mortal.\nPor lo tanto:",
    "opciones": {
      "A": "Sócrates no vivirá mil años.",
      "B": "Sócrates ya murió.",
      "C": "Algunos mortales mueren pronto."
    },
    "puntos_opciones": { "A": 10, "B": 0, "C": 0 },
    "pista": "Deducción silogística básica. La restricción del grupo entero recae directamente sobre el individuo.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 15,
    "texto": "Premisa 1: Algunos políticos son corruptos.\nPremisa 2: Pedro es político.\n¿Qué se concluye sobre Pedro?",
    "opciones": {
      "A": "Pedro es corrupto.",
      "B": "Pedro no es corrupto.",
      "C": "No se sabe si Pedro es corrupto."
    },
    "puntos_opciones": { "A": 0, "B": 0, "C": 10 },
    "pista": "La palabra 'Algunos' no permite abarcar a la totalidad. No hay garantías lógicas de que un individuo específico pertenezca a ese subgrupo.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  }
]

qs.extend(new_qs)

with open('C:/Users/PC/Downloads/EstudiEO-flutter/assets/data/silogismos.json', 'w', encoding='utf-8') as f:
    json.dump(qs, f, ensure_ascii=False, indent=2)

print('Added', len(new_qs), 'new syllogisms.')
