import 'package:chat_app/data/repository/chat/model/receiver_message_response_model.dart';
import 'package:chat_app/data/repository/chat/model/search_meaning_response_model.dart';
import 'package:dio/dio.dart';
import 'package:chat_app/data/network/dio/api_client.dart';
import 'package:chat_app/data/network/utils/api_end_points.dart';

class ChatRepository {
  final ApiClient apiClient;

  ChatRepository(this.apiClient);

  Future getReceiverMessageApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.receiveMessage);
      ReceiverMessageResponseModel responseModel = receiverMessageResponseModelFromJson(response.toString());
      return responseModel;
    } catch (err) {
      return err;
    }
  }

  Future<List<SearchMeaningResponseModel>> searchWordMeaningApi(
      String input,
      ) async {
    try {
      final Response response = await apiClient.getRequest(ApiEndPoints.searchMeaning(input),);

      if (response.data is List) {
        return (response.data as List)
            .map(
              (e) => SearchMeaningResponseModel.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
            .toList();
      }

      if (response.data is Map) {
        print(':::::;');
        throw FormatException(
          response.data['message'] ?? 'No meaning found',
        );
      }

      throw FormatException('Unexpected response format');
    } on DioException catch (e) {
      // Re-throw so caller handles it
      throw e;
    }
  }


}