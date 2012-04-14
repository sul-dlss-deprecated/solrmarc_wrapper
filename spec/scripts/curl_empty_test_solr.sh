curl "http://localhost:8983/solr/test/update?commit=true" -H "Content-Type: application/xml" --data-binary '<delete><query>*:*</query></delete>'
