import '../http/base-model.dart';
import '../http/http-manager.dart';

class BaseService<T extends BaseModel> {
  late HttpManager manager;
  late String baseUrl;
  final ObjectCreator<T> creator;

  BaseService(this.creator, this.baseUrl) {
    manager = HttpManager(this.creator);
  }
}
