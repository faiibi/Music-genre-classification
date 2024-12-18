![alt text]([https://github.com/[username]/[reponame]/blob/[branch]/image.jpg?raw=true](https://github.com/faiibi/Music-genre-classification/blob/main/Music-genres-image-thumb.jpg))


# Music-genre-classification
 Table of Contents
 
	•	Introduction
	•	Dataset
	•	Objectives
	•	Data Preprocessing
	•	Classification Task
	•	Results
	•	Dependencies
	•	Usage
	•	Conclusion


## Introduction

Music is an integral part of human culture and comes in various genres. The classification of music genres plays a significant role in music information retrieval systems, particularly for music streaming platforms that personalize playlists for users.

This project focuses on automating music genre classification using the Decision Tree method in R. The classification is based on the textual and numeric features of music tracks.


## Dataset

The dataset used for this project is sourced from Kaggle, specifically a music genre classification dataset:

	•	Format: CSV (Comma-Separated Values)
	•	Size: 3,270 rows and 17 columns
	•	Target Variable: Class (3 genres: Acoustic Folk, Alt Music, and Blues)

Features:

<table>
  <tr>
    <th>Feature</th>
    <th>Data Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Artist Name</td>
    <td>Nominal</td>
    <td>Name of the artist</td>
  </tr>
  <tr>
    <td>Track Name</td>
    <td>Nominal</td>
    <td>Name of the track</td>
  </tr>
   <tr>
    <td>Popularity</td>
    <td>Discrete</td>
    <td>Popularity score</td>
  </tr>
    <tr>
    <td>Danceability</td>
    <td>Continuous</td>
    <td>Danceability score</td>
  </tr>
   <tr>
    <td>Energy</td>
    <td>Continuous</td>
    <td>Energy of the song</td>
  </tr>
  <tr>
    <td>Loudness</td>
    <td>Continuous</td>
    <td>Volume level of the track</td>
  </tr>
   <tr>
    <td>Acousticness</td>
    <td>Continuous</td>
    <td>Acoustic quality</td>
  </tr>
    <tr>
    <td>Instrumentalness</td>
    <td>Continuous</td>
    <td>Instrumental components</td>
  </tr>
     <tr>
    <td>Liveness</td>
    <td>Continuous</td>
    <td>Presence of audience</td>
  </tr>
   <tr>
    <td>Valence</td>
    <td>Continuous</td>
    <td>Positivity of track</td>
  </tr>
  <tr>
    <td>Duration</td>
    <td>Continuous</td>
    <td>Length of track</td>
  </tr>
   <tr>
    <td>Class</td>
    <td>Categorical</td>
    <td>Genre (0, 1, or 2)</td>
  </tr>
</table>


## Objectives

The objectives of this project are:

	1.	Inspect and clean the dataset.
	2.	Preprocess the dataset (handling missing values, outliers, and skewness).
	3.	Develop a Decision Tree model for classification.
	4.	Evaluate and optimize the model’s performance.

## Data Preprocessing

Several preprocessing steps were applied to clean and prepare the dataset for analysis:

	1.	Cleaning Variable Names: Using the janitor and tidyverse packages to clean and simplify column names.
	2.	Handling Missing Values: Replaced missing values in the Popularity, Key, and Instrumentalness columns with 0.
	3.	Outlier Detection and Treatment: Outliers were identified using boxplots and treated with Winsorization.
	4.	Skewness Correction: Variables with large skewness were corrected to ensure a more symmetrical distribution.

## Classification Task

The Decision Tree model was implemented using the Rpart package in R:

	1.	Feature Selection: Variables with the highest Gini Index were selected for the model:
	•	Duration, Acousticness, Popularity, Energy, Valence, Loudness, Instrumentalness, Speechiness, Time, Liveness
	2.	Model Splitting: Data was split into 80% training and 20% testing datasets.
	3.	Model Creation: The decision tree was trained using the training dataset.

 ## Results
	1.	Model Accuracy:
	•	Training Accuracy: 80.9%
	•	Testing Accuracy: 77.3%
	2.	Pruned Tree:
	•	Optimizing the tree complexity parameter (CP) improved accuracy to 80% with reduced splits.
 
## Dependencies

This project requires the following R libraries:

	•	tidyverse
	•	janitor
	•	dplyr
	•	skimr
	•	rpart
	•	rpart.plot

## Conclusion

The Decision Tree model effectively classifies music genres with an accuracy of up to 80%. The project demonstrates the importance of proper preprocessing and parameter tuning in achieving optimal results.

Future improvements could include:

	•	Using ensemble methods (e.g., Random Forest, Gradient Boosting) for better accuracy.
	•	Expanding the dataset to include additional genres.
