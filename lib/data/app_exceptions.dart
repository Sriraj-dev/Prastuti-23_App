
class AppException implements Exception{

   final message;
   final prefix;

  AppException([this.message,this.prefix]);

  String toString(){
    return '$prefix $message';
  }
}

class FetchDataException extends AppException{
  FetchDataException([String? message]): super(message,'Communication Error!');
}

class UnauthorizedException extends AppException{
  UnauthorizedException([String? message]): super(message,'User Unauthorized');
}

class InvalidInputException extends AppException{
  InvalidInputException([String? message]): super(message,'Invalid Input!');
}


class BadRequestException extends AppException{
  BadRequestException([String? message]): super(message,'Invalid Request');
}

