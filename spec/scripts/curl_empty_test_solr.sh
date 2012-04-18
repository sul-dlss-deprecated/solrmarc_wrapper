curl "http://localhost:8984/solr/test/update?commit=true" -H "Content-Type: application/xml" --data-binary '<delete><query>*:*</query></delete>'
