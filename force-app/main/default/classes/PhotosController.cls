public with sharing class PhotosController {

    @AuraEnabled(cacheable=true)
    public static List<Photo__c> getPhotos(Integer numberOfRows, String title){
        if (String.isEmpty(title)){
            return [SELECT Id, Title__c, URL__c, ThumbnailURL__c, AlbumId__c, ExternalId__c FROM Photo__c LIMIT 200];
        }
        String searchKey = '%' + title + '%';
        return [SELECT Id, Title__c, URL__c, ThumbnailURL__c, AlbumId__c, ExternalId__c FROM Photo__c WHERE Title__c LIKE :searchKey LIMIT 200];

    }

    @AuraEnabled
    public static void sendEmail(List<Photo__c> photos){
        PhotosEmailService emailService = new PhotosEmailService();

        emailService.setPhotosToSend(photos);
        emailService.sendPhotos();
    }
}
