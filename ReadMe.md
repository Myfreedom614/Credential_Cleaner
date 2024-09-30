Delete Unuseful Windows Crenditals

1. Execute ```export_tokens.bat``` to generate **tokensonly.txt** file.
2. Execute ```.\token_keywords_check.ps1 -keywords "retail,sbx1,sbx2"```, will generate three files:
   1. tokens_not_contains_keywords.txt
   2. tokens_contains_keywords.txt
   3. tokens_not_XblGrts.txt
3. Execute ```delete_tokens.bat```, will read the **tokens_not_contains_keywords.txt** file and delete credentials.