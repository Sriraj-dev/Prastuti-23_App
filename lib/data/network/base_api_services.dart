
abstract class BaseApiServices{

  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url,Map<String,dynamic> data);

  Future<dynamic> getPutApiResponse(String url);

  Future<dynamic> getDeleteApiResponse(String url);

}