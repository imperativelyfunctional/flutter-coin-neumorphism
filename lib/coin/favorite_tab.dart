import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';

renderFavoriteTab() {
  return SliverList(
      delegate: SliverChildListDelegate.fixed([
    Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey.shade400),
          )),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Center(
                child: Lottie.asset('images/80327-coming-soon.json'),
              )),
        )
      ],
    )
  ]));
}
