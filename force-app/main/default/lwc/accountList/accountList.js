import { LightningElement, api, wire } from 'lwc';
import getaccRec from '@salesforce/apex/AccountList.getaccRec';

export default class AccountList extends LightningElement {
  @api records;
  @api errors;

  @wire(getaccRec)
  wiredCases({ error, data }) {
    if (data) {
      this.records = data.map(record => ({
        ...record,
        rowColor: this.getColor(record.Total_Fine_Paid__c)
      }));
    } else if (error) {
      console.error(error);
    }
  }

  getColor(totalFine) {
    if (totalFine > 500) {
      return 'row-red';
    } else if (totalFine >= 100 && totalFine <= 500) {
      return 'row-orange';
    }
    return '';
  }
}