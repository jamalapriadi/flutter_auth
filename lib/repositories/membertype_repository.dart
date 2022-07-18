import 'package:hsp_gate/helpers/http_request.dart';
import 'package:hsp_gate/models/member-type/membertype_response.dart';

class MembertypeRepository {
  final network = Network();

  static const String urlApi = 'https://hsp-api.kemanaya.com/api';

  Future<List<MembertypeResponse>> getAll() async {
    var url = urlApi + '/auth/member-type-all';

    final response = await network.getRequest(url);

    return membertypeResponseFromjson(response.body);
  }
}
