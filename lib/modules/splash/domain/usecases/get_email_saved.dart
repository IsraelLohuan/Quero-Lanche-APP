import '../services/i_email_cache_service.dart';

class GetEmailSaved {
  final IEmailCacheService emailCacheService;
  
  GetEmailSaved(this.emailCacheService);
  
  Future<String> call() async {
    String? emailSaved = emailCacheService.getEmail('key');
    return emailSaved ?? '';
  }
}