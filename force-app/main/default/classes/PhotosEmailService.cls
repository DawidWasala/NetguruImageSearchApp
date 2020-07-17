public with sharing class PhotosEmailService {

    private List<Photo__c> photosToSend;

    public void sendPhotos(String email){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{email});
        mail.setHtmlBody(buildHtmlBody(photosToSend));

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }



    private String buildHtmlBody(List<Photo__c> photos){
        String htmlBody = '<html> <style> table, th, td {border: 1px solid black;} </style> <body> <table>';
        htmlBody += '<tr> <th> Id </th> <th> Title </th> <th> URL </th> <th> Thumbnail </th> <th> AlbumId </th> </tr>';
        for (Photo__c photo : photos){
            htmlBody += '<tr> <td>' + photo.ExternalId__c + '</td>' + '<td>' + photo.Title__c + '</td>' + '<td>' + photo.URL__c + '</td>' + '<td> <img src="' + photo.ThumbnailURL__c + '" alt="Flowers in China"></td>' + '<td>' + photo.AlbumId__c + '</td> </tr>';
        }
        htmlBody += '</table> </body> </html>';
        return htmlBody;
    }

    public void setPhotosToSend(List<Photo__c> photos){
        this.photosToSend = photos;
    }

    public List<Photo__c> getPhotosToSend(){
        return this.photosToSend;
    }
}
