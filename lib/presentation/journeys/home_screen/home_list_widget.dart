import 'package:flutter/material.dart';
import 'package:maharashtra_board_books/common/constants/RandomColorHelper.dart';
import 'package:maharashtra_board_books/data/models/SubjectsApiResModel.dart';
import 'package:maharashtra_board_books/presentation/widgets/txt.dart';

class HomeListWidget extends StatelessWidget {
  final List<Response> response;
  final int index;
  final Function onTapOnList;

  const HomeListWidget({
    Key? key,
    required this.response,
    required this.index,
    required this.onTapOnList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              flex: 1,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: RandomHexColor().colorRandom(),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                ),

                child: Center(
                  child: Txt(
                    txt: response[index].numericNumber??'',
                    txtColor: Colors.white,
                    txtSize: 15,
                    fontWeight: FontWeight.bold,
                    padding: 5,
                  ),
                ),
              ),),

            Expanded(
              flex: 3,
              child: Txt(
                txt: response[index].categoryName?? '',
                txtColor: Colors.black,
                txtSize: 14,
                fontWeight: FontWeight.bold,
                padding: 5,
              ),
            ),


            Expanded(
              flex: 1,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 3,
                      spreadRadius: 3,
                    ),
                  ],
                ),

                child: const Center(
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      onTap: (){
        onTapOnList();
      },
    );
  }
}
