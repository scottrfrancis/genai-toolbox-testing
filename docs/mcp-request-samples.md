=== Sample MCP Request Sessions ===

Date: Tue Dec 23 11:44:28 PST 2025

### 1. Initialize Session (tools/list)
```json
REQUEST:
{"jsonrpc":"2.0","method":"tools/list","id":1}

RESPONSE:
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "tools": [
      {
        "name": "list-tables",
        "description": "List all user tables in the database",
        "inputSchema": {
          "type": "object",
          "properties": {},
          "required": []
        }
      },
      {
        "name": "describe-table",
        "description": "Get column details for a specific table",
        "inputSchema": {
          "type": "object",
          "properties": {
            "table_name": {
              "type": "string",
              "description": "Name of the table to describe"
            }
          },
          "required": [
            "table_name"
          ]
        }
      },
      {
        "name": "run-query",
        "description": "Run a read-only SQL query against the database",
        "inputSchema": {
          "type": "object",
          "properties": {
            "query": {
              "type": "string",
              "description": "The SQL query to execute"
            }
          },
          "required": [
            "query"
          ]
        }
      }
    ]
  }
}
```

### 2. list-tables Tool Call
```json
REQUEST:
{"jsonrpc":"2.0","method":"tools/call","params":{"name":"list-tables","arguments":{}},"id":2}

RESPONSE:
{
  "jsonrpc": "2.0",
  "id": 2,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "{\"TABLE_NAME\":\"CarReport\",\"TABLE_SCHEMA\":\"dbo\"}"
      },
      {
        "type": "text",
        "text": "{\"TABLE_NAME\":\"TransactionReport\",\"TABLE_SCHEMA\":\"dbo\"}"
      }
    ]
  }
}
```

### 3. describe-table Tool Call
```json
REQUEST:
{"jsonrpc":"2.0","method":"tools/call","params":{"name":"describe-table","arguments":{"table_name":"CarReport"}},"id":3}

RESPONSE:
{
  "jsonrpc": "2.0",
  "id": 3,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":50,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"CaseID\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"NO\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"CaseNo\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":50,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PatientState\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"SampleType\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"SubSampleType\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PrimaryInsurance\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"SecondaryInsurance\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"FinancialClass\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PlanType\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Physician\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":50,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"ProviderState\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PracticeName\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":50,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PracticeState\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":150,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Provider_Specialty\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":150,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"AccountManager\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":150,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Regional_Director\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":150,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"AVP\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"DOS\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"EnterDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"BillingDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"RebillDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"RemitDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":-1,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"CheckNumber\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Charge\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Allowed\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"TotalPaid\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"ExpectedReimbursement\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"TotalAdj\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"TotalPR\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PaidToPatient\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"InsurancePaid\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"InsuranceBalance\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PatientPaid\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PatientBalance\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"COGS\",\"DATA_TYPE\":\"decimal\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"DenialCode\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"LatestCarcCode\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":10,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Adjudicated\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":-1,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Deficiency\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":-1,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Rejected\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":-1,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Hold\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Status\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Substatus\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":1000,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"DxCode\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":1000,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"CPTCodes\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"ReferenceLab\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"FacilityName\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":1000,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Remarks\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"MrUploadDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Appeal_Submit_Date\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PatientStatementStatus\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"InsurancePaymentDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PatientPaymentDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"PostingDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":10,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"WriteOff\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"MRN\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":-1,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"EDI_Remark_Code\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"ImportDate\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"ImportTime\",\"DATA_TYPE\":\"time\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Ever_In_Deficiency\",\"DATA_TYPE\":\"bit\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":500,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Tags\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Network_Status\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Denial_Category\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Denial_Classification\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"LR_Category\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":200,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"LR_Classification\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":500,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Parent_Def_Reason\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":500,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Remittance_Remark_Codes\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":null,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Secondary_Billing_Date\",\"DATA_TYPE\":\"date\",\"IS_NULLABLE\":\"YES\"}"
      },
      {
        "type": "text",
        "text": "{\"CHARACTER_MAXIMUM_LENGTH\":100,\"COLUMN_DEFAULT\":null,\"COLUMN_NAME\":\"Electronic_Order\",\"DATA_TYPE\":\"varchar\",\"IS_NULLABLE\":\"YES\"}"
      }
    ]
  }
}
```

### 4. run-query Tool Call (SELECT)
```json
REQUEST:
{"jsonrpc":"2.0","method":"tools/call","params":{"name":"run-query","arguments":{"query":"SELECT TOP 5 SampleType, COUNT(*) as cnt FROM CarReport GROUP BY SampleType ORDER BY cnt DESC"}},"id":4}

RESPONSE:
{
  "jsonrpc": "2.0",
  "id": 4,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "{\"SampleType\":\"Path\",\"cnt\":405046}"
      },
      {
        "type": "text",
        "text": "{\"SampleType\":\"URINE UTI-ID\",\"cnt\":200205}"
      },
      {
        "type": "text",
        "text": "{\"SampleType\":\"Wound-ID\",\"cnt\":144311}"
      },
      {
        "type": "text",
        "text": "{\"SampleType\":\"Derm - ID\",\"cnt\":84621}"
      },
      {
        "type": "text",
        "text": "{\"SampleType\":\"RESPIRA-ID\",\"cnt\":67613}"
      }
    ]
  }
}
```
