import 'package:quick/domain/model/model/currency_model.dart';
import 'package:quick/domain/model/model/units_data.dart';
import 'package:quick/domain/model/request/selected_request.dart';

import 'brand_data.dart';
import 'category_model.dart';
import 'galleries.dart';

class PreviewModel {
  CategoryData? category;
  BrandData? brand;
  UnitsData? unit;
  num? price;
  String? phone;
  String? title;
  String? desc;
  List<String>? images;
  List<Galleries>? urls;
  Galleries? video;
  CurrencyData? currency;
  List<SelectedAttribute>? attributes;

  PreviewModel({
    required this.category,
    required this.unit,
    required this.brand,
    required this.price,
    required this.phone,
    required this.title,
    required this.desc,
    this.video,
    this.images,
    this.urls,
    this.currency,
    this.attributes,
  });

  PreviewModel addVideo() {
    List<Galleries>? urls = List<Galleries>.from(this.urls ?? []);
    if (video != null) urls.insert(0, video!);
    return PreviewModel(
      category: category,
      unit: unit,
      brand: brand,
      price: price,
      phone: phone,
      title: title,
      desc: desc,
      images: images,
      currency: currency,
      attributes: attributes,
      urls: urls,
    );
  }
}
