#!/usr/bin/env bash

SDTH_JSONLD_FILE="data/sdth.jsonld"

# ------------------------------------------------------------------------------

bash_cell 'import sdth' << END_CELL

# Destroy the dataset
geist destroy --dataset kb --quiet

# Import the SDTH JSON-LD file
geist create --dataset kb --inputformat json-ld --inputfile ${SDTH_JSONLD_FILE} --infer owl

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query object names' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?s ?sname
    WHERE {
        ?s  sdth:hasName ?sname .
    } ORDER BY ?s ?sname
{% endquery %}
{% set res_df = res_str | json2df %}

Object Names:

{% for _, row in res_df.iterrows() %}
    {{ row.s }} has name {{ row.sname }}
{% endfor %}
    
__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'wasDerivedFrom query for variable name HHcatege' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?sname ?oname
    WHERE {
        ?s  sdth:wasDerivedFrom+ ?o .
        ?s  sdth:hasName ?sname .
        ?o  sdth:hasName ?oname .
        FILTER (?sname = "HHcateg")
    } ORDER BY ?sname ?oname
{% endquery %}
{% set res_df = res_str | json2df %}

wasDerivedFrom query for variable name HHcateg:

{% for _, row in res_df.iterrows() %}
    {{ row.sname }} is derived from {{ row.oname }}
{% endfor %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'has an impact on query for variable name PPHHSIZE' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?sname ?oname
    WHERE {
        ?s  sdth:wasDerivedFrom+ ?o .
        ?s  sdth:hasName ?sname .
        ?o  sdth:hasName ?oname .
        FILTER (?oname = "PPHHSIZE")
    } ORDER BY ?sname ?oname
{% endquery %}
{% set res_df = res_str | json2df %}

Has an impact on query for variable name PPHHSIZE:

{% for _, row in res_df.iterrows() %}
    {{ row.oname }} has an impact on {{ row.sname }}
{% endfor %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'ProgramSteps affecting variable name HHcateg' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT ?sname ?oname ?pscode
    WHERE {
        ?s  sdth:wasDerivedFrom+ ?o .
        ?s  sdth:hasName ?sname .
        ?o  sdth:hasName ?oname .
        ?pstep sdth:assignsVariable ?o.
        ?pstep sdth:hasSourceCode ?pscode.
        FILTER (?sname = "HHcateg")
    } ORDER BY ?sname ?oname ?pscode
{% endquery %}
{% set res_df = res_str | json2df %}

ProgramSteps affecting variable name HHcateg:

{% for _, row in res_df.iterrows() %}
    {{ row.sname }} is affected by {{ row.oname }} in command [{{ row.pscode }}]
{% endfor %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'Variables indirectly affected by ProgramStep ProgStep004' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?sname ?oname ?pscode
    WHERE {
        ?s  sdth:wasDerivedFrom+ ?o .
        ?s  sdth:hasName ?sname .
        ?o  sdth:hasName ?oname .
        
        {
            SELECT ?o  ?pscode
            WHERE {
                ?pstep sdth:assignsVariable ?o.
                ?pstep sdth:hasSourceCode ?pscode.
                FILTER (?pstep = sdtest:ProgStep004 )
            }
        }
    } ORDER BY ?sname ?oname ?pscode
{% endquery %}
{% set res_df = res_str | json2df %}

Variables indirectly affected by ProgramStep ProgStep004:

{% for _, row in res_df.iterrows() %}
    {{ row.sname }} is affected by {{ row.oname }}, which is modified in command [{{ row.pscode }}]
{% endfor %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'Find a File containing variable PPHHSIZE that is Loaded in the Program' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?sname ?pscode
    WHERE {
        ?s  sdth:hasVarInstance ?v .
        ?v  sdth:hasName 'PPHHSIZE' .
        ?ps  sdth:loadsFile ?s .
        ?ps sdth:hasSourceCode ?pscode .
        ?s sdth:hasName ?sname .
    } ORDER BY ?sname ?pscode
{% endquery %}
{% set res_df = res_str | json2df %}

Find a File containing variable PPHHSIZE that is Loaded in the Program:

{% for _, row in res_df.iterrows() %}
    Command [{{ row.pscode }}] loads {{ row.sname }} containing variable 'PPHHSIZE'
{% endfor %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'elaborationOf query for variable name HHcateg' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?s ?o ?sname ?oname ?pscode
    WHERE {
        ?s sdth:elaborationOf+ ?o .
		?s sdth:hasName ?sname .
		?o sdth:hasName ?oname .
	    ?pstep sdth:usesVariable ?o.
        ?pstep sdth:hasSDTL ?pscode.
        FILTER (?sname = "HHcateg")
    } ORDER BY ?s ?o ?sname ?oname ?pscode
{% endquery %}
{% set res_df = res_str | json2df %}

elaborationOf query for variable name HHcateg:

{% for _, row in res_df.iterrows() %}
    {{ row.s }} named {{ row.sname }} is elaboration of {{ row.o }} named {{ row.oname }} in command {{ row.pscode }}
{% endfor %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'usesVariable query for variable name PPHHSIZE' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?psource ?oname
    WHERE {
        ?pstep sdth:usesVariable+ ?o .
		?pstep sdth:hasSourceCode ?psource .
		?o sdth:hasName ?oname .
        FILTER (?oname = "PPHHSIZE")
    } ORDER BY ?psource ?oname
{% endquery %}
{% set res_df = res_str | json2df %}

usesVariable query for variable name PPHHSIZE:

{% for _, row in res_df.iterrows() %}
    Command [{{ row.psource }}] is affected by {{ row.oname }}
{% endfor %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'usesVariable query for indirect effects of variable name PPHHSIZE' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?psource ?sname ?oname
    WHERE {
        ?pstep  sdth:usesVariable+ ?s .
		?pstep  sdth:hasSourceCode ?psource .
	  
		{
            SELECT distinct  ?s  ?sname ?oname
            WHERE {
                ?s  sdth:wasDerivedFrom+ ?o .
                ?s  sdth:hasName ?sname .
                ?o  sdth:hasName ?oname .
                FILTER (?oname = "PPHHSIZE" )  
            }
        }
    } ORDER BY ?psource ?sname ?oname
{% endquery %}
{% set res_df = res_str | json2df %}

usesVariable query for indirect effects of variable name PPHHSIZE:

{% for _, row in res_df.iterrows() %}
    Command [{{ row.psource }}] is affected by {{ row.sname }} which is affected by {{ row.oname }}
{% endfor %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'usesVariable query DIRECT AND INDIRECT for variable name PPHHSIZE' << END_CELL

geist report << __END_TEMPLATE__

{% query isfilepath=False as res_str %}
    PREFIX sdth: <http://DDI/SDTH/>
    PREFIX sdtest: <http://test/#>	

    SELECT distinct ?psource ?oname
	WHERE {
		{
			?pstep  sdth:usesVariable+ ?o .
			?pstep  sdth:hasSourceCode ?psource .
			?o  sdth:hasName ?oname .
			FILTER (?oname = "PPHHSIZE")
		}

		UNION

		{
			?pstep  sdth:usesVariable+ ?s2 .
			?pstep  sdth:hasSourceCode ?psource .
		  
			{
                SELECT distinct  ?s2   ?oname
			    WHERE {
                    ?s2  sdth:wasDerivedFrom+ ?o2 .
                    ?s2  sdth:hasName ?oname .
                    ?o2  sdth:hasName ?o2name .
                    FILTER (?o2name = "PPHHSIZE" )  
                }
			}
		}
	} ORDER BY ?psource ?oname
{% endquery %}
{% set res_df = res_str | json2df %}

usesVariable query DIRECT AND INDIRECT for variable name PPHHSIZE:

{% for _, row in res_df.iterrows() %}
    Command [{{ row.psource }}] is affected by {{ row.oname }}
{% endfor %}

{% destroy dataset="kb" %}

__END_TEMPLATE__

END_CELL

# ------------------------------------------------------------------------------
