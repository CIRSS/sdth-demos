# SDTH Demonstration

This repository demonstrates the _Structured Data Transformation History_ (__SDTH__) for describing and querying programs that modify data used for statistical analysis.

This repository is itself structured as a _Reproducible Every-Place Research Object_ (__REPRO__). It is associated with a public Docker image that aims to enable the the products of the demonstration to be reproduced at a Unix-like shell prompt on any computer that has Git, GNU Make, and Docker installed.

Make commands issued in the top-level directory are used to obtain the Docker image and run the demos.

## Setup the environment

First build the REPRO's docker image using `make build-image` (or the shorthand `make image`).

Then start the REPRO in interactive mode using the `make start-repro` command (or the shorthand `make start`) and install the related Python packages using the `pip install .` command.

Finally, exit the REPRO using the `exit` command.

## Run and confirm the reproducibility of the demonstration

The demonstration and its products are stored in the `demo` directory tree:
```
demo
├── 01-python
│   ├── Makefile
│   ├── data
│   │   ├── SmallTestPersonal.csv
│   │   └── SmallTestPolitical.csv
│   ├── products
│   │   └── SmallTestMerged.csv
│   ├── run.sh
│   ├── run.txt
│   └── tmp
│       ├── add the hhcateg column.sh
│       ├── add the hhcateg column.txt
│       ├── add the hhsize column.sh
│       ├── add the hhsize column.txt
│       ├── load personal data.sh
│       ├── load personal data.txt
│       ├── load political data.sh
│       ├── load political data.txt
│       ├── merge the personal data and the political data.sh
│       ├── merge the personal data and the political data.txt
│       ├── save the merged data.sh
│       └── save the merged data.txt
.
. (additional output removed for brevity)
.
├── 03-sdth-validation
│   ├── Makefile
│   ├── data
│   │   ├── error_added_sdth.ttl
│   │   ├── mappings.json
│   │   ├── sdth.jsonld
│   │   └── sdth.schema.ttl
│   ├── products
│   │   ├── error_added_sdth.png
│   │   ├── error_added_sdth.txt
│   │   └── sdth.png
│   ├── run.sh
│   ├── run.txt
│   └── tmp
│       ├── error added sdth validation png.sh
│       ├── error added sdth validation png.txt
│       ├── error added sdth validation txt.sh
│       ├── error added sdth validation txt.txt
│       ├── sdth validation.sh
│       └── sdth validation.txt
└── Makefile
```

Below gives a brief description of these demonstrations:
- __01-python__: run an example python data transformation script and print the results step by step.
- __02-sdth-queries__: query the __01-python__'s _Structured Data Transformation History_ (__SDTH__).
- __03-sdth-validation__: validate the __01-python__'s SDTH JSON-LD file. Furthermore, an error added SDTH turtle file was tested.

To establish that the demonstrations can be reproduced, first use the `make clean-demo` command to delete the files produced by the demo:

