===

Code Book

====

Description of steps taken to get tidy data:

0. In 0th step of getting and cleaning this data packages needed for the analysis are installed and working directory was set

1. The data was imported from the downloaded forlder

2. In the preparation step, variables were named according to the IDs provided within assignment. This means:
    - X variables were names according to names provided in features file
    - y variable was named "activity" and subject variable was named "subject"
    - activity (y) variable was converted into factor variable according to the levels provided in activity_labels

3. Data frames of X variables, y (activity) variable and subject variable were combined by row into new data frame test/train and new variable status was added to indicate weather observation belongs to training or test dataset
    - Furthermore training and test set were combined by rows in new all.data dataframe that contains all observations and all variables
    - And finally only variables that represent mean or standard deviation (along with status, subject and activity) were subselected from the all.data into all.data.subset
    
4. Using dplyr all variables (except status) were summarized as mean by each activity and each subject

5. Tidy data was saved in txt file tidy_data.txt

===

The exported tidy_data.txt contains 68 variables on 180 observations. 180 observations represent each of 30 subject included in experiment and 6 different activities that each subject did (6*30=180). 68 variables represent either averages or standard deviations of certain measurments. Finally it is important to emphasize that this are means of each variable by every subject and activity. Units of the variables remained the same as in raw dataset.

===

More information can be also found in:

- READNE.md file

===
