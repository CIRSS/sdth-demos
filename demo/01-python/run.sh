#!/usr/bin/env bash

# ------------------------------------------------------------------------------

bash_cell 'load political data' << END_CELL

python << END_PYTHON

import pandas as pd

PoliticalData = pd.read_csv("data/SmallTestPolitical.csv")
print(PoliticalData)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'load personal data' << END_CELL

python << END_PYTHON

import pandas as pd

PersonalData = pd.read_csv("data/SmallTestPersonal.csv")
print(PersonalData)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'add the hhsize column' << END_CELL

python << END_PYTHON

import pandas as pd

PersonalData = pd.read_csv("data/SmallTestPersonal.csv")
PersonalData = PersonalData.assign(HHsize=PersonalData['PPHHSIZE'])
print(PersonalData)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'add the hhcateg column' << END_CELL

python << END_PYTHON

import pandas as pd

PersonalData = pd.read_csv("data/SmallTestPersonal.csv")
PersonalData = PersonalData.assign(HHsize=PersonalData['PPHHSIZE'])
PersonalData['HHcateg'] = pd.cut(PersonalData['HHsize'], [1, 2, 3, 5, 7, 10, 999], include_lowest=True, right=False, labels=['1', '2', '3-4', '5-6', '7-9', '10+'])
print(PersonalData)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'merge the personal data and the political data' << END_CELL

python << END_PYTHON

import pandas as pd

PoliticalData = pd.read_csv("data/SmallTestPolitical.csv")
PersonalData = pd.read_csv("data/SmallTestPersonal.csv")
PersonalData   = PersonalData.assign(HHsize=PersonalData['PPHHSIZE'])
PersonalData['HHcateg'] = pd.cut(PersonalData['HHsize'], [1, 2, 3, 5, 7, 10, 999], include_lowest=True, right=False, labels=['1', '2', '3-4', '5-6', '7-9', '10+'])
MergedData = PersonalData.merge(PoliticalData, on="ID", how="inner")
print(MergedData)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'save the merged data' << END_CELL

python << END_PYTHON

import pandas as pd

PoliticalData = pd.read_csv("data/SmallTestPolitical.csv")
PersonalData = pd.read_csv("data/SmallTestPersonal.csv")
PersonalData   = PersonalData.assign(HHsize=PersonalData['PPHHSIZE'])
PersonalData['HHcateg'] = pd.cut(PersonalData['HHsize'], [1, 2, 3, 5, 7, 10, 999], include_lowest=True, right=False, labels=['1', '2', '3-4', '5-6', '7-9', '10+'])
MergedData = PersonalData.merge(PoliticalData, on="ID", how="inner")
MergedData.to_csv("products/SmallTestMerged.csv", index=False)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------