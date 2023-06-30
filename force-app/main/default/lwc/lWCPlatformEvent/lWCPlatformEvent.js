import { LightningElement, api, track } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LWCPlatformEvent extends LightningElement {
  @track location;
  @track newsContent;
  subscription = {};
  @api channelName = '/event/Cloud_New__e';

  connectedCallback() {
    this.registerErrorListener();
    this.handleSubscribe();
  }

  handleSubscribe() {
    const messageCallback = (response) => {
      const { data } = response;
      const { payload } = data;
      this.location = payload.Location__c;
      this.newsContent = payload.News_Content__c;
      this.showToast('Breaking News', this.location, 'success', 'dismissable');
    };

    subscribe(this.channelName, -1, messageCallback)
      .then((response) => {
        this.subscription = response;
      })
      .catch((error) => {
        console.error('Error subscribing to channel: ', error);
      });
  }

  registerErrorListener() {
    onError((error) => {
      console.error('Received error from server: ', error);
    });
  }

  showToast(title, message, variant, mode) {
    const event = new ShowToastEvent({
      title,
      message,
      variant,
      mode,
    });
    this.dispatchEvent(event);
  }
}