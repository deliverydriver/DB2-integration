public class DB2Integration {
    private static final String DB2_ENDPOINT = 'https://******.com/api/data';
    private static final String DB2_API_KEY = '******'; // Replace with your actual API key

    // Method to fetch data from DB2
    public static List<DB2_Record__c> fetchDataFromDB2() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(DB2_ENDPOINT);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + DB2_API_KEY); // If authorization is needed
        
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            List<DB2_Record__c> records = parseDB2Response(response.getBody());
            return records;
        } else {
            System.debug('Failed to fetch data from DB2. Status: ' + response.getStatus());
            return new List<DB2_Record__c>();
        }
    }

    // Method to parse the DB2 response
    private static List<DB2_Record__c> parseDB2Response(String responseBody) {
        // Assuming response is in JSON format. Parse accordingly.
        List<DB2_Record__c> records = new List<DB2_Record__c>();
        
        // Mock parsing - Replace with actual parsing logic
        List<Map<String, Object>> db2Data = (List<Map<String, Object>>) 
JSON.deserializeUntyped(responseBody);
        for (Map<String, Object> data : db2Data) {
            DB2_Record__c record = new DB2_Record__c();
            record.Name = (String) data.get('name');
            record.DB2_Id__c = (String) data.get('id');
            record.Other_Field__c = (String) data.get('otherField');
            records.add(record);
        }

        return records;
    }

    // Method to upsert (insert or update) records in Salesforce
    public static void upsertRecords() {
        List<DB2_Record__c> db2Records = fetchDataFromDB2();
        if (!db2Records.isEmpty()) {
            upsert db2Records DB2_Id__c;
        }
    }
}

