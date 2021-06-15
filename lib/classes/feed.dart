import 'package:jiffy/jiffy.dart';

class Feed {

  final String title;
  final String link;
  final String linkImagem;
  final String data;

  Feed({required this.title, required this.link, required this.linkImagem, required this.data});

  get DataFormatada{
    return Jiffy(this.data).format("dd/MM/yyyy");
  }
}