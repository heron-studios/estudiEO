import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:learn/models/quiz_session.dart';
import 'package:learn/models/question.dart';
import 'package:learn/data/repository/subjects_repository.dart';
import 'package:intl/intl.dart';
import 'package:learn/features/interview/domain/models/interview_question.dart';

class ExportService {
  // Helper to load Outfit or standard clean font
  static Future<pw.ThemeData> _getPdfTheme() async {
    try {
      final outfitRegular = await PdfGoogleFonts.outfitRegular();
      final outfitBold = await PdfGoogleFonts.outfitBold();
      return pw.ThemeData.withFont(
        base: outfitRegular,
        bold: outfitBold,
      );
    } catch (e) {
      // Fallback in case there is no internet connection for Google Fonts
      return pw.ThemeData();
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  //  1. QUIZ RESULTS EXPORT
  // ─────────────────────────────────────────────────────────────────────────────
  static Future<void> exportQuizToPdf(
    BuildContext context, 
    QuizSession session, 
    List<Question> questions,
  ) async {
    final pdfTheme = await _getPdfTheme();
    final pdf = pw.Document(theme: pdfTheme);
    final topic = SubjectsRepository.getTopic(session.topicId);
    final subject = topic != null ? SubjectsRepository.getSubject(topic.subjectId) : null;

    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(session.finishedAt ?? DateTime.now());
    final accuracy = session.percentage.toStringAsFixed(0);
    final durationStr = '${session.duration.inMinutes}m ${session.duration.inSeconds % 60}s';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('EDUPOL', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                      pw.Text('Reporte de Resultados de Quiz', style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.Text(dateStr, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500)),
                ],
              ),
            ),
            pw.SizedBox(height: 16),

            // Metadata block
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: const pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Asignatura: ${subject?.name ?? "General"}', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      pw.Text('Tema: ${topic?.name ?? "Varios"}', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Precisión: $accuracy%', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: session.percentage >= 60 ? PdfColors.green700 : PdfColors.orange700)),
                      pw.Text('Correctas: ${session.correctCount} / ${session.totalQuestions}', style: const pw.TextStyle(fontSize: 11)),
                      pw.Text('Tiempo: $durationStr', style: const pw.TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 24),

            pw.Text('Preguntas Respondidas:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
            pw.SizedBox(height: 12),

            // Questions list
            ...List.generate(questions.length, (idx) {
              final q = questions[idx];
              final userAnswerIdx = session.answers[q.id];
              final isCorrect = session.correctness[q.id] ?? false;

              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 16),
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border(left: pw.BorderSide(color: isCorrect ? PdfColors.green500 : PdfColors.red500, width: 4)),
                  color: PdfColors.grey50,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Pregunta ${idx + 1}: ${q.text}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                    pw.SizedBox(height: 6),
                    ...List.generate(q.options.length, (optIdx) {
                      final isSelected = userAnswerIdx == optIdx;
                      final isAnsCorrect = q.correctAnswer == optIdx;
                      
                      pw.TextStyle textStyle = const pw.TextStyle(fontSize: 10);
                      if (isSelected) {
                        textStyle = pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: isCorrect ? PdfColors.green700 : PdfColors.red700);
                      } else if (isAnsCorrect) {
                        textStyle = pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.green700);
                      }

                      return pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(isSelected ? '-> ' : '   ', style: textStyle),
                          pw.Text('${String.fromCharCode(65 + optIdx)}) ', style: textStyle),
                          pw.Expanded(child: pw.Text(q.options[optIdx], style: textStyle)),
                        ],
                      );
                    }),
                    pw.SizedBox(height: 6),
                    pw.Row(
                      children: [
                        pw.Text('Resultado: ', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                        pw.Text(isCorrect ? 'CORRECTO' : 'INCORRECTO', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: isCorrect ? PdfColors.green700 : PdfColors.red700)),
                      ],
                    ),
                    if (q.explanation.isNotEmpty) ...[
                      pw.SizedBox(height: 4),
                      pw.Text('Explicación: ${q.explanation}', style: pw.TextStyle(fontSize: 9, fontStyle: pw.FontStyle.italic, color: PdfColors.grey600)),
                    ]
                  ],
                ),
              );
            }),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Quiz_${topic?.name ?? "Resultados"}.pdf',
    );
  }

  static Future<void> exportQuizToWord(
    BuildContext context,
    QuizSession session,
    List<Question> questions,
  ) async {
    final topic = SubjectsRepository.getTopic(session.topicId);
    final subject = topic != null ? SubjectsRepository.getSubject(topic.subjectId) : null;
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(session.finishedAt ?? DateTime.now());
    final accuracy = session.percentage.toStringAsFixed(0);
    final durationStr = '${session.duration.inMinutes}m ${session.duration.inSeconds % 60}s';

    final buffer = StringBuffer();
    buffer.write('''
<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>
<head>
<meta charset="utf-8">
<title>EDUPOL - Resultados de Quiz</title>
<style>
  body { font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #333333; padding: 20px; }
  .header { border-bottom: 2px solid #1e3a8a; padding-bottom: 10px; margin-bottom: 20px; }
  .title { color: #1e3a8a; font-size: 24px; font-weight: bold; margin: 0; }
  .subtitle { color: #4b5563; font-size: 14px; margin: 5px 0 0 0; }
  .meta-box { background-color: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px; padding: 15px; margin-bottom: 25px; }
  .meta-row { display: table; width: 100%; margin-bottom: 5px; }
  .meta-cell { display: table-cell; width: 50%; font-size: 13px; }
  .question-container { border-left: 4px solid #3b82f6; background-color: #f9fafb; padding: 15px; margin-bottom: 20px; border-radius: 0 8px 8px 0; }
  .question-text { font-weight: bold; font-size: 14px; color: #111827; margin-bottom: 10px; }
  .option { font-size: 13px; margin-bottom: 5px; padding-left: 15px; }
  .correct { color: #16a34a; font-weight: bold; }
  .incorrect { color: #dc2626; font-weight: bold; }
  .selected { background-color: #fef08a; }
  .explanation { font-size: 12px; color: #4b5563; font-style: italic; margin-top: 10px; padding: 8px; background-color: #f3f4f6; border-radius: 4px; }
</style>
</head>
<body>
  <div class="header">
    <h1 class="title">EDUPOL</h1>
    <p class="subtitle">Reporte de Resultados de Quiz - Generado el $dateStr</p>
  </div>

  <div class="meta-box">
    <div class="meta-row">
      <div class="meta-cell"><strong>Asignatura:</strong> ${subject?.name ?? "General"}</div>
      <div class="meta-cell"><strong>Tema:</strong> ${topic?.name ?? "Varios"}</div>
    </div>
    <div class="meta-row">
      <div class="meta-cell"><strong>Precisión:</strong> <span class="${session.percentage >= 60 ? 'correct' : 'incorrect'}">$accuracy%</span></div>
      <div class="meta-cell"><strong>Correctas:</strong> ${session.correctCount} / ${session.totalQuestions}</div>
    </div>
    <div class="meta-row">
      <div class="meta-cell"><strong>Tiempo total:</strong> $durationStr</div>
      <div class="meta-cell"></div>
    </div>
  </div>

  <h2>Detalle de Preguntas</h2>
''');

    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      final userAnswerIdx = session.answers[q.id];
      final isCorrect = session.correctness[q.id] ?? false;

      buffer.write('<div class="question-container" style="border-left-color: ${isCorrect ? '#22c55e' : '#ef4444'};">');
      buffer.write('<div class="question-text">Pregunta ${i + 1}: ${q.text}</div>');

      for (var o = 0; o < q.options.length; o++) {
        final optionText = q.options[o];
        final isSelected = userAnswerIdx == o;
        final isAnsCorrect = q.correctAnswer == o;

        String optionClass = 'option';
        String marker = '&nbsp;&nbsp;&nbsp;&nbsp;';
        if (isSelected) {
          optionClass += ' selected';
          marker = isCorrect ? '✔️ &nbsp;' : '❌ &nbsp;';
        } else if (isAnsCorrect) {
          marker = '✔️ &nbsp;';
        }

        String optionStyle = '';
        if (isAnsCorrect) {
          optionStyle = 'color: #16a34a; font-weight: bold;';
        } else if (isSelected && !isCorrect) {
          optionStyle = 'color: #dc2626; font-weight: bold;';
        }

        buffer.write('<div class="$optionClass" style="$optionStyle">$marker ${String.fromCharCode(65 + o)}) $optionText</div>');
      }

      buffer.write('<div style="margin-top: 8px; font-size: 11px;">');
      buffer.write('<strong>Resultado:</strong> <span class="${isCorrect ? 'correct' : 'incorrect'}">${isCorrect ? 'CORRECTO' : 'INCORRECTO'}</span>');
      buffer.write('</div>');

      if (q.explanation.isNotEmpty) {
        buffer.write('<div class="explanation"><strong>Explicación:</strong> ${q.explanation}</div>');
      }

      buffer.write('</div>');
    }

    buffer.write('</body></html>');

    final tempDir = await getTemporaryDirectory();
    final cleanTopicName = (topic?.name ?? 'Resultados').replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
    final file = File('${tempDir.path}/Quiz_$cleanTopicName.doc');
    await file.writeAsString(buffer.toString(), encoding: utf8);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Compartir reporte de resultados de quiz',
      ),
    );
  }


  // ─────────────────────────────────────────────────────────────────────────────
  //  2. INTERVIEW RESULTS EXPORT
  // ─────────────────────────────────────────────────────────────────────────────
  static Future<void> exportInterviewToPdf(
    BuildContext context,
    Map<InterviewQuestion, String> outcomes,
  ) async {
    final pdfTheme = await _getPdfTheme();
    final pdf = pw.Document(theme: pdfTheme);
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    int total = outcomes.length;
    int mastered = outcomes.values.where((v) => v == 'mastered').length;
    int timeouts = outcomes.values.where((v) => v == 'timeout').length;
    int skipped = outcomes.values.where((v) => v == 'skipped').length;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('EDUPOL', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                      pw.Text('Reporte de Simulador Táctico (Entrevista)', style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.Text(dateStr, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500)),
                ],
              ),
            ),
            pw.SizedBox(height: 16),

            // Stats row
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: const pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total: $total', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Dominadas: $mastered', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.green700)),
                  pw.Text('Sin Respuesta: $timeouts', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.red700)),
                  pw.Text('Saltadas: $skipped', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.orange700)),
                ],
              ),
            ),
            pw.SizedBox(height: 24),

            pw.Text('Detalle de Preguntas de Entrevista:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
            pw.SizedBox(height: 12),

            // Questions
            ...outcomes.entries.map((entry) {
              final q = entry.key;
              final outcome = entry.value;

              PdfColor borderColor = PdfColors.blue500;
              String outcomeStr = 'Saltada';
              if (outcome == 'mastered') {
                borderColor = PdfColors.green500;
                outcomeStr = 'Dominada';
              } else if (outcome == 'timeout') {
                borderColor = PdfColors.red500;
                outcomeStr = 'Sin Respuesta (Tiempo Expirado)';
              }

              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 16),
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border(left: pw.BorderSide(color: borderColor, width: 4)),
                  color: PdfColors.grey50,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Categoría: ${q.categoria.toUpperCase()}', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.blue700)),
                        pw.Text(outcomeStr, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: borderColor)),
                      ],
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(q.pregunta, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                    pw.SizedBox(height: 8),
                    pw.Text('Enfoque Táctico:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9, color: PdfColors.orange700)),
                    pw.Text(q.puntosClave, style: const pw.TextStyle(fontSize: 9)),
                    pw.SizedBox(height: 6),
                    pw.Text('Respuesta Ideal:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9, color: PdfColors.green700)),
                    pw.Text(q.respuestaIdeal, style: const pw.TextStyle(fontSize: 9)),
                  ],
                ),
              );
            }),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Resultados_Simulador_Táctico.pdf',
    );
  }

  static Future<void> exportInterviewToWord(
    BuildContext context,
    Map<InterviewQuestion, String> outcomes,
  ) async {
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    int total = outcomes.length;
    int mastered = outcomes.values.where((v) => v == 'mastered').length;
    int timeouts = outcomes.values.where((v) => v == 'timeout').length;
    int skipped = outcomes.values.where((v) => v == 'skipped').length;

    final buffer = StringBuffer();
    buffer.write('''
<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>
<head>
<meta charset="utf-8">
<title>EDUPOL - Resultados de Simulador Táctico</title>
<style>
  body { font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #333333; padding: 20px; }
  .header { border-bottom: 2px solid #1e3a8a; padding-bottom: 10px; margin-bottom: 20px; }
  .title { color: #1e3a8a; font-size: 24px; font-weight: bold; margin: 0; }
  .subtitle { color: #4b5563; font-size: 14px; margin: 5px 0 0 0; }
  .meta-box { background-color: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px; padding: 15px; margin-bottom: 25px; }
  .meta-row { display: table; width: 100%; margin-bottom: 5px; }
  .meta-cell { display: table-cell; width: 25%; font-size: 13px; }
  .question-container { border-left: 4px solid #3b82f6; background-color: #f9fafb; padding: 15px; margin-bottom: 20px; border-radius: 0 8px 8px 0; }
  .question-header { font-size: 11px; font-weight: bold; color: #2563eb; margin-bottom: 5px; }
  .question-text { font-weight: bold; font-size: 14px; color: #111827; margin-bottom: 10px; }
  .section-title { font-weight: bold; font-size: 12px; margin-top: 8px; margin-bottom: 2px; }
  .focus { color: #d97706; }
  .ideal { color: #16a34a; }
  .status { font-weight: bold; font-size: 12px; }
  .status-mastered { color: #16a34a; }
  .status-skipped { color: #d97706; }
  .status-timeout { color: #dc2626; }
</style>
</head>
<body>
  <div class="header">
    <h1 class="title">EDUPOL</h1>
    <p class="subtitle">Reporte de Simulador Táctico - Generado el $dateStr</p>
  </div>

  <div class="meta-box">
    <div class="meta-row">
      <div class="meta-cell"><strong>Total Preguntas:</strong> $total</div>
      <div class="meta-cell"><strong>Dominadas:</strong> $mastered</div>
      <div class="meta-cell"><strong>Sin Respuesta:</strong> $timeouts</div>
      <div class="meta-cell"><strong>Saltadas:</strong> $skipped</div>
    </div>
  </div>

  <h2>Detalle de Preguntas de Entrevista</h2>
''');

    for (var entry in outcomes.entries) {
      final q = entry.key;
      final outcome = entry.value;

      String outcomeStr = 'Saltada';
      String outcomeClass = 'status-skipped';
      String borderColor = '#3b82f6';

      if (outcome == 'mastered') {
        outcomeStr = 'Dominada';
        outcomeClass = 'status-mastered';
        borderColor = '#22c55e';
      } else if (outcome == 'timeout') {
        outcomeStr = 'Sin Respuesta (Tiempo Expirado)';
        outcomeClass = 'status-timeout';
        borderColor = '#ef4444';
      }

      buffer.write('<div class="question-container" style="border-left-color: $borderColor;">');
      buffer.write('<div class="question-header">Categoría: ${q.categoria.toUpperCase()} | Estado: <span class="$outcomeClass">$outcomeStr</span></div>');
      buffer.write('<div class="question-text">${q.pregunta}</div>');
      
      buffer.write('<div class="section-title focus">Enfoque Táctico:</div>');
      buffer.write('<div style="font-size: 13px;">${q.puntosClave}</div>');

      buffer.write('<div class="section-title ideal">Respuesta Ideal:</div>');
      buffer.write('<div style="font-size: 13px;">${q.respuestaIdeal}</div>');

      buffer.write('</div>');
    }

    buffer.write('</body></html>');

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/Resultados_Simulador_Tactivo.doc');
    await file.writeAsString(buffer.toString(), encoding: utf8);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Compartir reporte de simulador táctico',
      ),
    );
  }


  // ─────────────────────────────────────────────────────────────────────────────
  //  3. DASHBOARD PROGRESS EXPORT
  // ─────────────────────────────────────────────────────────────────────────────
  static Future<void> exportDashboardToPdf(
    BuildContext context, {
    required Map<String, dynamic> globalStats,
    required String tutorAdvice,
    required List<Map<String, dynamic>> subjectStats,
  }) async {
    final pdfTheme = await _getPdfTheme();
    final pdf = pw.Document(theme: pdfTheme);
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    final totalCards = globalStats['total'] ?? 0;
    final nuevos = globalStats['new'] ?? 0;
    final aprendiendo = globalStats['learning'] ?? 0;
    final dominadas = globalStats['mastered'] ?? 0;
    final porRevisar = globalStats['overdue'] ?? 0;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('EDUPOL', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                      pw.Text('Reporte de Progreso de Estudiante', style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.Text(dateStr, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500)),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // SRS Section
            pw.Text('Repaso Espaciado (SRS)', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: const pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                children: [
                  _pdfStatRow('Total de tarjetas en memoria:', '$totalCards'),
                  _pdfStatRow('Tarjetas Nuevas:', '$nuevos'),
                  _pdfStatRow('Tarjetas en Aprendizaje:', '$aprendiendo'),
                  _pdfStatRow('Tarjetas Dominadas:', '$dominadas'),
                  _pdfStatRow('Tarjetas Pendientes de revisión:', '$porRevisar'),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // AI advice Section
            pw.Text('Consejo Personalizado del Tutor IA', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue50,
                border: pw.Border.all(color: PdfColors.blue200),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Text(
                tutorAdvice,
                style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic, color: PdfColors.blue900),
              ),
            ),
            pw.SizedBox(height: 20),

            // Subject Stats Section
            pw.Text('Rendimiento por Asignatura', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
            pw.SizedBox(height: 8),

            // Table of subjects
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.blue900),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text('Asignatura', style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text('Quizzes Realizados', style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text('Precisión Promedio', style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    ),
                  ],
                ),
                ...subjectStats.map((s) {
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('${s['icon']} ${s['name']}', style: const pw.TextStyle(fontSize: 10)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('${s['totalSessions']}', style: const pw.TextStyle(fontSize: 10)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('${(s['averagePercentage'] as double).toStringAsFixed(1)}%', style: const pw.TextStyle(fontSize: 10)),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Reporte_Progreso_EDUPOL.pdf',
    );
  }

  static pw.Widget _pdfStatRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 10)),
          pw.Text(value, style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  static Future<void> exportDashboardToWord(
    BuildContext context, {
    required Map<String, dynamic> globalStats,
    required String tutorAdvice,
    required List<Map<String, dynamic>> subjectStats,
  }) async {
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    final totalCards = globalStats['total'] ?? 0;
    final nuevos = globalStats['new'] ?? 0;
    final aprendiendo = globalStats['learning'] ?? 0;
    final dominadas = globalStats['mastered'] ?? 0;
    final porRevisar = globalStats['overdue'] ?? 0;

    final buffer = StringBuffer();
    buffer.write('''
<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>
<head>
<meta charset="utf-8">
<title>EDUPOL - Reporte de Progreso</title>
<style>
  body { font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #333333; padding: 20px; }
  .header { border-bottom: 2px solid #1e3a8a; padding-bottom: 10px; margin-bottom: 20px; }
  .title { color: #1e3a8a; font-size: 24px; font-weight: bold; margin: 0; }
  .subtitle { color: #4b5563; font-size: 14px; margin: 5px 0 0 0; }
  .section-title { color: #1e3a8a; font-size: 18px; font-weight: bold; margin-top: 25px; margin-bottom: 10px; border-bottom: 1px solid #bfdbfe; padding-bottom: 5px; }
  .stats-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
  .stats-table th, .stats-table td { border: 1px solid #e2e8f0; padding: 10px; text-align: left; font-size: 13px; }
  .stats-table th { background-color: #1e3a8a; color: white; }
  .advice-box { background-color: #eff6ff; border-left: 4px solid #3b82f6; border-radius: 4px; padding: 15px; font-style: italic; font-size: 13px; color: #1e40af; margin-top: 10px; }
  .srs-box { background-color: #f9fafb; border: 1px solid #e5e7eb; border-radius: 8px; padding: 15px; font-size: 13px; }
  .srs-row { display: table; width: 100%; margin-bottom: 8px; }
  .srs-label { display: table-cell; width: 70%; }
  .srs-value { display: table-cell; width: 30%; font-weight: bold; text-align: right; }
</style>
</head>
<body>
  <div class="header">
    <h1 class="title">EDUPOL</h1>
    <p class="subtitle">Reporte de Progreso del Estudiante - Generado el $dateStr</p>
  </div>

  <div class="section-title">Repaso Espaciado (SRS)</div>
  <div class="srs-box">
    <div class="srs-row">
      <div class="srs-label">Total de tarjetas en memoria:</div>
      <div class="srs-value">$totalCards</div>
    </div>
    <div class="srs-row">
      <div class="srs-label">Tarjetas Nuevas:</div>
      <div class="srs-value">$nuevos</div>
    </div>
    <div class="srs-row">
      <div class="srs-label">Tarjetas en Aprendizaje:</div>
      <div class="srs-value">$aprendiendo</div>
    </div>
    <div class="srs-row">
      <div class="srs-label">Tarjetas Dominadas:</div>
      <div class="srs-value">$dominadas</div>
    </div>
    <div class="srs-row">
      <div class="srs-label">Tarjetas Pendientes de revisión (Overdue):</div>
      <div class="srs-value">$porRevisar</div>
    </div>
  </div>

  <div class="section-title">Consejo Personalizado del Tutor IA</div>
  <div class="advice-box">
    $tutorAdvice
  </div>

  <div class="section-title">Rendimiento por Asignatura</div>
  <table class="stats-table">
    <thead>
      <tr>
        <th>Asignatura</th>
        <th>Quizzes Realizados</th>
        <th>Precisión Promedio</th>
      </tr>
    </thead>
    <tbody>
''');

    for (var s in subjectStats) {
      buffer.write('''
      <tr>
        <td>${s['icon']} ${s['name']}</td>
        <td>${s['totalSessions']}</td>
        <td><strong>${(s['averagePercentage'] as double).toStringAsFixed(1)}%</strong></td>
      </tr>
''');
    }

    buffer.write('''
    </tbody>
  </table>
</body>
</html>
''');

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/Reporte_Progreso_EDUPOL.doc');
    await file.writeAsString(buffer.toString(), encoding: utf8);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Compartir reporte de progreso de EDUPOL',
      ),
    );
  }


  // ─────────────────────────────────────────────────────────────────────────────
  //  4. EXAM SIMULACRO RESULTS EXPORT
  // ─────────────────────────────────────────────────────────────────────────────
  static Future<void> exportExamToPdf(
    BuildContext context, {
    required int score,
    required int total,
    required int timeSpent,
    required List<Question> questions,
    required Map<String, int> answers,
  }) async {
    final pdfTheme = await _getPdfTheme();
    final pdf = pw.Document(theme: pdfTheme);
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    final percentage = (score / total) * 100;
    
    final h = timeSpent ~/ 3600;
    final m = (timeSpent % 3600) ~/ 60;
    final s = timeSpent % 60;
    String timeStr = '${h > 0 ? "${h}h " : ""}${m > 0 ? "${m}m " : ""}${s}s';

    PdfColor pdfColor = PdfColors.green500;
    String feedback = '¡Excelente trabajo!';
    if (percentage < 60) {
      pdfColor = PdfColors.red500;
      feedback = 'Debes estudiar más';
    } else if (percentage < 80) {
      pdfColor = PdfColors.amber500;
      feedback = 'Aprobado, pero puedes mejorar';
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('EDUPOL', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                      pw.Text('Reporte de Resultados de Simulacro de Examen', style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.Text(dateStr, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500)),
                ],
              ),
            ),
            pw.SizedBox(height: 16),

            // Score Summary card
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: const pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Puntaje: $score de $total (${percentage.toStringAsFixed(0)}%)', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: pdfColor)),
                      pw.Text(feedback, style: pw.TextStyle(fontSize: 11, fontStyle: pw.FontStyle.italic, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.Text('Tiempo Utilizado: $timeStr', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                ],
              ),
            ),
            pw.SizedBox(height: 24),

            if (questions.isNotEmpty) ...[
              pw.Text('Detalle de Preguntas del Simulacro:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
              pw.SizedBox(height: 12),

              ...List.generate(questions.length, (idx) {
                final q = questions[idx];
                final userAnswerIdx = answers[q.id];
                final isCorrect = userAnswerIdx == q.correctAnswer;

                return pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 16),
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(left: pw.BorderSide(color: isCorrect ? PdfColors.green500 : PdfColors.red500, width: 4)),
                    color: PdfColors.grey50,
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Pregunta ${idx + 1}: ${q.text}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                      pw.SizedBox(height: 6),
                      ...List.generate(q.options.length, (optIdx) {
                        final isSelected = userAnswerIdx == optIdx;
                        final isAnsCorrect = q.correctAnswer == optIdx;
                        
                        pw.TextStyle textStyle = const pw.TextStyle(fontSize: 10);
                        if (isSelected) {
                          textStyle = pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: isCorrect ? PdfColors.green700 : PdfColors.red700);
                        } else if (isAnsCorrect) {
                          textStyle = pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.green700);
                        }

                        return pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(isSelected ? '-> ' : '   ', style: textStyle),
                            pw.Text('${String.fromCharCode(65 + optIdx)}) ', style: textStyle),
                            pw.Expanded(child: pw.Text(q.options[optIdx], style: textStyle)),
                          ],
                        );
                      }),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Text('Resultado: ', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                          pw.Text(isCorrect ? 'CORRECTO' : 'INCORRECTO', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: isCorrect ? PdfColors.green700 : PdfColors.red700)),
                        ],
                      ),
                      if (q.explanation.isNotEmpty) ...[
                        pw.SizedBox(height: 4),
                        pw.Text('Explicación: ${q.explanation}', style: pw.TextStyle(fontSize: 9, fontStyle: pw.FontStyle.italic, color: PdfColors.grey600)),
                      ]
                    ],
                  ),
                );
              }),
            ]
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Resultados_Simulacro.pdf',
    );
  }

  static Future<void> exportExamToWord(
    BuildContext context, {
    required int score,
    required int total,
    required int timeSpent,
    required List<Question> questions,
    required Map<String, int> answers,
  }) async {
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    final percentage = (score / total) * 100;
    
    final h = timeSpent ~/ 3600;
    final m = (timeSpent % 3600) ~/ 60;
    final s = timeSpent % 60;
    String timeStr = '${h > 0 ? "${h}h " : ""}${m > 0 ? "${m}m " : ""}${s}s';

    String scoreColorHex = '#16a34a';
    String feedback = '¡Excelente trabajo!';
    if (percentage < 60) {
      scoreColorHex = '#dc2626';
      feedback = 'Debes estudiar más';
    } else if (percentage < 80) {
      scoreColorHex = '#d97706';
      feedback = 'Aprobado, pero puedes mejorar';
    }

    final buffer = StringBuffer();
    buffer.write('''
<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>
<head>
<meta charset="utf-8">
<title>EDUPOL - Resultados de Simulacro</title>
<style>
  body { font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #333333; padding: 20px; }
  .header { border-bottom: 2px solid #1e3a8a; padding-bottom: 10px; margin-bottom: 20px; }
  .title { color: #1e3a8a; font-size: 24px; font-weight: bold; margin: 0; }
  .subtitle { color: #4b5563; font-size: 14px; margin: 5px 0 0 0; }
  .meta-box { background-color: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px; padding: 15px; margin-bottom: 25px; }
  .meta-row { display: table; width: 100%; margin-bottom: 5px; }
  .meta-cell { display: table-cell; width: 33%; font-size: 13px; }
  .question-container { border-left: 4px solid #3b82f6; background-color: #f9fafb; padding: 15px; margin-bottom: 20px; border-radius: 0 8px 8px 0; }
  .question-text { font-weight: bold; font-size: 14px; color: #111827; margin-bottom: 10px; }
  .option { font-size: 13px; margin-bottom: 5px; padding-left: 15px; }
  .correct { color: #16a34a; font-weight: bold; }
  .incorrect { color: #dc2626; font-weight: bold; }
  .selected { background-color: #fef08a; }
  .explanation { font-size: 12px; color: #4b5563; font-style: italic; margin-top: 10px; padding: 8px; background-color: #f3f4f6; border-radius: 4px; }
</style>
</head>
<body>
  <div class="header">
    <h1 class="title">EDUPOL</h1>
    <p class="subtitle">Reporte de Simulacro de Examen - Generado el $dateStr</p>
  </div>

  <div class="meta-box">
    <div class="meta-row">
      <div class="meta-cell"><strong>Puntaje:</strong> <span style="color: $scoreColorHex; font-weight: bold;">$score de $total (${percentage.toStringAsFixed(0)}%)</span></div>
      <div class="meta-cell"><strong>Resultado:</strong> $feedback</div>
      <div class="meta-cell"><strong>Tiempo Utilizado:</strong> $timeStr</div>
    </div>
  </div>

  <h2>Detalle de Preguntas de Examen</h2>
''');

    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      final userAnswerIdx = answers[q.id];
      final isCorrect = userAnswerIdx == q.correctAnswer;

      buffer.write('<div class="question-container" style="border-left-color: ${isCorrect ? '#22c55e' : '#ef4444'};">');
      buffer.write('<div class="question-text">Pregunta ${i + 1}: ${q.text}</div>');

      for (var o = 0; o < q.options.length; o++) {
        final optionText = q.options[o];
        final isSelected = userAnswerIdx == o;
        final isAnsCorrect = q.correctAnswer == o;

        String optionClass = 'option';
        String marker = '&nbsp;&nbsp;&nbsp;&nbsp;';
        if (isSelected) {
          optionClass += ' selected';
          marker = isCorrect ? '✔️ &nbsp;' : '❌ &nbsp;';
        } else if (isAnsCorrect) {
          marker = '✔️ &nbsp;';
        }

        String optionStyle = '';
        if (isAnsCorrect) {
          optionStyle = 'color: #16a34a; font-weight: bold;';
        } else if (isSelected && !isCorrect) {
          optionStyle = 'color: #dc2626; font-weight: bold;';
        }

        buffer.write('<div class="$optionClass" style="$optionStyle">$marker ${String.fromCharCode(65 + o)}) $optionText</div>');
      }

      buffer.write('<div style="margin-top: 8px; font-size: 11px;">');
      buffer.write('<strong>Resultado:</strong> <span class="${isCorrect ? 'correct' : 'incorrect'}">${isCorrect ? 'CORRECTO' : 'INCORRECTO'}</span>');
      buffer.write('</div>');

      if (q.explanation.isNotEmpty) {
        buffer.write('<div class="explanation"><strong>Explicación:</strong> ${q.explanation}</div>');
      }

      buffer.write('</div>');
    }

    buffer.write('</body></html>');

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/Resultados_Simulacro.doc');
    await file.writeAsString(buffer.toString(), encoding: utf8);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Compartir reporte de simulacro de examen',
      ),
    );
  }
}
