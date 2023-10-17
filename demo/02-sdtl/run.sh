#!/usr/bin/env bash

SDTL_JSONLD_FILE="data/sdtl.jsonld"

# ------------------------------------------------------------------------------

bash_cell 'import sdtl' << END_CELL

# Destroy the dataset
geist destroy --dataset kb --quiet

# Import the SDTL JSON-LD file
geist create --dataset kb --inputformat json-ld --inputfile ${SDTL_JSONLD_FILE} --infer owl

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'export sdtl as ntriples' << END_CELL

# Export as N-TRIPLES
geist export --dataset kb --outputformat nt | sort

# Destroy the dataset
geist destroy --dataset kb

END_CELL

# ------------------------------------------------------------------------------