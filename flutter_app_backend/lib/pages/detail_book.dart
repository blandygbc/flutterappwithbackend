import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/components/text_widget.dart';
import 'package:flutter_app_backend/constants.dart';
import 'package:flutter_app_backend/models/get_article_info.dart';

import 'all_books.dart';

class DetailBookPage extends StatefulWidget {
  final ArticleInfo articleInfo;
  final int index;

  DetailBookPage({Key key, this.articleInfo, this.index}) : super(key: key);

  @override
  _DetailBookPageState createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: baseHrzPad,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenheight * 0.01,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(
                          Icons.chevron_left,
                          color: Color(0xFF363f93),
                          size: 34,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.02,
                ),
                Container(
                  child: Row(
                    children: [
                      Card(
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      imgUrl + this.widget.articleInfo.img),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Container(
                        width: screenWidth - 210,
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: this.widget.articleInfo.title,
                              fontSize: 24,
                            ),
                            TextWidget(
                                text: this.widget.articleInfo.author,
                                fontSize: 16,
                                color: Color(0xFF7b8ea3)),
                            Divider(color: Colors.grey),
                            TextWidget(
                                text: this.widget.articleInfo.article_content,
                                fontSize: 14,
                                color: Color(0xFF7b8ea3)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.02,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Color(0xFF7b8ea3),
                            size: 28,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextWidget(text: "Like", fontSize: 18),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.share,
                            color: Color(0xFF7b8ea3),
                            size: 28,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextWidget(text: "Share", fontSize: 18),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.bookmarks_sharp,
                            color: Color(0xFF7b8ea3),
                            size: 28,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextWidget(text: "Bookshelf", fontSize: 18),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.01,
                ),
                Divider(color: Color(0xFF7b8ea3)),
                SizedBox(
                  height: screenheight * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    text: "Details",
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.02,
                ),
                Container(
                  height: screenheight * 0.27,
                  child: TextWidget(
                      text: this.widget.articleInfo.article_content,
                      fontSize: 16,
                      color: Colors.grey),
                ),
                Divider(color: Color(0xFF7b8ea3)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllBooks()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        TextWidget(
                          text: "Check the directory",
                          fontSize: 20,
                        ),
                        Expanded(child: Container()),
                        IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: null)
                      ],
                    ),
                  ),
                ),
                Divider(color: Color(0xFF7b8ea3)),
              ],
            ),
          ),
        ));
  }
}
