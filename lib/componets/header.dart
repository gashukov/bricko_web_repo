import 'package:flutter/material.dart';

import '../constants.dart';
import '../responsive.dart';

class Header extends StatelessWidget {
  String title;
  bool search;

  Header(String this.title, bool this.search, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),

        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: search ? SearchField()  : SizedBox()),
        // ProfileCard()
      ],
    );
  }
}

// class ProfileCard extends StatelessWidget {
//   const ProfileCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: defaultPadding),
//       padding: EdgeInsets.symmetric(
//         horizontal: defaultPadding,
//         vertical: defaultPadding / 2,
//       ),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//         border: Border.all(color: Colors.white10),
//       ),
//       child: Row(
//         children: [
//           Image.asset(
//             "assets/images/profile_pic.png",
//             height: 38,
//           ),
//           if (!Responsive.isMobile(context))
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//               child: Text("Angelina Joli"),
//             ),
//           Icon(Icons.keyboard_arrow_down),
//         ],
//       ),
//     );
//   }
// }

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Введите запрос...",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
