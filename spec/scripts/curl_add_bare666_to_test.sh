curl "http://localhost:8983/solr/test/update?commit=true" -H "Content-Type: text/xml" --data-binary @spec/fixtures/add_solrdoc_bare666.xml
