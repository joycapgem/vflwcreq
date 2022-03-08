public with sharing class AccProfile {
    public static void acc(){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();

        MetadataService.Profile profile 
        = ( MetadataService.Profile) service.readMetadata(
            'Profile', 
            new String[] { 'Admin'}
        ).getRecords()[0];

        System.debug(profile);
    }
    
    public static void createObject()
    {
        MetadataService.MetadataPort service = createService();
        System.debug('Service Created.');
        MetadataService.CustomObject customObject = new MetadataService.CustomObject();
        customObject.fullName = 'Test__c';
        customObject.label = 'Test';
        customObject.pluralLabel = 'Tests';
        customObject.nameField = new MetadataService.CustomField();
        customObject.nameField.type_x = 'Text';
        customObject.nameField.label = 'Test Record';
        customObject.deploymentStatus = 'Deployed';
        customObject.sharingModel = 'ReadWrite';
        System.debug('Building Object.');
        List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { customObject });
        System.debug('Object Created.');
        handleSaveResults(results[0]);
        System.debug('Object Saved.');
    }
    
    public static void createField(String fieldName)
    {
        MetadataService.MetadataPort service = createService();
        System.debug('Service Created.');
        MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName = 'Test__c.' + fieldName + '__c';
        customField.label = fieldName;
        customField.type_x = 'Text';
        customField.length = 42;
        System.debug('Building Field - ' + fieldName);
        List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { customField });
        System.debug('Field Created.');
        handleSaveResults(results[0]);
        System.debug('Field Saved.');
    }
    
    // to add field to layout after field creataion
    public static void addFieldToLayout()
    {
        MetadataService.MetadataPort service = createService();

        // Read the Layout
        MetadataService.Layout layout =
            (MetadataService.Layout) service.readMetadata('Layout',
                new String[] { 'Test__c-Test Layout' }).getRecords()[0];

        // Add Layout section, layout, item and field
        if(layout.layoutSections==null)
            layout.layoutSections = new List<MetadataService.LayoutSection>();
        MetadataService.LayoutSection newLayoutSection = new MetadataService.LayoutSection();
        newLayoutSection.style = 'OneColumn';
        MetadataService.LayoutColumn newLayoutColumn = new MetadataService.LayoutColumn();
        MetadataService.LayoutItem newLayoutItem = new MetadataService.LayoutItem();
        newLayoutItem.field = 'TestField__c';
        newLayoutColumn.layoutItems = new List<MetadataService.LayoutItem> { newLayoutItem };
        newLayoutSection.layoutColumns = new List<MetadataService.LayoutColumn> { newLayoutColumn };
        layout.layoutSections.add(newLayoutSection);

        // Update the Layout
        handleSaveResults(
            service.updateMetadata(
                new MetadataService.Metadata[] { layout })[0]);
    }
    
    public static void deleteField(String fieldName)
    {
        MetadataService.MetadataPort service = createService();
        System.debug('Service Created.');
        List<MetadataService.DeleteResult> results =
            service.deleteMetadata(
                'CustomField', new String[] { 'Test__c.' + fieldName });
        System.debug('Field Deleted - ' + fieldName);
        handleDeleteResults(results[0]);
    }
    
    public static void updateFieldLevelSecurityForCustomer()
    {
        MetadataService.MetadataPort service = createService();
        System.debug('Service Created.');
        MetadataService.Profile cust = new MetadataService.Profile();
        cust.fullName = 'Customer';
        cust.custom = true;
        MetadataService.ProfileFieldLevelSecurity fieldSec = new MetadataService.ProfileFieldLevelSecurity();
        fieldSec.field='Test__c.Phone__c';
        fieldSec.readable = true;
        fieldSec.editable = false;
        cust.fieldPermissions  = new MetadataService.ProfileFieldLevelSecurity[] {fieldSec} ;
        System.debug('Building required metadata.');
        List<MetadataService.SaveResult> results =
            service.updateMetadata(
                new MetadataService.Metadata[] { cust });
        System.debug('Metadata created.');
        handleSaveResults(results[0]);
        System.debug('FLS created.');
    }
    
    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
    public static void handleSaveResults(MetadataService.SaveResult saveResult)
    {

        if(saveResult==null || saveResult.success)
            return;
        
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
    
    public static void handleDeleteResults(MetadataService.DeleteResult deleteResult)
    {
        // Nothing to see?
        if(deleteResult==null || deleteResult.success)
            return;
        // Construct error message and throw an exception
        if(deleteResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (deleteResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + deleteResult.fullName + '.');
            for(MetadataService.Error error : deleteResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!deleteResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
    
    public class MetadataServiceExamplesException extends Exception { }
}