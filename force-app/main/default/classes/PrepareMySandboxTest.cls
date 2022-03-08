@isTest class PrepareMySandboxTest {
    @isTest static void testMySandboxPrep() {
        Test.startTest();
        Test.testSandboxPostCopyScript(
            new PrepareMySandbox(),
            UserInfo.getOrganizationId(),
            UserInfo.getOrganizationId(),
            UserInfo.getOrganizationName()
        );
        Test.stopTest();
        System.assertEquals(50, [select count() from Account]);
        System.assertEquals(300, [select count() from Contact where AccountId <> null]);
    }
}