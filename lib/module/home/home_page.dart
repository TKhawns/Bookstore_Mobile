// ignore_for_file: depend_on_referenced_packages, unnecessary_import, unused_import, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, unnecessary_null_comparison

import 'dart:ui';

import 'package:bookstore_mobile/base/base_widget.dart';
import 'package:bookstore_mobile/module/home/book_detail.dart';
import 'package:bookstore_mobile/module/home/home_bloc.dart';
import 'package:bookstore_mobile/module/author/author_profile.dart';
import 'package:bookstore_mobile/module/author/famous_author.dart';
import 'package:bookstore_mobile/module/search/search_book_bloc.dart';
import 'package:bookstore_mobile/module/search/search_view.dart';
import 'package:bookstore_mobile/repo/author_repository/author_repo.dart';
import 'package:bookstore_mobile/repo/author_repository/author_service.dart';
import 'package:bookstore_mobile/repo/book_repository/book_repo.dart';
import 'package:bookstore_mobile/repo/book_repository/book_service.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:bookstore_mobile/widget/author_list.dart';
import 'package:bookstore_mobile/widget/bloc_listener.dart';
import 'package:bookstore_mobile/widget/book_list.dart';
import 'package:bookstore_mobile/widget/navigator_item.dart';
import 'package:bookstore_mobile/widget/shop_info.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../repo/author_repository/author_data.dart';
import '../../repo/book_repository/book_data.dart';
import '../../widget/filter_widget.dart';
import '../../widget/shopping_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _txtSearchTextController =
      TextEditingController();

  List<Filter> filters = getFilterList();
  Filter selectedFilter = Filter("");
  List<Author> authors = getAuthorList();
  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem selectedItem = NavigationItem(Icons.book, "", "");
  List<BookData> bookData = [];

  SearchBookBloc searchBloc = SearchBookBloc();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedFilter = filters[0];
      selectedItem = navigationItems[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomePage>(
          create: (_) => HomePage(),
        ),
        Provider.value(
          value: BookService(),
        ),
        ProxyProvider<BookService, BookRepo>(
          update: (context, bookService, previous) =>
              BookRepo(bookService: bookService),
        ),
        Provider.value(
          value: AuthorService(),
        ),
        ProxyProvider<AuthorService, AuthorRepo>(
          update: (context, authorService, previous) =>
              AuthorRepo(authorService: authorService),
        ),
        Provider.value(value: OrderService()),
        ProxyProvider<OrderService, OrderRepo>(
          update: (context, orderService, previous) =>
              OrderRepo(orderService: orderService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
          title: Container(
            margin: EdgeInsets.only(left: 10),
            height: 40,
            child: TextField(
              controller: _txtSearchTextController,
              onTap: () {
                Navigator.pushNamed(context, "/search_view");
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 10, color: Color.fromARGB(255, 0, 151, 178)),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, size: 26, color: Colors.black),
                hintText: "Search Books",
              ),
            ),
          ),
          actions: [
            ShoppingCartWidget(),
            // Container(
            //     margin: EdgeInsets.only(top: 15, right: 30),
            //     child: badges.Badge(
            //       badgeContent: Text(
            //         "0",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       child: GestureDetector(
            //         onTap: () {},
            //         child: Icon(
            //           Icons.shopping_cart,
            //           size: 30,
            //         ),
            //       ),
            //     )),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 8,
                    blurRadius: 12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover Books",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        height: 1,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _buildFilters(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: BookListWidget(),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Famous Authors",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FamousAuthor(),
                                    ));
                              },
                              child: Text(
                                "Show all",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 151, 178),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Color.fromARGB(255, 0, 151, 178),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: EdgeInsets.only(bottom: 16),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: AuthorListWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 8,
                blurRadius: 12,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildNavigationItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFilters() {
    List<Widget> list = [];
    for (var i = 0; i < filters.length; i++) {
      list.add(_buildFilter(filters[i]));
    }
    return list;
  }

  Widget _buildFilter(Filter item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = item;
        });
      },
      child: Container(
        height: 50,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                item.name,
                style: TextStyle(
                  color: selectedFilter == item
                      ? Color.fromARGB(255, 0, 151, 178)
                      : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            //Spacer(),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                width: 60,
                height: 3,
                color: selectedFilter == item
                    ? Color.fromARGB(255, 0, 151, 178)
                    : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List<Widget> buildAuthors() {
  //   List<Widget> list = [];
  //   for (var i = 0; i < authors.length; i++) {
  //     list.add(buildAuthor(authors[i], i));
  //   }
  //   return list;
  // }

  // Widget buildAuthor(Author author, int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => AuthorProfile(author: author)),
  //       );
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.grey[200],
  //         borderRadius: BorderRadius.all(Radius.circular(15)),
  //       ),
  //       padding: EdgeInsets.all(12),
  //       margin: EdgeInsets.only(right: 36, left: index == 0 ? 16 : 0),
  //       width: 255,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Card(
  //             elevation: 4,
  //             margin: EdgeInsets.all(0),
  //             clipBehavior: Clip.antiAlias,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(15)),
  //             ),
  //             child: Container(
  //               width: 75,
  //               height: 75,
  //               decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                     image: AssetImage(author.image), fit: BoxFit.cover),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 12,
  //           ),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 author.fullName,
  //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //               ),
  //               Row(
  //                 children: [
  //                   Icon(
  //                     Icons.library_books,
  //                     color: Colors.grey,
  //                     size: 18,
  //                   ),
  //                   SizedBox(
  //                     width: 14,
  //                     height: 24,
  //                   ),
  //                   Text(
  //                     author.books.toString() + " books",
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       color: Colors.grey,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  List<Widget> buildNavigationItems() {
    List<Widget> list = [];
    for (var i = 0; i < navigationItems.length; i++) {
      list.add(buildNavigationItem(navigationItems[i]));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
        if (selectedItem.title != "Trang chủ") {
          Navigator.pushNamed(context, selectedItem.path);
          selectedItem = navigationItems[0];
        } else {
          Navigator.pushReplacementNamed(context, selectedItem.path);
          return;
        }
      },
      child: Container(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //padding: EdgeInsets.only(bottom: 50),
              width: 200,
              height: 4,
              color: selectedItem == item
                  ? Color.fromARGB(255, 0, 151, 178)
                  : Colors.transparent,
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Column(
                children: [
                  Icon(
                    item.iconData,
                    color: selectedItem == item
                        ? Color.fromARGB(255, 0, 151, 178)
                        : Colors.grey,
                    size: 38,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: selectedItem == item
                            ? Color.fromARGB(255, 0, 151, 178)
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookListWidget extends StatelessWidget {
  List<BookData> bookData = [];
  Widget build(BuildContext context) {
    return Provider<HomeBloc?>.value(
      value: HomeBloc.getInstance(
          bookRepo: Provider.of(context),
          orderRepo: Provider.of(context),
          authorRepo: Provider.of(context)),
      child: Consumer<HomeBloc>(builder: (context, bloc, child) {
        bloc.getBookList().listen((event) {
          for (var book in event) {
            print("Title: ${book.title}");
            bookData.add(book);
          }
        });
        return StreamProvider<List<BookData>?>.value(
          initialData: bookData,
          value: bloc.getBookList(),
          child: Consumer<List<BookData>?>(
            builder: (context, data, child) {
              print("data: $data");

              if (data!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }

              return ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: newBuildBooks(bookData, context),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> newBuildBooks(List<BookData> data, BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(newbuildBook(data[i], i, context));
    }
    return list;
  }

  Widget newbuildBook(BookData bookData, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookDetail(bookData: bookData)),
        );
      },
      child: Container(
        margin:
            EdgeInsets.only(right: 32, left: index == 0 ? 16 : 0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 12,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 16, top: 24),
                child: Hero(
                  tag: '${bookData.title}',
                  child: Image.asset(
                    "assets/images/${bookData.image}",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Text(
              '${bookData.title}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              bookData.authorName,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthorListWidget extends StatelessWidget {
  List<AuthorData> authorData = [];
  Widget build(BuildContext context) {
    return Provider<HomeBloc?>.value(
      value: HomeBloc.getInstance(
          bookRepo: Provider.of(context),
          orderRepo: Provider.of(context),
          authorRepo: Provider.of(context)),
      child: Consumer<HomeBloc>(builder: (context, bloc, child) {
        bloc.getAuthorList().listen((event) {
          for (var author in event) {
            print("Title: ${author.full_name}");
            authorData.add(author);
          }
        });
        return StreamProvider<List<AuthorData>?>.value(
          initialData: authorData,
          value: bloc.getAuthorList(),
          child: Consumer<List<AuthorData>?>(
            builder: (context, data, child) {
              print("data: $data");

              if (data!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }

              return ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: newBuildAuthors(authorData, context),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> newBuildAuthors(List<AuthorData> data, BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(newBuildAuthor(data[i], i, context));
    }
    return list;
  }

  Widget newBuildAuthor(AuthorData author, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AuthorProfile(author: author)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(right: 36, left: index == 0 ? 16 : 0),
        width: 255,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(author.image),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author.full_name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.library_books,
                      color: Colors.grey,
                      size: 18,
                    ),
                    SizedBox(
                      width: 14,
                      height: 24,
                    ),
                    Text(
                      author.number_books.toString() + " books",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc?>.value(
      value: HomeBloc.getInstance(
        bookRepo: Provider.of(context),
        orderRepo: Provider.of(context),
        authorRepo: Provider.of(context),
      ),
      child: CartWidget(),
    );
  }
}

class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var bloc = Provider.of<HomeBloc>(context);
    bloc.getShoppingCartInfo();
  }

  @override
  Widget build(BuildContext context) {
    ShoppingCart count = ShoppingCart(total: 0);
    return Consumer<HomeBloc>(
      builder: (context, bloc, child) {
        bloc.shoppingCartStream.listen((event) {
          count.total = event.total;
        });
        return StreamProvider<ShoppingCart>.value(
          initialData: count,
          value: bloc.shoppingCartStream,
          catchError: (context, error) {
            print(error);
            return ShoppingCart(total: -1);
          },
          child: Consumer<ShoppingCart>(
            builder: (context, value, child) {
              if (value == null) {
                return Container(
                  margin: EdgeInsets.only(top: 15, right: 20),
                  child: Icon(Icons.shopping_cart),
                );
              }
              var cart = value;
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 15, right: 20),
                  child: badges.Badge(
                    badgeContent: Text(
                      "${cart.total}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
