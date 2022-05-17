#This project aims to create a decision tree to classify the genre a music 
#belongs to. There are 11 genres ranging from class 0- 10. Using rpart, we would
#create a model that would classify each song into one of the 11 genres.

#importing all the necessary packages and libraries
install.packages("janitor")
library(janitor)
install.packages("tidyverse")
library(tidyverse)
install.packages("skimr")
library(skimr)
install.packages('moments')
library(moments)
install.packages("rpart")
library(rpart)
install.packages('CORElearn')
library(CORElearn)
install.packages("tree")
library(tree)
library(rpart.plot)
library(RColorBrewer)
install.packages('rattle')
library(rattle)
install.packages('caret')
library(caret)



#import dataset in csv format 
music_gen <- read.csv("music_genre.csv", header = TRUE)

#inspect dataset features 
names(music_gen)
head(music_gen)
tail(music_gen)
str(music_gen)
summary(music_gen)

#inspect number of rows in dataset
nrow(music_gen)
#inspect number of columns in dataset
ncol(music_gen)
#inspect dimensions of dataset
dim(music_gen)

#view frequency of target variable
table(music_gen$Class)
barplot(table(music_gen$Class), col = c("#eb8060", "#b9e38d", "#a1e9f0", "#d9b1f0"))

#clean variable names
music_gen<- music_gen %>% 
  janitor::clean_names()

#inspect new variable names
names(music_gen)

boxplot(music_gen$duration)

#rename duration_in_min_ms to duration 
music_gen<- music_gen %>% 
  rename("duration" = "duration_in_min_ms")

#rename time_signature to time
music_gen<- music_gen %>% 
  rename("time" = "time_signature")

#inspect new variable names
names(music_gen)

#inspect dataset for missing values
skim(music_gen)

#replace missing values with 0 in the key column
music_gen<- music_gen %>% 
  mutate(key = ifelse(is.na(key), 0, key))

#replace missing values with 0 in the popularity column
music_gen<- music_gen %>% 
  mutate(popularity = ifelse(is.na(popularity), 0, popularity))

#replace missing values with 0 in the instrumentalness column
music_gen<- music_gen %>% 
  mutate(instrumentalness = ifelse(is.na(instrumentalness), 0, instrumentalness))



#inspect new dataset after dropping empty rows
skim(music_gen)

m_gen <- music_gen[3:17]



#check for outliers in the dataset
boxplot(m_gen)

#check for outliers in the popularity datset
boxplot(music_gen$popularity)

#treating the popularity value outliers
#find the values of the outliers
popularity_out<- boxplot.stats(music_gen$popularity)$out

#locate the upper outliers
popularity_upp_out<-
  popularity_out[popularity_out>mean(music_gen$popularity)]
#locate the lower outliers
popularity_low_out<-
  popularity_out[popularity_out<mean(music_gen$popularity)]

#find the indices that correspond to upper outliers
popularity_upp_ind<- which(music_gen$popularity %in% popularity_upp_out)

#replace the upper outliers with the upper whisker values

music_gen$popularity[popularity_upp_ind]<-
  boxplot.stats(music_gen$popularity)$stats[5]

#inspect the new boxplot for popularity
boxplot(music_gen$popularity)


#check for outliers in the danceability datset
boxplot(music_gen$danceability)

#treating the danceability value outliers
#find the values of the outliers
danceability_out<- boxplot.stats(music_gen$danceability)$out

#locate the upper outliers
danceability_upp_out<-
  danceability_out[danceability_out>mean(music_gen$danceability)]
#locate the lower outliers
danceability_low_out<-
  danceability_out[danceability_out<mean(music_gen$danceability)]

#find the indices that correspond to upper outliers
danceability_upp_ind<- which(music_gen$danceability %in% danceability_upp_out)
#find the indices that correspond to lower outliers
danceability_low_ind<- which(music_gen$danceability %in% danceability_low_out)

#replace the upper outliers with the upper whisker values
music_gen$danceability[danceability_upp_ind]<-
  boxplot.stats(music_gen$danceability)$stats[5]
