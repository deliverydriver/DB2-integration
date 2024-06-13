@IsTest
public class DB2IntegrationTest {
    @IsTest
    static void testFetchDataFromDB2() {
        Test.startTest();
        
        // Mock HTTP Response
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('[{"id":"1","name":"Record 1","otherField":"Value 1"},{"id":"2","name":"Record 
2","otherField":"Value 2"}]');
        
        // Mocking the HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(response));
        
        // Fetch data
        List<DB2_Record__c> records = DB2Integration.fetchDataFromDB2();
        
        Test.stopTest();
        
        System.assertEquals(2, records.size());
        System.assertEquals('Record 1', records[0].Name);
        System.assertEquals('1', records[0].DB2_Id__c);
    }
    
    @IsTest
    static void testUpsertRecords() {
        Test.startTest();
        
        // Mock HTTP Response
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('[{"id":"1","name":"Record 1","otherField":"Value 1"},{"id":"2","name":"Record 
2","otherField":"Value 2"}]');
        
        // Mocking the HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(response));
        
        // Upsert records
        DB2Integration.upsertRecords();
        
        // Verify records are upserted
        List<DB2_Record__c> records = [SELECT Name, DB2_Id__c FROM DB2_Record__c];
        System.assertEquals(2, records.size());
        System.assertEquals('Record 1', records[0].Name);
        System.assertEquals('1', records[0].DB2_Id__c);
        
        Test.stopTest();
    }
}

public class MockHttpResponseGenerator implements HttpCalloutMock {
    private HttpResponse mockResponse;
    
    public MockHttpResponseGenerator(HttpResponse response) {
        this.mockResponse = response;
    }
    
    public HttpResponse respond(HttpRequest request) {
        return mockResponse;
    }
}

