import 'package:hsp_gate/helpers/http_request.dart';
import 'package:hsp_gate/models/member/member_response.dart';
import 'package:hsp_gate/models/member/scan_member_response.dart';

class MemberRepository {
  final network = Network();

  static const String urlApi = 'https://hsp-api.kemanaya.com/api';

  Future<MemberResponse> memberById(String id) async {
    var url = urlApi + '/auth/member/' + id;

    final response = await network.getRequest(url);

    return memberResponseFromJson(response.body);
  }

  Future<ScanMemberResponse> scanMemberById(String id) async {
    var url = urlApi + '/auth/scan-member/' + id;

    final response = await network.getRequest(url);

    if (response.statusCode == 200) {
      return scanMemberResponse(response.body);
    } else {
      return scanMemberResponseFailed(response.body);
    }
  }
}
