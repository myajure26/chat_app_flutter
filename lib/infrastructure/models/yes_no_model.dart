import '../../domain/entities/message.dart';

class YesNoModel {
  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  final String answer;
  final bool forced;
  final String image;

  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
      };

  Message toMessageEntity() => Message(
    text: answer == 'yes' ? 'Si' : answer == 'maybe' ? 'Tal vez' : 'No', 
    fromWho: FromWho.his,
    imageUrl: image
  );
}