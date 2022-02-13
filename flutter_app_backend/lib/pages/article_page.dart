import 'dart:convert';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/components/text_widget.dart';
import 'package:flutter_app_backend/constants.dart';
import 'package:flutter_app_backend/models/get_article_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_book.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  var articles = <ArticleInfo>[];
  var allarticles = <ArticleInfo>[];

  @override
  void initState() {
    _getArticles();
    super.initState();
  }

  _getArticles() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("user");

/*
    if(user!=null){
    var userInfo=jsonDecode(user);
      debugPrint(userInfo);
    }else{
      debugPrint("no info");
    }*/
    await _initData();
  }

  _initData() async {
    try {
      await CallApi().getPublicData("recommendedarticles").then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          articles = list.map((model) => ArticleInfo.fromJson(model)).toList();
        });
      });
    } on Exception catch (e) {
      print(e);
    }
    try {
      await CallApi().getPublicData("allarticles").then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          allarticles =
              list.map((model) => ArticleInfo.fromJson(model)).toList();
        });
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    debugPrint(height.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: height * 0.02,
            // left: width * 0.05,
            // right: width * 0.05,
          ),
          child: Column(
            children: [
              Padding(
                padding: baseHrzPad,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu_book_sharp, color: Colors.indigo),
                      Icon(Icons.menu, color: Colors.blueGrey[300]),
                    ]),
              ),
              SizedBox(height: height * 0.03),
              Padding(
                padding: baseHrzPad,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    text: "Today",
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              //SearchBar(),
              Container(
                width: width * .9,
                alignment: Alignment.centerLeft,
                height: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: Icon(Icons.search, color: Colors.blueGrey[300]),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: baseHrzPad,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Recommended',
                      fontSize: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'view all',
                          style: TextStyle(
                            color: Colors.blueGrey[300],
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.chevron_right,
                              color: Colors.blueGrey[300],
                              size: 22,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                //color: colorLightGrey,
                height: height * 0.30,
                child: PageView.builder(
                  controller: PageController(viewportFraction: .9),
                  itemCount: articles.length ?? 0,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        debugPrint(i.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailBookPage(
                                      articleInfo: articles[i],
                                    )));
                      },
                      child: articles.length == 0
                          ? CircularProgressIndicator()
                          : Stack(
                              children: [
                                Positioned(
                                  top: 35,
                                  left: 0,
                                  child: Material(
                                    elevation: 0.0,
                                    child: Container(
                                      height: 170,
                                      width: width * 0.79,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              offset: Offset(-8, 0),
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    left: 5,
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.grey.withOpacity(0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        height: 190,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: Image.network(imgUrl +
                                                        articles[i].img)
                                                    .image)),
                                      ),
                                    )),
                                Positioned(
                                  top: 45,
                                  left: width * 0.38,
                                  child: Container(
                                    height: 190,
                                    width: 140,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: articles[i].title,
                                            fontSize: 16,
                                          ),
                                          TextWidget(
                                            color: colorSecondary,
                                            text: articles[i].author ?? "Dylan",
                                            fontSize: 12,
                                          ),
                                          Divider(
                                            color: colorPrimary,
                                            endIndent: 5,
                                          ),
                                          TextWidget(
                                            color: colorSecondary,
                                            text: articles[i].article_content ??
                                                "...",
                                            fontSize: 12,
                                          ),
                                        ]),
                                  ),
                                )
                              ],
                            ),
                    );
                  },
                ),
              ),
              //SizedBox(height: height * 0.01),
              Padding(
                padding: baseHrzPad,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'New Book List',
                      fontSize: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'view all',
                          style: TextStyle(
                            color: Colors.blueGrey[300],
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.chevron_right,
                              color: Colors.blueGrey[300],
                              size: 22,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              //SizedBox(height: height * 0.01),
              SingleChildScrollView(
                  child: Container(
                height: height * 0.28,
                //color: Colors.blueGrey[50],
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allarticles.length ?? 0,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailBookPage(
                                      articleInfo: allarticles[i],
                                    )));
                      },
                      child: allarticles.length == 0
                          ? CircularProgressIndicator()
                          : Container(
                              height: height * 0.028,
                              width: 130,
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Card(
                                    elevation: 5,
                                    shadowColor: Colors.black.withOpacity(0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      height: 170,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: Image.network(imgUrl +
                                                      allarticles[i].img)
                                                  .image)),
                                    ),
                                  ),
                                  TextWidget(
                                    text: allarticles[i].title,
                                    fontSize: 14,
                                  ),
                                  TextWidget(
                                    text: allarticles[i].author,
                                    fontSize: 12,
                                    color: colorSecondary,
                                  )
                                ],
                              ),
                            ),
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
