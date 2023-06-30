import { LightningElement, track, api, wire } from 'lwc';
import getName from '@salesforce/apex/BookDetail.getName';
import getProduct from '@salesforce/apex/AddProductOpp.getProduct';
export default class BookDetail extends LightningElement {
@track columns = [
    { label: 'Id', fieldName: 'Id'},
    { label: 'Product Name', fieldName: 'Name' },
    { label: 'ImageUrl', fieldName: 'ImageUrl__c' },
    { label: 'Product Code', fieldName: 'ProductCode' },
    { label: 'Unit Cost', fieldName: 'Unit_Cost__c' },
    { label: 'Quantity', fieldName: 'Quantity__c' },
    { label: 'Total Cost', fieldName: '	Total_Cost__c' },
    { label: 'Product Description', fieldName: 'Description' }
  ];
  @track ProductList;
  @api disabled = false;
  @api fieldId='';
  Name = '';
  @api oppid;

  handleChange(event){
    const userInput = event.target.value;
    this.Name = userInput;
  }
  oppaction(event) {
    this.fieldId = event.target.dataset.fieldid;
    console.log('Product ID:', this.fieldId);
    getProduct({ProductId: this.fieldId, OppId: this.oppid  })
      .then(result => {
        console.log(result);
      })
      .catch(error => {
        console.error(error);
      });
    
} 

  @wire(getName, { Name: '$Name' })
  wiredOrder({data,error}) {
    if (data) {
      this.ProductList = data;
      console.log(data); 
    } else if (error) {
      console.log(error);
    }
  }
}