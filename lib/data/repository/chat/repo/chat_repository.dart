import 'package:chat_app/data/repository/chat/model/receiver_message_response_model.dart';
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

}