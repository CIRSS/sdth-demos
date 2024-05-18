#!/usr/bin/env bash

SDTH_JSONLD_FILE_1="data/sdth1.jsonld"
SDTH_JSONLD_FILE_2="data/sdth2.jsonld"
SDTH_JSONLD_FILE_3="data/sdth3.jsonld"

# ------------------------------------------------------------------------------

bash_cell 'sdth1' << END_CELL

# Destroy the dataset
geist destroy --dataset kb --quiet

# Import the SDTH JSON-LD file
geist create --dataset kb --inputformat json-ld --inputfile ${SDTH_JSONLD_FILE_1} --infer none

# Export all triples
geist export --dataset kb --outputformat nt | sort

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'sdth2' << END_CELL

# Destroy the dataset
geist destroy --dataset kb --quiet

# Import the SDTH JSON-LD file
geist create --dataset kb --inputformat json-ld --inputfile ${SDTH_JSONLD_FILE_2} --infer none

# Export all triples
geist export --dataset kb --outputformat nt | sort

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'sdth3' << END_CELL

# Destroy the dataset
geist destroy --dataset kb --quiet

# Import the SDTH JSON-LD file
geist create --dataset kb --inputformat json-ld --inputfile ${SDTH_JSONLD_FILE_3} --infer none

# Export all triples
geist export --dataset kb --outputformat nt | sort

# Destroy the dataset
geist destroy --dataset kb

END_CELL

# ------------------------------------------------------------------------------


