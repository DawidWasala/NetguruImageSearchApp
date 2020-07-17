import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import getPhotos from '@salesforce/apex/PhotosController.getPhotos'
import sendEmail from '@salesforce/apex/PhotosController.sendEmail'

const DELAY = 500;

export default class PhotosSearchMain extends LightningElement {

    @track
    isButtonDisabled = false
    @track
    searchKey = '';
    @track
    emailFieldValue = '';
    @wire(getPhotos, {title: '$searchKey'})
    photos = []
    @track columns = [
        { label: 'Thumbnail', fieldName: 'ThumbnailURL__c', type: 'image', initialWidth: 300},
        { label: 'Title', fieldName: 'Title__c', type: 'text' },
        { label: 'URL', fieldName: 'URL__c', type: 'url'},
        { label: 'AlbumId', fieldName: 'AlbumId__c', type: 'number', initialWidth: 150, cellAttributes: { alignment: 'center'}}
    ]


    onSearchInputChange(event){
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey
        }, DELAY);
    }

    handleSendEmailButton(event){
        this.isButtonDisabled = true
        sendEmail({photos: this.photos.data, email: this.emailFieldValue})
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Email was sent',
                variant: 'success'
            })
        )

    }

    onEmailInputChange(event){
        this.emailFieldValue = event.target.value;
    }
}