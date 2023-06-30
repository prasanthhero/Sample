import { LightningElement, track, wire } from 'lwc';
import getLeadConversionData from '@salesforce/apex/Login.getLeadConversionData';

export default class LoginForm extends LightningElement {
    @track disableChildList = false;
    @track oppid;
    fieldId = '';

    disableList() {
        this.disableChildList = true;
    }
    handleSuccess(event) {
        this.fieldId = event.detail.id;
        console.log('Created Lead ID:', this.fieldId);
        getLeadConversionData({ leadId: this.fieldId })
            .then(result => {
                this.oppid = result;
                console.log('Opportunity ID:', this.oppid);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
}