// To run this script, use the command:
//dart run tools\generate_locale.dart





import 'dart:convert';
import 'dart:io';

void main() {
  // قراءة ملفات JSON
  final arFile = File('assets/translations/ar.json');
  final enFile = File('assets/translations/en.json');

  if (!arFile.existsSync() || !enFile.existsSync()) {
    print('❌ Error: Translation files not found!');
    return;
  }

  final arJson = json.decode(arFile.readAsStringSync()) as Map<String, dynamic>;
  final enJson = json.decode(enFile.readAsStringSync()) as Map<String, dynamic>;

  // التحقق من الـ keys
  _validateKeys(arJson, enJson);

  // استخدام الملف العربي كمرجع (أو الإنجليزي، حسب تفضيلك)
  final allKeys = <String>{};
  _extractKeys(arJson, allKeys, '');

  // إنشاء الـ class
  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// Generated from translation files');
  buffer.writeln('// Last generated: ${DateTime.now()}');
  buffer.writeln();
  buffer.writeln('class AppLocale {');
  buffer.writeln('  AppLocale._();');
  buffer.writeln();

  // إضافة كل key كـ static const
  final sortedKeys = allKeys.toList()..sort();
  for (final key in sortedKeys) {
    final fieldName = _generateFieldName(key);
    buffer.writeln("  static const String $fieldName = '$key';");
  }

  buffer.writeln('}');

  // كتابة الملف
  final outputFile = File('lib/core/app_locale/app_locale.dart');
  outputFile.createSync(recursive: true);
  outputFile.writeAsStringSync(buffer.toString());

  print('✅ AppLocale class generated successfully!');
  print('📝 Total keys: ${allKeys.length}');
}

// استخراج كل الـ keys (بما فيها الـ nested)
void _extractKeys(Map<String, dynamic> map, Set<String> keys, String prefix) {
  map.forEach((key, value) {
    final fullKey = prefix.isEmpty ? key : '$prefix.$key';
    
    if (value is Map<String, dynamic>) {
      _extractKeys(value, keys, fullKey);
    } else {
      keys.add(fullKey);
    }
  });
}

// التحقق من تطابق الـ keys بين الملفين
void _validateKeys(Map<String, dynamic> arJson, Map<String, dynamic> enJson) {
  final arKeys = <String>{};
  final enKeys = <String>{};

  _extractKeys(arJson, arKeys, '');
  _extractKeys(enJson, enKeys, '');

  final missingInEn = arKeys.difference(enKeys);
  final missingInAr = enKeys.difference(arKeys);

  if (missingInEn.isNotEmpty) {
    print('⚠️  Warning: Keys missing in en.json:');
    for (final key in missingInEn) {
      print('   - $key');
    }
  }

  if (missingInAr.isNotEmpty) {
    print('⚠️  Warning: Keys missing in ar.json:');
    for (final key in missingInAr) {
      print('   - $key');
    }
  }

  if (missingInEn.isEmpty && missingInAr.isEmpty) {
    print('✅ All keys are synced between ar.json and en.json');
  }
}

// تحويل الـ key لاسم field صالح
String _generateFieldName(String key) {
  return key.replaceAll('.', '_').replaceAll('-', '_');
}