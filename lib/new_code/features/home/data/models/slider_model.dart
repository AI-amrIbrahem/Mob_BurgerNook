class SliderModelResponse {
  String? id;
  String? name;
  String? action;
  String? content;

  SliderModelResponse({this.id,this.name  , this.action,  this.content});

  SliderModelResponse.fromJson(Map json) {
      id =  json['slider_id'];
      name= json['image_name'];
      action= json['action'];
      content= json['content'];
  }
}
