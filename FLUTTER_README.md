# EstudiEO - Plataforma de Estudio Flutter

## 📱 Descripción

**EstudiEO** es una plataforma educativa móvil desarrollada en Flutter con persistencia de datos local completa. Transforma el código original de React/Firebase a una aplicación nativa Flutter con todas las funcionalidades de:

- 📚 7 Asignaturas principales
- 🎯 Sistema de Repetición Espaciada (SRS)
- 🎮 Gamificación con niveles, XP y rachas
- 💾 Persistencia local con Hive
- 📊 Dashboard de progreso
- 📝 Quizzes interactivos

## 🏗️ Arquitectura

### Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada
├── models/                   # Modelos de datos
│   ├── question.dart        # Preguntas
│   ├── srs_card.dart        # Tarjetas SRS
│   ├── gamification.dart    # Datos de gamificación
│   ├── quiz_session.dart    # Sesiones de quiz
│   ├── topic.dart           # Temas
│   └── subject.dart         # Asignaturas
├── services/                # Servicios de negocio
│   ├── local_storage_service.dart  # Persistencia
│   └── srs_engine.dart      # Motor SRS
├── providers/               # State Management (Provider)
│   ├── srs_provider.dart
│   ├── gamification_provider.dart
│   ├── quiz_provider.dart
│   └── subject_provider.dart
├── screens/                 # Pantallas principales
│   ├── home_screen.dart
│   ├── subject_gallery_screen.dart
│   ├── topic_gallery_screen.dart
│   ├── quiz_config_screen.dart
│   ├── quiz_screen.dart
│   ├── quiz_results_screen.dart
│   ├── dashboard_screen.dart
│   └── srs_review_screen.dart
└── data/                    # Datos de preguntas
    ├── subjects_repository.dart    # Repositorio centralizado
    ├── subject_data_matematicas.dart
    ├── subject_data_comunicacion.dart
    ├── subject_data_sociales.dart
    ├── subject_data_cta.dart
    ├── subject_data_pfrh.dart
    └── subject_data_aptitud.dart
```

## 🔧 Tecnologías

- **Flutter 3.11+**: Framework
- **Provider 6.0+**: State Management
- **Hive 2.2+**: Persistencia local
- **UUID 4.0+**: Generación de IDs únicos

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  hive_flutter: ^1.1.0
  hive: ^2.2.3
  provider: ^6.1.0
  intl: ^0.19.0
  uuid: ^4.0.0
  flutter_markdown: ^0.6.14
```

## 🚀 Instalación

### 1. Obtener dependencias
```bash
flutter pub get
```

### 2. Ejecutar la app
```bash
flutter run
```

### 3. Compilar APK (Android)
```bash
flutter build apk --release
```

### 4. Compilar iOS
```bash
flutter build ios --release
```

## 📚 Asignaturas Disponibles

1. **Matemáticas** 🔢
   - Álgebra
   - Ángulos
   - Teorema de Pitágoras
   - Trigonometría Básica

2. **Comunicación** 💬
   - Ortografía
   - Narración
   - Análisis de Oración
   - Literatura

3. **Ciencias Sociales** 🌍
   - Historia
   - Geografía
   - Economía
   - Ciudadanía

4. **CTA (Ciencia, Tecnología, Ambiente)** 🔬
   - Biología
   - Química
   - Física
   - Ecología

5. **PFRH (Persona, Familia, Relaciones Humanas)** 👥
   - Identidad
   - Autoestima
   - Relaciones Interpersonales
   - Valores

6. **Razonamiento Verbal** 🔤
   - Sinónimos
   - Antónimos
   - Comprensión de Texto
   - Analogías

7. **Razonamiento Matemático** 🧮
   - Lógica
   - Series Numéricas
   - Operadores Matemáticos
   - Porcentajes

## 🎯 Características Principales

### Sistema SRS (Spaced Repetition System)
- Motor adaptativo basado en SM-2
- Cálculo automático de intervalos de revisión
- Ajuste dinámico del factor de facilidad
- Clasificación de tarjetas: Nuevas, Aprendiendo, Maduras, Dominadas