#replace the upper outliers with the lower whisker values
music_gen$danceability[danceability_low_ind]<-
  boxplot.stats(music_gen$danceability)$stats[1]


#inspect the new boxplot for danceability
boxplot(music_gen$danceability)

#check for outliers in the energy datset
boxplot(music_gen$energy)

#check for outliers in the key datset
boxplot(music_gen$key)

#check for outliers in the loudness datset
boxplot(music_gen$loudness)
#locate the upper outliers
#find the values of the outliers
loudness_out<- boxplot.stats(music_gen$loudness)$out
loudness_upp_out<-
  loudness_out[loudness_out>mean(music_gen$loudness)]

#find the indices that correspond to upper outliers
loudness_upp_ind<- which(music_gen$loudness %in% loudness_upp_out)

#replace the upper outliers with the upper whisker values

music_gen$loudness[loudness_upp_ind]<-
  boxplot.stats(music_gen$loudness)$stats[5]

boxplot(music_gen$loudness)

#inspect the new boxplot for popularity
boxplot(music_gen$popularity)



#check for outliers in the mode datset
boxplot(music_gen$mode)


#check for outliers in the speechiness datset
boxplot(music_gen$speechiness)

#treating the speechiness value outliers
#find the values of the outliers
speechiness_out<- boxplot.stats(music_gen$speechiness)$out


#check for outliers in the acousticness datset
boxplot(music_gen$acousticness)


#check for outliers in the instrumentalness datset
boxplot(music_gen$instrumentalness)

#treating the instrumentalness value outliers
#find the values of the outliers
instrumentalness_out<- boxplot.stats(music_gen$instrumentalness)$out

#check for outliers in the liveness datset
boxplot(music_gen$liveness)

#treating the liveness value outliers
#find the values of the outliers
liveness_out<- boxplot.stats(music_gen$liveness)$out

#check for outliers in the valence datset
boxplot(music_gen$valence)

#check for outliers in the tempo datset
boxplot(music_gen$tempo)

#treating the tempo value outliers
#find the values of the outliers
tempo_out<- boxplot.stats(music_gen$tempo)$out

#locate the upper outliers
tempo_upp_out<-
  tempo_out[tempo_out>mean(music_gen$tempo)]


#find the indices that correspond to upper outliers
tempo_upp_ind<- which(music_gen$tempo %in% tempo_upp_out)


#replace the upper outliers with the upper whisker values
music_gen$tempo[tempo_upp_ind]<-
  boxplot.stats(music_gen$tempo)$stats[5]



#inspect the new boxplot for tempo
boxplot(music_gen$tempo)

#check for outliers in the duration datset
boxplot(music_gen$duration)

#treating the duration value outliers
#find the values of the outliers
duration_out<- boxplot.stats(music_gen$duration)$out

#locate the upper outliers
duration_upp_out<-
  duration_out[duration_out>mean(music_gen$duration)]
#locate the lower outliers
duration_low_out<-
  duration_out[duration_out<mean(music_gen$duration)]


#locate the lower outliers
duration_low_out<-
  duration_out[duration_out<mean(music_gen$duration)]


#find the indices that correspond to lower outliers
duration_low_ind<- which(music_gen$duration %in% duration_low_out)


#replace the lower outliers with the upper whisker values
music_gen$duration[duration_low_ind]<-
  boxplot.stats(music_gen$duration)$stats[1]

#check for outliers in the time datset
boxplot(music_gen$time)

#check for outliers in the class datset
boxplot(music_gen$class)

#check for skewness of the popularity dataset
plot(density(music_gen$popularity))
abline(v=mean(music_gen$popularity), col="green")
abline(v=median(music_gen$popularity), col="red")


#check for skewness of the danceability dataset
plot(density(music_gen$danceability))
abline(v=mean(music_gen$danceability), col="blue")
abline(v=median(music_gen$danceability), col="red")

skewness(music_gen$danceability, na.rm = TRUE)

