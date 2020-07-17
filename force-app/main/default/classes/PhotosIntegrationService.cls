public with sharing class PhotosIntegrationService {

    public void getPhotosFromRemote(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:PhotosIntegration');
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);
  
        Photo[] photos = Photo.parse(res.getBody());

        savePhotos(photos);
    }

    private void savePhotos(List<Photo> photos){

        List<Photo__c> photosToInsert = new List<Photo__c>();
        List<Photo__c> photosToUpdate = new List<Photo__c>();
        List<Integer> externalIds = new List<Integer>();
        for (Photo ph : photos){
            externalIds.add(ph.Id);
        }
        
        List<Photo__c> notExistingPhotos = [SELECT Id, ExternalId__c FROM Photo__c WHERE ExternalId__c NOT IN :externalIds];
        delete notExistingPhotos;

        List<Photo__c> existingPhotos = [SELECT Id, ExternalId__c FROM Photo__c WHERE ExternalId__c IN :externalIds];
        for (Photo newPhoto : photos){
            for (Photo__c photoInDb : existingPhotos){
                if (newPhoto.Id == photoInDb.ExternalId__c){
                
                    photoInDb.Title__c = newPhoto.title;
                    photoInDb.AlbumId__c = newPhoto.albumId;
                    photoInDb.URL__c = newPhoto.url;
                    photoInDb.ThumbnailURL__c = newPhoto.thumbnailUrl;
    
                    photosToUpdate.add(photoInDb);
                    break;
                }
            }
            Photo__c photo = new Photo__c(
                Title__c = newPhoto.title,
                AlbumId__c = newPhoto.albumId,
                ExternalId__c = newPhoto.id,
                URL__c = newPhoto.url,
                ThumbnailURL__c = newPhoto.thumbnailUrl
            );
            photosToInsert.add(photo);
        }
        insert photosToInsert;
        update photosToUpdate;
    }
 
}
