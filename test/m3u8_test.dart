import 'dart:io';

import 'package:m3u8/m3u8.dart';
import 'package:test/test.dart';

void main() {
  test("parseString", () async {
    var myFile = File('test/m3u8.txt');
    String content = await myFile.readAsString();
    var m3u8 = parseString(content);
    expect(1357, m3u8.playList.length);
    expect("3", m3u8.version);
  });
}