#check for skewness of the energy dataset
plot(density(music_gen$energy))
abline(v=mean(music_gen$energy), col="blue")
abline(v=median(music_gen$energy), col="red")

skewness(music_gen$energy, na.rm = TRUE)


#check for skewness of the key dataset
plot(density(music_gen$key))
abline(v=mean(music_gen$key), col="blue")
abline(v=median(music_gen$key), col="red")

skewness(music_gen$key, na.rm = TRUE)

#correct positive skew of key dataset
music_gen$key<- log10(music_gen$key)

#check for skewness of the new key dataset
plot(density(music_gen$key))
abline(v=mean(music_gen$key), col="blue")
abline(v=median(music_gen$key), col="red")

skewness(music_gen$key, na.rm = TRUE)

#check for skewness of the loudness dataset
plot(density(music_gen$loudness))
abline(v=mean(music_gen$loudness), col="blue")
abline(v=median(music_gen$loudness), col="red")

skewness(music_gen$loudness, na.rm = TRUE)

#correct negative loudness skewness
music_gen$loudness<-
  log10(max(music_gen$loudness+1)-music_gen$loudness)

#check for skewness of the new loudness dataset
plot(density(music_gen$loudness))
abline(v=mean(music_gen$loudness), col="blue")
abline(v=median(music_gen$loudness), col="red")

skewness(music_gen$loudness, na.rm = TRUE)

#check for skewness of the mode dataset
plot(density(music_gen$mode))
abline(v=mean(music_gen$mode), col="blue")
abline(v=median(music_gen$mode), col="red")

skewness(music_gen$mode, na.rm = TRUE)


skewness(music_gen$mode, na.rm = TRUE)

#check for skewness of the speechiness dataset
plot(density(music_gen$speechiness))
abline(v=mean(music_gen$speechiness), col="blue")
abline(v=median(music_gen$speechiness), col="red")

skewness(music_gen$speechiness, na.rm = TRUE)

#correct positive skew of speechiness dataset
music_gen$speechiness<- 1/(music_gen$speechiness)

#check for skewness of the snew peechiness dataset
plot(density(music_gen$speechiness))
abline(v=mean(music_gen$speechiness), col="blue")
abline(v=median(music_gen$speechiness), col="red")

skewness(music_gen$speechiness, na.rm = TRUE)

#check for skewness of the acousticness dataset
plot(density(music_gen$acousticness))
abline(v=mean(music_gen$acousticness), col="blue")
abline(v=median(music_gen$acousticness), col="red")

skewness(music_gen$acousticness, na.rm = TRUE)


skewness(music_gen$acousticness, na.rm = TRUE)

#check for skewness of the instrumentalness dataset
plot(density(music_gen$instrumentalness))
abline(v=mean(music_gen$instrumentalness), col="blue")
abline(v=median(music_gen$instrumentalness), col="red")

skewness(music_gen$instrumentalness, na.rm = TRUE)

#correct positive skew of instrumentalness dataset
music_gen$instrumentalness<- log10(music_gen$instrumentalness)


#check for skewness of the new instrumentalness dataset
plot(density(music_gen$instrumentalness))
abline(v=mean(music_gen$instrumentalness), col="blue")
abline(v=median(music_gen$instrumentalness), col="red")

skewness(music_gen$instrumentalness, na.rm = TRUE)

#check for skewness of the liveness dataset
plot(density(music_gen$liveness))
abline(v=mean(music_gen$liveness), col="blue")
abline(v=median(music_gen$liveness), col="red")

skewness(music_gen$liveness, na.rm = TRUE)

#correct positive skew of liveness dataset
music_gen$liveness<- log10(music_gen$liveness)

#check for skewness of the new liveness dataset
plot(density(music_gen$liveness))
abline(v=mean(music_gen$liveness), col="blue")
abline(v=median(music_gen$liveness), col="red")

skewness(music_gen$liveness, na.rm = TRUE)

#check for skewness of the valence dataset
plot(density(music_gen$valence))
abline(v=mean(music_gen$valence), col="blue")
abline(v=median(music_gen$valence), col="red")

