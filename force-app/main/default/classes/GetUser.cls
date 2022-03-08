public with sharing class GetUser {
    @AuraEnabled
    public static list<string> getCurrentUser() {
        system.debug('User Id: ' + UserInfo.getUserId());
        system.debug('User Name: ' + UserInfo.getName());

        return new list<string>{UserInfo.getUserId(), UserInfo.getName()};
    }
}