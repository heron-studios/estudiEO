# 🎓 EstudiEO Flutter - Guía Completa en Español

## 📱 ¿Qué Hemos Creado?

Tu programa **EstudiEO** de React ha sido **transformado completamente a Flutter** con:

- **7 Asignaturas educativas** (Matemáticas, Comunicación, Sociales, CTA, PFRH, Razonamiento)
- **28 Temas** con cientos de preguntas
- **Sistema SRS adaptativo** (repetición espaciada)
- **Gamificación completa** (XP, niveles, logros, racha diaria)
- **Almacenamiento local** (sin internet necesario)
- **8 Pantallas** con interfaz profesional

---

## 🚀 Pasos para Ejecutar

### Paso 1: Abre Terminal/PowerShell

```powershell
# En Windows, abre PowerShell y navega:
cd c:\Users\PC\Downloads\EstudiEO-flutter
```

### Paso 2: Descarga Dependencias

```powershell
flutter pub get
```

Este comando descargará automáticamente:
- Provider (gestión de estado)
- GetStorage (almacenamiento local)
- UUID, intl, y más

### Paso 3: Ejecuta la App

```powershell
flutter run
```

La app se abrirá en tu emulador o dispositivo. 🎉

---

## 💿 Compilar para Android (APK)

Si quieres compartir la app o instalarla en tu teléfono:

```powershell
flutter build apk --release
```

Luego encontrarás el archivo en:
```
c:\Users\PC\Downloads\EstudiEO-flutter\build\app\outputs\flutter-apk\app-release.apk
```

Puedes transferir este archivo a tu Android y hacer tap para instalar.

---

## 🍎 Compilar para iOS

Si tienes una Mac:

```powershell
flutter build ios --release
```

---

## 📖 ¿Cómo Funciona la App?

### Pantalla Inicial
Aquí ves:
- Tu nivel actual
- Puntos XP
- Racha de estudio
- Botones para comenzar

### Ver Asignaturas (📚)
7 opciones educativas:
1. **Matemáticas** 🔢
2. **Comunicación** 💬
3. **Ciencias Sociales** 🌍
4. **CTA** 🔬
5. **PFRH** 👥
6. **Razonamiento Verbal** 🔤
7. **Razonamiento Matemático** 🧮

### Seleccionar Tema
Cada asignatura tiene 4 temas con múltiples preguntas.

### Configurar Quiz
Elige cuántas preguntas quieres responder (1-20).

### Responder Preguntas
- 4 opciones por pregunta
- Explicación después de responder
- Automáticamente calcula tu progreso

### Ver Resultados
- Porcentaje de acierto
- Tiempo dedicado
- Análisis detallado

### Revisión SRS (🔄)
Revisa solo las preguntas que necesitas repasar según el algoritmo.

### Mi Progreso (📊)
Ve todas tus estadísticas:
- Preguntas estudiadas
- Progreso por tema
- Logros desbloqueados

---

## 💾 ¿Dónde Se Guardan los Datos?

**IMPORTANTE:** Todo se guarda **automáticamente en tu teléfono**, NO en internet.

Datos guardados:
- Tu progreso en cada pregunta
- Tu nivel y XP
- Tu racha de estudio
- Historial completo de quizzes
- Logros desbloqueados

**Ventajas:**
✅ Funciona sin internet
✅ Datos privados
✅ Rápido y seguro

---

## 🎯 Sistema de Puntos

### Cómo Ganar XP
- Respuesta correcta en quiz: **+10 XP**
- Respuesta correcta en SRS: **+15 XP**
- Respuesta incorrecta: **0 XP**

### Subir de Nivel
- Nivel 1: 0 XP
- Nivel 2: 100 XP
- Nivel 3: 200 XP
- Nivel 4: 300 XP
- Y así sucesivamente...

### Racha
- Se incrementa cada día que estudies
- Máximo de 1 actividad por día
- Se reinicia si pasan 24 horas sin estudiar
- Motiva a mantener consistencia

---

## 📚 Sistema SRS Explicado

SRS = Sistema de Repetición Espaciada

**¿Cómo funciona?**

1. **Primera vez que ves una pregunta:** Estado "Nueva"
2. **La respondes correctamente:** 
   - Si es la 1ª vez correcta → revisar en 1 día
   - Si es la 2ª vez → revisar en 3 días
   - Si es la 3ª+ → revisar en intervalos más largos

3. **La respondes incorrectamente:**
   - Vuelve a "Nueva"
   - Tendrás que aprenderla de nuevo

4. **Cuando está "Dominada":**
   - 21+ días entre revisiones
   - 5+ repeticiones correctas
   - Aparecerá raramente en futuras revisiones

---

## 🎮 Cómo Jugar Optimalmente

### Estrategia Recomendada
1. **Haz quizzes pequeños** (5-10 preguntas) regularmente
2. **Haz revisión SRS diaria** (toma 5-10 minutos)
3. **Revisa temas que necesites mejorar** (bajo porcentaje)
4. **Mantén tu racha** (1 sesión mínima diaria)

### Tiempo Recomendado
- Quiz pequeño: 5-10 minutos
- Revisión SRS: 5-15 minutos
- Sesión completa: 20-30 minutos

---

## ❓ Preguntas Frecuentes

