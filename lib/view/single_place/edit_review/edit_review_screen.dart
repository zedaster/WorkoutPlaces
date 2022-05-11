import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/edit_review/edit_review_bloc.dart';
import 'package:workout_places_app/bloc/edit_review/edit_review_event.dart';
import 'package:workout_places_app/bloc/edit_review/edit_review_state.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

class EditReviewScreen extends StatelessWidget {
  final ShortPlaceInfo short;

  final textController = TextEditingController();

  EditReviewScreen({
    Key? key,
    required this.short,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EditReviewBloc>().add(InitializeReviewEvent(short));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ваш отзыв"),
        ),
        // TODO: Move bloc consumer to stars only
        body: BlocConsumer<EditReviewBloc, EditReviewState>(
          listener: (context, state) {
            textController.text = state.text ?? "";
            switch (state.sendStatus) {
              case SendStatus.sent:
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Отзыв отправлен!"),
                ));
                break;
              case SendStatus.smallText:
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Текст не должен быть менее 30 символов!"),
                ));
                break;
              case SendStatus.bigText:
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Текст не должен превышать 1024 символа!"),
                ));
                break;
              case SendStatus.serverError:
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Произошла ошибка на сервере. Попробуйте позже."),
                ));
                break;
              case SendStatus.noAccess:
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Вам недоступна эта операция!"),
                ));
                break;
              case SendStatus.none:
                break;
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                const SizedBox(height: 10),
                // Short Info
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 100,
                  child: Row(
                    children: [
                      Image(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        image: short.mainImage,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              short.locationName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(short.cityName,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Stars
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 100,
                  child: Center(
                    child: Wrap(
                        children: Iterable<int>.generate(5).map((i) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<EditReviewBloc>()
                              .add(ChangeStarsReviewEvent(
                                currentText: textController.text,
                                newStars: i + 1,
                              ));
                        },
                        child: Icon(
                          Icons.star,
                          size: 50,
                          color: (i < (state.selectedStars ?? 0))
                              ? const Color(0xFFF1C40F)
                              : Theme.of(context).backgroundColor,
                        ),
                      );
                    }).toList()),
                  ),
                ),

                const SizedBox(height: 10),

                // TextBox
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        hintText: "Введите отзыв",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                        )),
                    minLines: 5,
                    maxLines: 10,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),

                // Complete button
                GestureDetector(
                  onTap: () {
                    context.read<EditReviewBloc>().add(PublishReviewEvent(
                        newText: textController.text,
                        newStars: state.selectedStars!));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF27AE60),
                    ),
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Опубликовать",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
