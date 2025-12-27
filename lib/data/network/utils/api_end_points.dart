
class ApiEndPoints{

  /// Base url
  static const baseUrl = 'https://dummyjson.com';


  static const int apiStatus_200 = 200; //success
  static const int apiStatus_201 = 201; //success
  static const int apiStatus_202 = 202; //success for static page
  static const int apiStatus_203 = 203; //success
  static const int apiStatus_205 = 205; // for remaining step 2
  static const int apiStatus_400 = 400; //Invalid data
  static const int apiStatus_401 = 401; //Invalid data
  static const int apiStatus_404 = 404; //Invalid data
  static const int apiStatus_403 = 403; // Access Denied
  static const int apiStatus_406 = 406; //Not Acceptable
  static const int apiStatus_500 = 500; // Internal Server Error



  // Endpoints

  /// receive message
  static const receiveMessage = '/comments?limit=1';

  /// Search word meaning
  static searchMeaning(String input) =>'https://api.dictionaryapi.dev/api/v2/entries/en/$input';






}