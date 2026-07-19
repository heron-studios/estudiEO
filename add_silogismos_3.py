import json

with open('C:/Users/PC/Downloads/EDUPOL-flutter/assets/data/silogismos.json', 'r', encoding='utf-8') as f:
    qs = json.load(f)

new_qs = [
  {
    "id": 1,
    "texto": "Premisa 1: Ningún policía negligente cumple con el autocuidado personal.\nPremisa 2: Algunos agentes han descuidado su salud física y mental.\n¿Qué se concluye necesariamente?",
    "opciones": {
      "A": "Todos los agentes son negligentes.",
      "B": "Algunos agentes están actuando con negligencia respecto a su autocuidado.",
      "C": "El autocuidado no es una función policial."
    },
    "respuesta_correcta": "B",
    "pista": "Cuando una premisa es particular ('Algunos'), la conclusión debe ser también particular. Si una parte del grupo no cumple con el autocuidado, esa parte encaja en la definición de negligencia dada en la primera premisa.",
    "dimension": "Psicométrico",
    "sub_dimension": "Personalidad y Autocuidado"
  },
  {
    "id": 2,
    "texto": "Premisa 1: Todos los sustantivos propios se escriben con mayúscula inicial.\nPremisa 2: 'Perú' es un sustantivo propio.\n¿Cuál es la conclusión lógica?",
    "opciones": {
      "A": "'Perú' se escribe con mayúscula inicial.",
      "B": "Algunos sustantivos como 'Perú' no requieren mayúscula.",
      "C": "La palabra 'Perú' es un adjetivo."
    },
    "respuesta_correcta": "A",
    "pista": "Deducción simple: si un elemento pertenece a un conjunto, hereda todas las propiedades universales de ese conjunto (identificación de categorías gramaticales).",
    "dimension": "Psicométrico",
    "sub_dimension": "Razonamiento Verbal"
  },
  {
    "id": 3,
    "texto": "Premisa 1: Ningún delfín es depredador.\nPremisa 2: Todos los tiburones son depredadores.\n¿Qué se puede concluir?",
    "opciones": {
      "A": "Algún tiburón es delfín.",
      "B": "Ningún delfín es tiburón.",
      "C": "Todos los depredadores son delfines."
    },
    "respuesta_correcta": "B",
    "pista": "Si dos grupos tienen características totalmente excluyentes (ser y no ser depredador), no pueden tener elementos en común. Por lo tanto, ningún miembro de uno pertenece al otro.",
    "dimension": "Psicométrico",
    "sub_dimension": "Lógica Categórica"
  },
  {
    "id": 4,
    "texto": "Premisa 1: Todos los hombres no son bellos.\n¿Cuál es la equivalencia lógica de esta proposición?",
    "opciones": {
      "A": "Algunos hombres son bellos.",
      "B": "Ningún hombre es bello.",
      "C": "No todos los hombres son bellos."
    },
    "respuesta_correcta": "B",
    "pista": "La estructura 'Todos los S no son P' es una forma clásica de expresar un juicio universal negativo, lo cual equivale a decir 'Ningún S es P'.",
    "dimension": "Psicométrico",
    "sub_dimension": "Equivalencias Lógicas"
  },
  {
    "id": 5,
    "texto": "Premisa 1: Cualquier persona es honesta.\nPremisa 2: Nunca un honesto es corrupto.\nDetermine la negación de la conclusión de estas premisas.",
    "opciones": {
      "A": "Algunas personas son corruptas.",
      "B": "Ninguna persona es corrupta.",
      "C": "Todos los honestos son personas."
    },
    "respuesta_correcta": "A",
    "pista": "La conclusión lógica es 'Ninguna persona es corrupta'. Para negar un juicio universal negativo (Ninguno), se debe usar un juicio particular afirmativo (Algunos sí).",
    "dimension": "Psicométrico",
    "sub_dimension": "Lógica y Negación"
  },
  {
    "id": 6,
    "texto": "Premisa 1: Todo buen oficial es asertivo.\nPremisa 2: Juan no es asertivo.\nPor lo tanto:",
    "opciones": {
      "A": "Juan es un oficial negligente.",
      "B": "Juan no es un buen oficial.",
      "C": "Juan debe mejorar su comunicación."
    },
    "respuesta_correcta": "B",
    "pista": "Se aplica el 'Modus Tollens': si A implica B, y no tenemos B, entonces no podemos tener A. Es fundamental para evaluar el perfil ideal del cadete.",
    "dimension": "Psicométrico",
    "sub_dimension": "Ética y Personalidad"
  },
  {
    "id": 7,
    "texto": "Premisa 1: Ninguna palabra aguda terminada en consonante distinta de 'N' o 'S' lleva tilde.\nPremisa 2: 'Reloj' es una palabra aguda que termina en 'J'.\n¿Cuál es la conclusión?",
    "opciones": {
      "A": "'Reloj' no lleva tilde.",
      "B": "'Reloj' debe tildarse por ser aguda.",
      "C": "La regla de tildación es subjetiva."
    },
    "respuesta_correcta": "A",
    "pista": "Silogismo aplicado a la ortografía RAE 2010. Al cumplir la condición de terminar en una consonante distinta a N/S, se confirma la ausencia de tilde.",
    "dimension": "Psicométrico",
    "sub_dimension": "Ortografía Normativa"
  },
  {
    "id": 8,
    "texto": "Premisa 1: Todos los homínidos que dominaron el fuego sobrevivieron al Pleistoceno.\nPremisa 2: El Homo erectus dominó el fuego.\n¿Qué se concluye?",
    "opciones": {
      "A": "El Homo erectus sobrevivió al Pleistoceno.",
      "B": "Solo el Homo erectus usaba fuego.",
      "C": "El Pleistoceno fue superado por todos los homínidos."
    },
    "respuesta_correcta": "A",
    "pista": "Deducción histórica: se traslada la propiedad del conjunto (supervivencia por fuego) al elemento específico (Homo erectus).",
    "dimension": "Psicométrico",
    "sub_dimension": "Razonamiento Histórico"
  },
  {
    "id": 9,
    "texto": "Premisa 1: Algunos senadores son irracionales.\n¿Cuál es la negación de esta proposición?",
    "opciones": {
      "A": "Todos los senadores son irracionales.",
      "B": "Ningún senador es irracional.",
      "C": "Algunos senadores son racionales."
    },
    "respuesta_correcta": "B",
    "pista": "Para negar un 'Algunos' (particular afirmativo), se requiere un 'Ninguno' (universal negativo). Es una regla fija en exámenes de admisión.",
    "dimension": "Psicométrico",
    "sub_dimension": "Lógica Formal"
  },
  {
    "id": 10,
    "texto": "Premisa 1: Todo acto de corrupción debilita a la PNP.\nPremisa 2: El cohecho es un acto de corrupción.\nConclusión:",
    "opciones": {
      "A": "El cohecho debilita a la PNP.",
      "B": "El cohecho es un error menor.",
      "C": "Solo los jueces cometen cohecho."
    },
    "respuesta_correcta": "A",
    "pista": "La inclusión de un término técnico (cohecho) dentro de una categoría general de falta ética permite deducir el impacto institucional negativo.",
    "dimension": "Psicométrico",
    "sub_dimension": "Valores y Deontología"
  }
]

start_id = 16
for q in new_qs:
    q['id'] = start_id
    start_id += 1
    # Translate respuesta_correcta to puntos_opciones
    ans = q.pop('respuesta_correcta')
    q['puntos_opciones'] = {k: 10 if k == ans else 0 for k in q['opciones']}
    qs.append(q)

with open('C:/Users/PC/Downloads/EDUPOL-flutter/assets/data/silogismos.json', 'w', encoding='utf-8') as f:
    json.dump(qs, f, ensure_ascii=False, indent=2)

print(f'Successfully added {len(new_qs)} new syllogisms.')
