import json
with open('C:/Users/PC/Downloads/EstudiEO-flutter/assets/data/preguntas.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

qs = data.get('preguntas', data) if isinstance(data, dict) else data

new_qs = [
  {
    "id": 501,
    "texto": "Premisa 1: Ningún delincuente es honesto.\nPremisa 2: Juan es honesto.\n¿Cuál es la conclusión válida?",
    "opciones": {
      "A": "Juan es delincuente.",
      "B": "Juan no es delincuente.",
      "C": "Algunos honestos son delincuentes."
    },
    "puntos_opciones": { "A": 0, "B": 10, "C": 0 },
    "pista": "Si un grupo (delincuentes) no tiene relación con una característica (honestidad), cualquier persona que posea esa característica queda fuera del grupo. Es una exclusión lógica directa.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 502,
    "texto": "Premisa 1: Todos los policías son valientes.\nPremisa 2: Algunos ciudadanos son policías.\n¿Qué se concluye necesariamente?",
    "opciones": {
      "A": "Todos los ciudadanos son valientes.",
      "B": "Ningún ciudadano es valiente.",
      "C": "Algunos ciudadanos son valientes."
    },
    "puntos_opciones": { "A": 0, "B": 0, "C": 10 },
    "pista": "La característica del grupo total (valientes) se traslada a la parte del segundo grupo que pertenece al primero. Si algunos ciudadanos son policías, heredan la valentía atribuida a todos los policías.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 503,
    "texto": "Premisa 1: Todo buen oficial es disciplinado.\nPremisa 2: Luis no es disciplinado.\nPor lo tanto:",
    "opciones": {
      "A": "Luis es un buen oficial.",
      "B": "Luis no es un buen oficial.",
      "C": "Luis podría ser un buen oficial."
    },
    "puntos_opciones": { "A": 0, "B": 10, "C": 0 },
    "pista": "Se aplica la regla del 'Modus Tollens': si para ser A es requisito ser B, y no se es B, entonces no se puede ser A. Sin disciplina, no se cumple el requisito para ser un buen oficial.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 504,
    "texto": "Premisa 1: Ninguna garantía constitucional es injusta.\nPremisa 2: El Hábeas Corpus es una garantía constitucional.\nConclusión:",
    "opciones": {
      "A": "El Hábeas Corpus no es injusto.",
      "B": "El Hábeas Corpus es injusto.",
      "C": "Algunas injusticias son garantías."
    },
    "puntos_opciones": { "A": 10, "B": 0, "C": 0 },
    "pista": "Si el conjunto total de garantías tiene la propiedad de 'no ser injusto', cualquier elemento individual de ese conjunto (como el Hábeas Corpus) posee esa misma propiedad.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  },
  {
    "id": 505,
    "texto": "Premisa 1: Todos los homínidos del género Homo fabrican herramientas.\nPremisa 2: El Homo habilis es del género Homo.\n¿Cuál es la conclusión?",
    "opciones": {
      "A": "El Homo habilis no fabricó herramientas.",
      "B": "El Homo habilis fabricó herramientas.",
      "C": "Solo el Homo habilis fabricó herramientas."
    },
    "puntos_opciones": { "A": 0, "B": 10, "C": 0 },
    "pista": "Es una deducción clásica de lo general a lo particular. Si la capacidad de fabricar herramientas define al género Homo, el Habilis, al ser parte del género, cumple la regla.",
    "dimension": "Razonamiento Lógico",
    "sub_dimension": "Silogismos"
  }
]

qs.extend(new_qs)

with open('C:/Users/PC/Downloads/EstudiEO-flutter/assets/data/preguntas.json', 'w', encoding='utf-8') as f:
    json.dump({'preguntas': qs} if isinstance(data, dict) else qs, f, ensure_ascii=False, indent=2)

print('Appended', len(new_qs), 'questions')