### Gamificación
- Sistema de niveles con XP
- Racha de estudio diaria
- Logros y badges
- Progreso visual por asignatura

### Persistencia Local
- Almacenamiento completo en Hive
- Sincronización de datos automática
- Backup de progreso
- Sin requiere conexión a internet

### Analytics
- Dashboard con estadísticas personales
- Seguimiento de progreso por tema
- Histórico de quizzes
- Reporte de desempeño

## 💡 Guía de Uso

### Empezar a Estudiar
1. Desde la pantalla de inicio, toca "Ver Asignaturas"
2. Selecciona una asignatura
3. Elige un tema específico
4. Configura la cantidad de preguntas
5. ¡Comienza el quiz!

### Revisión SRS
1. Desde el inicio, toca "Revisión SRS"
2. Responde las preguntas que aparezcan
3. El sistema automáticamente ajustará cuándo revisar cada pregunta

### Ver Progreso
1. Toca "Mi Progreso" desde el inicio
2. Consulta tus estadísticas SRS
3. Revisa el desempeño por asignatura
4. Mantén el registro de tus logros

## 🔄 Flujo de Datos

```
LocalStorageService (Hive)
    ↓
├─ SrsProvider (SrsEngine)
├─ GamificationProvider
├─ QuizProvider
└─ SubjectProvider
    ↓
    UI Screens
```

## 📊 Modelo de Datos SRS

Cada pregunta tiene una tarjeta SRS con:
- `questionId`: ID único
- `topicId`: Tema al que pertenece
- `easeFactor`: Factor de facilidad (1.3 - ∞)
- `interval`: Días hasta la próxima revisión
- `repetitions`: Número de repeticiones correctas
- `lastReviewed`: Última vez que fue revisada
- `nextReviewDate`: Próxima fecha de revisión
- `status`: Estado actual (new, learning, mature, mastered)

## 🎮 Sistema de Gamificación

### Niveles
- Basado en XP acumulado
- 100 XP por nivel
- Progreso visual en la pantalla de inicio

### Racha
- Se incrementa por actividad diaria
- Se reinicia si pasan más de 24 horas sin actividad
- Bonus de XP si mantienes racha

### Logros
- Se desbloquean al completar hitos
- Visible en el dashboard
- Motivación para continuar estudiando

## 🐛 Solución de Problemas

### La app no guarda datos
- Verifica que Hive esté inicializado en main.dart
- Comprueba permisos de almacenamiento

### Las preguntas no aparecen
- Verifica que SubjectsRepository esté correctamente importado
- Revisa que los datos estén en subject_data_*.dart

### Provider no actualiza UI
- Usa `Consumer` o `context.watch()` correctamente
- Verifica que `notifyListeners()` se llame después de cambios

## 📝 Agregar Nuevas Preguntas

1. Crea un archivo nuevo en `lib/data/subject_data_nueva.dart`
2. Define tu Subject con temas
3. Crea lista de Questions
4. Registra en SubjectsRepository

```dart
// Ejemplo
final List<Question> nuevasPreguntas = [
  Question(
    id: 'unica_001',
    topicId: 'tema_id',
    text: 'Tu pregunta aquí',
    options: ['Op1', 'Op2', 'Op3', 'Op4'],
    correctAnswer: 0,
    explanation: 'Explicación aquí',
  ),
];
```

## 🔐 Privacidad y Seguridad

- Todos los datos se guardan localmente
- No hay envío de datos a servidores externos
- Hive provee persistencia eficiente
- En Android, usa SharedPreferences con opciones de seguridad

## 📄 Licencia

Este proyecto es una transformación educativa del sistema original de EstudiEO.

## 👨‍💻 Desarrollador

Transformado a Flutter con arquitectura completa de persistencia local y SRS.

---

**¡Felicidades!** Ahora tienes una plataforma educativa completamente funcional en Flutter con todos los datos sincronizados localmente. 🎉
