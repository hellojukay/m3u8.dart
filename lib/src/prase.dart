import 'entry.dart';

M3u8 prase(String content) {
  if (content.isEmpty) {}
  M3u8 m3u8 = M3u8();
  List<String> lines = content.split(RegExp(r"\r?\n"));
  if (lines.isEmpty) {
    throw Exception('content format error, is empty string ?');
  }
  var versionRegex = RegExp(r'EXT-X-VERSION:\s?(\d+)');
  var linkRegex = RegExp(r'^https?');
  var cacheRegex = RegExp(r'#EXT-X-ALLOW-CACHE:\s?(\w)');

  for (var line in lines) {
    if (linkRegex.hasMatch(line)) {
      m3u8.playList.add(line);
      continue;
    }

    var versionMath = versionRegex.firstMatch(line);
    if (versionMath != null) {
      m3u8.version = versionMath.group(1)!;
      continue;
    }
    var cacheMath = cacheRegex.firstMatch(line);
    if (cacheMath != null) {
      switch (cacheMath.group(1)!.toLowerCase()) {
        case "yes":
          {
            m3u8.allowCache = true;
            break;
          }
        case "true":
          {
            m3u8.allowCache = true;
            break;
          }

        default:
          {
            m3u8.allowCache = false;
          }
          break;
      }
    }
  }
  return m3u8;
}
