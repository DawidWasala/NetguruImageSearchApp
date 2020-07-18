@isTest
public with sharing class PhotosServiceTest {

    private static PhotosIntegrationService service = new PhotosIntegrationService();

    @TestSetup
    static void makeData(){
        String data = '[{ "albumId": 1, "id": 1, "title": "accusamus beatae ad facilis cum similique qui sunt", "url": "https://via.placeholder.com/600/92c952", "thumbnailUrl": "https://via.placeholder.com/150/92c952" },{ "albumId": 1, "id": 3, "title": "officia porro iure quia iusto qui ipsa ut modi", "url": "https://via.placeholder.com/600/24f355", "thumbnailUrl": "https://via.placeholder.com/150/24f355" }]';
        service.savePhotos((List<Photo>) System.JSON.deserialize(data, List<Photo>.class));
    }
    
    @isTest
    static void testGetPhotosFromRemote(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PhotosGetHttpResponseMock());
        service.getPhotosFromRemote();

        List<Photo__c> photos = [SELECT Id FROM Photo__c];
        Test.stopTest();
        System.assertEquals(3, photos.size());
    }

    @isTest
    static void testSendEmail(){
        PhotosController.sendEmail([SELECT Id, URL__c, ThumbnailURL__c, Title__c, AlbumId__c, ExternalId__c FROM Photo__c LIMIT 10], 'test@org.com');
    }

}
