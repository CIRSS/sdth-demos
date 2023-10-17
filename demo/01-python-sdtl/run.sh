#!/usr/bin/env bash

SDTL_JSONLD_FILE="data/sdtl.jsonld"

# ------------------------------------------------------------------------------

bash_cell 'import sdtl' << END_CELL

# Destroy the dataset
geist destroy --dataset kb --quiet

# Import the SDTL JSON-LD file and export as N-TRIPLES
geist create --dataset kb --inputformat json-ld --inputfile ${SDTL_JSONLD_FILE} --infer owl

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'query sdtl sname' << END_CELL

geist query << __END_QUERY__

PREFIX sdth: <http://DDI/SDTH/>
PREFIX sdtest: <http://test/#>	

SELECT distinct  ?s ?sname
WHERE {
    ?s  sdth:hasName ?sname .
}
    
__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

