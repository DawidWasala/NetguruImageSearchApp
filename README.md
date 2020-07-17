# Salesforce Image Search App

To schedule a job run in a Developer Console:
``` System.schedule('Photos Integration Service', '0 0 0 1/1 * ? *' ,new PhotosServiceScheduler());```