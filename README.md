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
```
sdth-demos$ make clean-demo
------- Cleaning example 01-python/ ----------------
removed './run.txt'
removed './products/SmallTestMerged.csv'
rmdir: removing directory, './products'

------- Cleaning example 02-sdth-queries/ ----------------
removed './run.txt'

------- Cleaning example 03-sdth-validation/ ----------------
removed './run.txt'
removed './products/error_added_sdth.png'
removed './products/error_added_sdth.txt'
removed './products/sdth.png'
rmdir: removing directory, './products'
```

Confirm with `git status` that version-controlled files have been deleted locally:
```
sdth-demos$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    demo/01-python/products/SmallTestMerged.csv
        deleted:    demo/01-python/run.txt
        deleted:    demo/02-sdth-queries/run.txt
        deleted:    demo/03-sdth-validation/products/error_added_sdth.png
        deleted:    demo/03-sdth-validation/products/error_added_sdth.txt
        deleted:    demo/03-sdth-validation/products/sdth.png
        deleted:    demo/03-sdth-validation/run.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Now run the demonstration with the `make run-demo` command:
```
sdth-demos$ make run-demo
---------- Running example 01-python/ -------------

---------- Running example 02-sdth-queries/ -------------

---------- Running example 03-sdth-validation/ -------------
```

Finally, use `git status` to confirm that the demostration products have been restored:
```
sdth-demo$ 
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

## Running a single example

An individual example within the demonstration can be run by starting an interactive REPRO session.

First start the REPRO in interactive mode using the `make start-repro` command (or the shorthand `make start`).
```
sdth-demo$ make start-repro
repro@f5322e10343e:/mnt/sdth-demos$ 
```

Set the working directory to a particular example directory: (take __01-python__ as an example)
```
repro@f5322e10343e:/mnt/sdth-demos$ cd demo/01-python/
repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ 

repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ pwd
/mnt/sdth-demos/demo/01-python
```

Type `make` to run the example:
```
repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ make
bash run.sh > run.txt
```

Use the `tree` command to list the files associated with the example, including the temporary files in the `tmp` subdirectory:
```
repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ tree
.
|-- Makefile
|-- data
|   |-- SmallTestPersonal.csv
|   `-- SmallTestPolitical.csv
|-- products
|   `-- SmallTestMerged.csv
|-- run.sh
|-- run.txt
`-- tmp
    |-- add the hhcateg column.sh
    |-- add the hhcateg column.txt
    |-- add the hhsize column.sh
    |-- add the hhsize column.txt
    |-- load personal data.sh
    |-- load personal data.txt
    |-- load political data.sh
    |-- load political data.txt
    |-- merge the personal data and the political data.sh
    |-- merge the personal data and the political data.txt
    |-- save the merged data.sh
    `-- save the merged data.txt

3 directories, 18 files
```

The `make clean` command deletes the temporary files, the example output file, `run.txt`, and the products folder:
```
repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ make clean
if [[ -f ./"run.txt" ]] ; then                       \
    rm -v ./"run.txt" ;                              \
fi
removed './run.txt'
if [[ -d ./"tmp" ]] ; then                              \
    rm -vf ./"tmp"/* ;                            \
    rmdir -v ./"tmp" ;                            \
fi
removed './tmp/add the hhcateg column.sh'
removed './tmp/add the hhcateg column.txt'
removed './tmp/add the hhsize column.sh'
removed './tmp/add the hhsize column.txt'
removed './tmp/load personal data.sh'
removed './tmp/load personal data.txt'
removed './tmp/load political data.sh'
removed './tmp/load political data.txt'
removed './tmp/merge the personal data and the political data.sh'
removed './tmp/merge the personal data and the political data.txt'
removed './tmp/save the merged data.sh'
removed './tmp/save the merged data.txt'
rmdir: removing directory, './tmp'
if [[ -d ./"products" ]] ; then                       \
    rm -vf ./"products"/* ;                           \
    rmdir -v ./"products" ;                           \
fi
removed './products/SmallTestMerged.csv'
rmdir: removing directory, './products'

repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ tree
.
|-- Makefile
|-- data
|   |-- SmallTestPersonal.csv
|   `-- SmallTestPolitical.csv
`-- run.sh
1 directory, 4 files
```

Confirm that the `run.txt` file and the `products` folder are the version-controlled files associated with this example that has been deleted:
```
repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ git status .
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    products/SmallTestMerged.csv
        deleted:    run.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Re-run the and confirm the `run.txt` file was restored:
```
repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ make
bash run.sh > run.txt

repro@f5322e10343e:/mnt/sdth-demos/demo/01-python$ git status .
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```
