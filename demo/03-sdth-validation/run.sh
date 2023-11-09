#!/usr/bin/env bash

SDTH_JSONLD_FILE="data/sdth.jsonld"
ERROR_ADDED_SDTH_TTL_FILE="data/error_added_sdth.ttl"
SDTH_SCHEMA_PATH="data/sdth.schema.ttl"
MAPPINGS_PATH="data/mappings.json"

TEST_JSONLD_FILE_1="data/test1.jsonld"
TEST_JSONLD_FILE_2="data/test2.jsonld"

# ------------------------------------------------------------------------------

bash_cell 'sdth validation' << END_CELL

rdfvr -f ${SDTH_JSONLD_FILE} -s ${SDTH_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'error added sdth validation png' << END_CELL

rdfvr -f ${ERROR_ADDED_SDTH_TTL_FILE} -ff turtle -s ${SDTH_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/error_added_sdth -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'error added sdth validation txt' << END_CELL

rdfvr -f ${ERROR_ADDED_SDTH_TTL_FILE} -ff turtle -s ${SDTH_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'test reverse predicate' << END_CELL

echo "Test JSON-LD File"
echo "-----------------"
cat ${TEST_JSONLD_FILE_1}

echo ""
echo "Validation Report"
echo "-----------------"
rdfvr -f ${TEST_JSONLD_FILE_1} -s ${SDTH_SCHEMA_PATH} -m ${MAPPINGS_PATH}

echo "*****************************************************************"

echo "Test JSON-LD File"
echo "-----------------"
cat ${TEST_JSONLD_FILE_2}

echo ""
echo "Validation Report"
echo "-----------------"
rdfvr -f ${TEST_JSONLD_FILE_2} -s ${SDTH_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------