### P: ¿Funciona sin internet?
**R:** Sí, 100% offline. Todo está en tu teléfono.

### P: ¿Puedo perder mis datos?
**R:** Los datos se guardan automáticamente. Solo se pierden si desinstales la app sin hacer backup.

### P: ¿Cuántas preguntas hay?
**R:** 65+ preguntas de ejemplo. Puedes agregar más.

### P: ¿Puedo sincronizar con múltiples dispositivos?
**R:** Actualmente está offline. Puedes agregar sincronización a Firebase después.

### P: ¿Puedo cambiar las preguntas?
**R:** Sí, están en `lib/data/subject_data_*.dart`

### P: ¿Es compatible con iPhone?
**R:** Sí, puedes compilar para iOS.

### P: ¿Cómo hago backup?
**R:** Actualmente, los datos están locales. Deberías hacer backup regular del dispositivo.

---

## 🔧 Solución de Problemas

### Error: "Flutter no se encuentra"
**Solución:** Flutter no está en el PATH. Descarga Flutter e agrégalo al PATH.

### Error: "Dependencias no encontradas"
```powershell
flutter pub get
flutter pub upgrade
```

### La app se congela
```powershell
flutter clean
flutter run
```

### No funciona en emulador
1. Abre Android Studio
2. Lanza un emulador
3. Ejecuta `flutter run`

### No puedo instalar APK en teléfono
1. Activa instalación de apps desconocidas
2. Ve a Configuración → Seguridad → Apps desconocidas
3. Permite instalación desde "Mis archivos"
4. Toca el APK

---

## 📝 Agregar Nuevas Preguntas

1. Abre `lib/data/subject_data_*.dart`
2. Agrega a la lista `final List<Question> = [`
3. Ejemplo:
```dart
Question(
  id: 'mi_pregunta_001',
  topicId: 'tema_id',
  text: '¿Cuál es la respuesta?',
  options: ['Opción A', 'Opción B', 'Opción C', 'Opción D'],
  correctAnswer: 0,  // Índice de respuesta correcta
  explanation: 'La explicación aquí...',
),
```
4. Ejecuta `flutter run`

---

## 📊 Estructura de la App

```
EstudiEO-flutter/
├── lib/
│   ├── main.dart .................. Inicio de la app
│   │
│   ├── models/ .................... Estructuras de datos
│   │   ├── question.dart
│   │   ├── srs_card.dart
│   │   ├── gamification.dart
│   │   └── ...
│   │
│   ├── services/ .................. Lógica de negocio
│   │   ├── local_storage_service.dart (guarda datos)
│   │   └── srs_engine.dart (algoritmo inteligente)
│   │
│   ├── providers/ ................. Gestión de estado
│   │   ├── srs_provider.dart
│   │   ├── gamification_provider.dart
│   │   └── ...
│   │
│   ├── screens/ ................... Pantallas visibles
│   │   ├── home_screen.dart
│   │   ├── quiz_screen.dart
│   │   ├── dashboard_screen.dart
│   │   └── ...
│   │
│   └── data/ ...................... Base de preguntas
│       ├── subject_data_*.dart
│       └── subjects_repository.dart
│
└── pubspec.yaml ................... Dependencias
```

---

## 🎓 Documentación Técnica

Para desarrolladores interesados en modificar el código:

1. **FLUTTER_README.md** - Documentación técnica completa
2. **QUICK_START.md** - Guía rápida técnica
3. **PROJECT_SUMMARY.md** - Resumen del proyecto

---

## 🚀 Próximos Pasos

### Opcionales (para mejorar)
- [ ] Agregar más preguntas
- [ ] Cambiar colores/tema
- [ ] Agregar sincronización a Firebase
- [ ] Crear diferentes perfiles de usuario
- [ ] Agregar audio para preguntas
- [ ] Crear secciones de teoría

### Para Producción
- [ ] Cambiar nombre de paquete
- [ ] Agregar iconos y splash screen
- [ ] Compilar versión oficial
- [ ] Publicar en App Store / Play Store

---

## 📞 Ayuda Rápida

| Problema | Comando |
|----------|---------|
| Borrar caché | `flutter clean` |
| Actualizar dependencias | `flutter pub upgrade` |
| Ver versión Flutter | `flutter --version` |
| Buscar problemas | `flutter doctor` |
| Ejecutar con logs | `flutter run -v` |

---

## ✅ Checklist para Empezar

- [ ] Descargué Flutter del sitio oficial
- [ ] Tengo Android Studio o Xcode instalado
- [ ] Abrí terminal en la carpeta del proyecto
- [ ] Ejecuté `flutter pub get`
- [ ] Ejecuté `flutter run` con éxito
- [ ] Puedo ver la pantalla de inicio
- [ ] Puedo hacer un quiz
- [ ] Veo mis puntos actualizarse
- [ ] Cierro y reabrí - los datos persisten

---

## 🎉 ¡Estás Listo!

Tu app educativa está **completamente funcional** y lista para:

✅ Estudiar con el sistema SRS
✅ Ganar puntos y subir de nivel
✅ Mantener una racha de estudio
✅ Trabajar completamente offline
✅ Compartir con amigos

**Disfruta tu plataforma educativa personalizada.** 📚🚀

---

**Hecho con ❤️ para EstudiEO**
*Última actualización: 2026*
