
import 'package:simple_nav_bar/models/post.dart';

class PostsWrapper {
  List<Post>? content;
  Page? page;

  PostsWrapper({this.content, this.page});

  PostsWrapper.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['content'];
    content = list.map((c)=>Post.fromJson(c)).toList();
    page = Page.fromJson(json['page']);
  }
}

class Page {
  int? size;
  int? number;
  int? totalElements;
  int? totalPages;

  Page.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    number = json['number'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }
}
