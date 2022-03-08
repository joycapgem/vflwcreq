import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import childContact from '@salesforce/schema/Child_Contact__c';
import nameField from '@salesforce/schema/Child_Contact__c.Name__c';
import phoneField from '@salesforce/schema/Child_Contact__c.Phone__c';
import emailField from '@salesforce/schema/Child_Contact__c.email__c';
import addressField from '@salesforce/schema/Child_Contact__c.Address__c';
import relatedContactField from '@salesforce/schema/Child_Contact__c.Contact__c';
import schoolField from '@salesforce/schema/Child_Contact__c.School__c';
import classField from '@salesforce/schema/Child_Contact__c.class__c';


export default class HelloWorld extends NavigationMixin(LightningElement) {
    @api message;
    @api recordId;

    submit = false;

    _title = 'Success';
    _message = 'Successfully saved the child contact';
    _variant = 'success';

    childContactObject = childContact;
    nameField = nameField;
    phoneField = phoneField;
    emailField = emailField;
    addressField = addressField;
    relatedContactField = relatedContactField;
    // schoolField = schoolField;
    // classField = classField;

    connectedCallback(){
        console.log(window.location);
    }

    handleSuccess(event) {

        console.log('success');
        console.log(window.location);

        window.location.assign('/' + event.detail.id);
    }

    navigateToRec(){
        console.log('other');
        console.log(window.location);

        window.location.assign('/' + 'a0L5j000000X091EAC');
    }
    
    handleReset(event) {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );

        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }

    handleSubmit(event) {
        this.submit = true;
    }
}
