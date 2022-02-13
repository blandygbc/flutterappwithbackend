class ArticleInfo {
  int id;
  String article_content;
  String title;
  String description;
  String created_at;
  String updated_at;
  String img;
  String author;
  bool is_recommend;
  String keywords;

  ArticleInfo(
      String img,
      int id,
      String article_content,
      String title,
      String description,
      String created_at,
      String author,
      String keywords,
      bool is_recommend,
      String updated_at) {
    this.id = id;
    this.article_content = article_content;
    this.description = description;
    this.keywords = keywords;
    this.title = title;
    this.created_at = created_at;
    this.img = img;
    this.author = author;
    this.is_recommend = is_recommend;
    this.updated_at = updated_at;
  }

  ArticleInfo.fromJson(Map json)
      : id = json['id'],
        author = json['author'],
        article_content = json['article_content'],
        description = json['description'],
        title = json['title'],
        created_at = json['created_at'],
        img = json['img'],
        is_recommend = json['is_recommend'],
        keywords = json['keywords'],
        updated_at = json['updated_at'];
  Map toJson() {
    return {
      'id': id,
      'article_content': article_content,
      'title': title,
      'description': description,
      'created_at': created_at,
      'img': img,
      'author': author,
      'is_recommend': is_recommend,
      'keywords': keywords,
      'updated_at': updated_at,
    };
  }
}
