abstract class BaseModel {
  Map<String, dynamic> toJson();

  fromJson(Map<String, dynamic> json);
}
