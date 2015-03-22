This project aimed to format the data from Human Activity Recognition Use
Smartphones Dataset as tidy dataset.

The script to format the data is run_analysis.R. The script expect that the data
are unzip in "UCI HAR Dataset" folder. In case of an other directory change the
folder variable on ligne 2.

An uncomprerssed version of the data are present in the "UCI HAR Dataset"
folder.

The script first load the needed datasets from train and test subfolder: 
  - subject for subject doing the experiment
  - y for action done by the subject
  - X the measurements

The data are then rearanged:
  - the 6 datasets are then fused together in one dataset.
  - the columns names are then adjust to miningfull name.
  - the column that contain mean or std are then identified and a new dataset that
    contain them is generated.
  - on this dataset, format the activity columns to have meaning full name.

Finally reformat the dataset as tidy with only the mean data. This final dataset
is saved tidy_data.txt. The detail of the data format in this file is detailled
in the CodeBook.md file.
