import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pat_flutter/utils/files.dart';
import 'package:path_provider/path_provider.dart';


Future<File> downloadFile(String url, String filename) async {
    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);
    File file = new File('$dir/$filename');
    // print(req.body);
    // await file.writeAsBytes(bytes);
    await Files.writeFile(file, req.body);
    String s = await Files.readFile(file);
    print(s);
    return file;
}