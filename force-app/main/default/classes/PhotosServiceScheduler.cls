global with sharing class PhotosServiceScheduler implements Schedulable{
    
    global void execute(SchedulableContext SC){
        PhotosIntegrationService service = new PhotosIntegrationService();
        service.getPhotosFromRemote();
    }
}
