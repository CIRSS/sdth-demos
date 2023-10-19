#!/usr/bin/env bash

SDTH_JSONLD_FILE="data/sdth.jsonld"
ERROR_ADDED_SDTH_TTL_FILE="data/error_added_sdth.ttl"
SDTH_SCHEMA_PATH="data/sdth.schema.ttl"
MAPPINGS_PATH="data/mappings.json"

# ------------------------------------------------------------------------------

bash_cell 'sdth validation' << END_CELL

rdfvr -f ${SDTH_JSONLD_FILE} -s ${SDTH_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/sdth -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'error added sdth validation png' << END_CELL

rdfvr -f ${ERROR_ADDED_SDTH_TTL_FILE} -ff turtle -s ${SDTH_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/error_added_sdth -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'error added sdth validation txt' << END_CELL

rdfvr -f ${ERROR_ADDED_SDTH_TTL_FILE} -ff turtle -s ${SDTH_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/error_added_sdth -of txt

END_CELL

# ------------------------------------------------------------------------------