skewness(music_gen$valence, na.rm = TRUE)

#check for skewness of the tempo dataset
plot(density(music_gen$tempo))
abline(v=mean(music_gen$tempo), col="blue")
abline(v=median(music_gen$tempo), col="red")

skewness(music_gen$tempo, na.rm = TRUE)

#check for skewness of the duration dataset
plot(density(music_gen$duration))
abline(v=mean(music_gen$duration), col="blue")
abline(v=median(music_gen$duration), col="red")

skewness(music_gen$duration, na.rm = TRUE)


#check for skewness of the time dataset
plot(density(music_gen$time))
abline(v=mean(music_gen$time), col="blue")
abline(v=median(music_gen$time), col="red")

skewness(music_gen$time, na.rm = TRUE)

#check for skewness of the class dataset
plot(density(music_gen$class))
abline(v=mean(music_gen$class), col="blue")
abline(v=median(music_gen$class), col="red")

skewness(music_gen$class, na.rm = TRUE)




#create a new column in dataset called class and assign factored format of the 
#entries in Class column in the data set
music_gen$class <- as.factor(music_gen$class)

#inspect the new dataset
str(music_gen)

#set seed to 100 to ensure same sample is repeated
set.seed(100)

#divide your data set into train and test data set using the division 80:20
div <- sample(2, nrow(music_gen), replace = TRUE, prob =c(0.8,0.2))
div

#assign 80% of sample generated to training data set
train_set <- music_gen[div==1,]

#assign 20% of sample generated to testing data set
test_set <- music_gen[div==2,]

#inspect dimensions of both training and testing data set
dim(train_set)
dim(test_set)

names(music_gen)

# calculate information gain for each of the variables in the dataset
IG <- attrEval(class ~ i_artist_name + track_name + popularity + danceability 
               + energy + key + loudness + mode + speechiness + acousticness 
               + instrumentalness + liveness + valence + tempo + duration
               + time,
               data = music_gen, 
               estimator = "InfGain")
IG

#sort information gain index in descending order
sort(IG, decreasing = TRUE)

# calculate GINI Index for each of the variables in the dataset
GI <- attrEval(class ~ i_artist_name + track_name + popularity + danceability 
               + energy + key + loudness + mode + speechiness + acousticness 
               + instrumentalness + liveness + valence + tempo + duration
               + time,
               data = music_gen, 
               estimator = "Gini")
GI
#sort Gini index in descending order
sort(GI, decreasing = TRUE)

#train decision tree model using top 10 information gain index variables
music_gen_tree <- rpart(class ~  duration + acousticness + popularity + energy +
                          valence + loudness + instrumentalness + speechiness +
                          time + liveness,
                        data = train_set, method = "class")

#display generated decision tree
music_gen_tree

#plot the decision tree
rpart.plot::rpart.plot(music_gen_tree)


#predict the model on current training dataset
P_train <- predict(music_gen_tree, train_set, type = 'class')
P_train

#confusion matrix
confusionMatrix(P_train, train_set$class)


#predict the model on the testing dataset
P_test <- predict(music_gen_tree, test_set, type = 'class')
P_test

#Confusion matrix
confusionMatrix(P_test, test_set$class)


printcp(music_gen_tree)
plotcp(music_gen_tree)

music_gen_tree_prune <- prune(music_gen_tree,
                                    cp= music_gen_tree$cptable[which.min(music_gen_tree$cptable[,"xerror"]),"CP"])
#plot the decision tree
rpart.plot::rpart.plot(music_gen_tree_prune, uniform= TRUE)

pruned_test <- predict(music_gen_tree_prune, test_set, type = 'class')

confusionMatrix(pruned_test, test_set$class)


music_gen_tree_prune <- prune(music_gen_tree,
                              cp= 0.014)
#plot the decision tree
rpart.plot::rpart.plot(music_gen_tree_prune, uniform= TRUE)

pruned_test <- predict(music_gen_tree_prune, test_set, type = 'class')

confusionMatrix(pruned_test, test_set$class)

