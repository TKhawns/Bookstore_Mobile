import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_repo.dart';
import 'package:bookstore_mobile/widget/author_list.dart';

class Book {
  final String title;
  final String description;
  final Author author;
  final String score;
  final String image;
  final String cost;
  final int count;
  final String shipCost;

  Book(this.title, this.description, this.author, this.score, this.image,
      this.cost, this.count, this.shipCost);
}

List<Book> getBookList() {
  return <Book>[
    Book(
        "An anonymoust Girl",
        "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
        Author(
          "Greer Hendricks",
          90,
          "assets/images/greer_hendricks.jpg",
          "William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là Thi sĩ của dòng sông Avon.",
        ),
        "4.0",
        "assets/images/anonymoust_girl.jpg",
        "142,000 VND",
        100,
        "15,000 VND"),
    Book(
        "An anonymoust Girl1",
        "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
        Author(
          "Greer Hendricks",
          90,
          "assets/images/greer_hendricks.jpg",
          "William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là Thi sĩ của dòng sông Avon.",
        ),
        "4.14",
        "assets/images/anonymoust_girl.jpg",
        "142,000 VND",
        100,
        "15,000 VND"),
    Book(
        "An anonymoust Girl2",
        "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
        Author(
          "Greer Hendricks",
          90,
          "assets/images/greer_hendricks.jpg",
          "William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là Thi sĩ của dòng sông Avon.",
        ),
        "4.14",
        "assets/images/anonymoust_girl.jpg",
        "142,000 VND",
        0,
        "15,000 VND"),
    Book(
        "An anonymoust Girl3",
        "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
        Author(
          "Greer Hendricks",
          90,
          "assets/images/greer_hendricks.jpg",
          "William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là Thi sĩ của dòng sông Avon.",
        ),
        "4.14",
        "assets/images/anonymoust_girl.jpg",
        "142,000 VND",
        0,
        "15,000 VND"),
    Book(
        "An anonymoust Girl4",
        "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
        Author(
          "Greer Hendricks",
          90,
          "assets/images/greer_hendricks.jpg",
          "William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là Thi sĩ của dòng sông Avon.",
        ),
        "4.14",
        "assets/images/anonymoust_girl.jpg",
        "142,000 VND",
        0,
        "15,000 VND"),
    Book(
        "An anonymoust Girl5",
        "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
        Author(
          "Greer Hendricks",
          90,
          "assets/images/greer_hendricks.jpg",
          "William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là Thi sĩ của dòng sông Avon.",
        ),
        "4.14",
        "assets/images/anonymoust_girl.jpg",
        "142,000 VND",
        0,
        "15,000 VND"),
    Book(
        "An anonymoust Girl6",
        "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
        Author(
          "Greer Hendricks",
          90,
          "assets/images/greer_hendricks.jpg",
          "William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là Thi sĩ của dòng sông Avon.",
        ),
        "4.14",
        "assets/images/anonymoust_girl.jpg",
        "142,000 VND",
        0,
        "15,000 VND"),
    Book(
        "An anonymoust Girl7",
        "The newest suspense novel from the authors behind The Wife Between Us introduces us to Jessica Ferris. Jess just wants to make a little extra cash when she decides to participate in a study on ethics with the mysterious Dr. Lydia Shields. The premise seems simple: Answer a few questions, then collect. But soon the doctor’s questions turn from simple survey queries to something much more sinister—leaving Jess unsure of whom she can trust. An early contender for thriller of the year.",
        Author(
          "Greer Hendricks",
          90,
          "assets/images/greer_hendricks.jpg",
          "William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là Thi sĩ của dòng sông Avon.",
        ),
        "4.14",
        "assets/images/anonymoust_girl.jpg",
        "142,000 VND",
        0,
        "15,000 VND"),
  ];
}
