---
title: "Lab 06 - Modelling course evaluations"
date: "2018-02-22"
output: 
  tufte::tufte_html:
    tufte_variant: "envisioned"
    highlight: pygments
    css: lab.css
link-citations: yes
---



**Due:** 2018-02-29 at noon

## Introduction

<p><span class="marginnote shownote">
<!--
<div class="figure">-->
<img src="img/05-simpsons-paradox/whickham.png" alt=" " width="527"  />
<!--
<p class="caption marginnote">--> <!--</p>-->
<!--</div>--></span></p>

Many college courses conclude by giving students the opportunity to evaluate the course and the instructor anonymously. However, the use of these student evaluations as an indicator of course quality and teaching effectiveness is often criticized because these measures may reflect the influence of non-teaching related characteristics, such as the physical appearance of the instructor. The article titled, ``Beauty in the classroom: instructors’ pulchritude and putative pedagogical productivity" (Hamermesh and Parker, 2005) found that instructors who are viewed to be better looking receive higher instructional ratings. (Daniel S. Hamermesh, Amy Parker, Beauty in the classroom: instructors pulchritude and putative pedagogical productivity, Economics of Education Review, Volume 24, Issue 4, August 2005, Pages 369-376, ISSN 0272-7757, 10.1016/j.econedurev.2004.07.013. http://www.sciencedirect.com/science/article/pii/S0272775704001165.)

For this assignmenrt you will analyze the data from this study in order to learn what goes into a positive professor evaluation.

The data were gathered from end of semester student evaluations for a large sample of professors from the University of Texas at Austin. In addition, six students rated the professors’ physical appearance. (This is aslightly modified version of the original data set that was released as part of the replication data for Data Analysis Using Regression and Multilevel/Hierarchical Models (Gelman and Hill, 2007).) The result is a data frame where each row contains a different course and columns represent variables about the courses and professors.

# Getting started

- Go to the course organization on GitHub: https://github.com/Sta199-S18.

- Find the repo starting with `lab-05` and that has your team name at the end (this should be the only `lab-05` repo available to you).

- In the repo, click on the green **Clone or download** button, select **Use HTTPS** (this might already be selected by default, and if it is, you'll see the text **Clone with HTTPS** as in the image below). Click on the clipboard icon to copy the repo URL.

- Go to RStudio Cloud and into the course workspace. Create a **New Project from Git Repo**. You will need to click on the down arrow next to the **New Project** button to see this option.

- Copy and paste the URL of your assignment repo into the dialog box:

- Hit OK, and you're good to go!

# Packages

In this lab we will work with the `tidyverse` and `broom` packages. We can install and load them with the following:


```r
install.packages("tidyverse")
library(tidyverse) 
library(broom)
```

# Housekeeping

## Git configuration

<label for="tufte-mn-" class="margin-toggle">&#8853;</label><input type="checkbox" id="tufte-mn-" class="margin-toggle"><span class="marginnote"><span style="display: block;">Your email address is the address tied to your GitHub account and your name should be first and last name.</span></span>

- Go to the *Terminal* pane
- Type the following two lines of code, replacing the information in the quotation marks with your info.


```bash
git config --global user.email "your email"
git config --global user.name "your name"
```

To confirm that the changes have been implemented, run the following:


```bash
git config --global user.email
git config --global user.name
```

## Password caching

If you would like your git password cached for a week for this project, type the following in the Terminal:


```bash
git config --global credential.helper 'cache --timeout 604800'
```

## Project name: 

Currently your project is called *Untitled Project*. Update the name of your project to be "Lab 06 - Modelling course evaluations".

# Warm up

**Pick one team member to complete the steps in this section while the others contribute to the discussion but do not actually touch the files on their computer.**

Before we introduce the data, let's warm up with some simple exercises.

## YAML: 

Open the R Markdown (Rmd) file in your project, change the author name to your **team** name, and knit the document.

## Commiting and pushing changes:

- Go to the **Git** pane in your RStudio. 
- View the **Diff** and confirm that you are happy with the changes.
- Add a commit message like "Update team name" in the **Commit message** box and hit **Commit**.
- Click on **Push**. This will prompt a dialogue box where you first need to enter your user name, and then your password.

## Pulling changes:

Now, the remaining team members who have not been concurrently making these changes on their projects should click on the **Pull** button in their Git pane and observe that the changes are now reflected on their projects as well.

# The data



## Codebook

- `score` - Average professor evaluation score: (1) very unsatisfactory - (5) excellent
- `rank` - Rank of professor: teaching, tenure track, tenure
- `ethnicity` - Ethnicity of professor: not minority, minority
- `gender` - Gender of professor: female, male
- `language` - Language of school where professor received education: english or non-english
- `age` - Age of professor
- `cls_perc_eval` - Percent of students in class who completed evaluation
- `cls_did_eval` - Number of students in class who completed evaluation
- `cls_students` - Total number of students in class
- `cls_level` - Class level: lower, upper
- `cls_profs` - Number of professors teaching sections in course in sample: single, multiple
- `cls_credits` - Number of credits of class: one credit (lab, PE, etc.), multi credit
- `bty_f1lower` - Beauty rating of professor from lower level female: (1) lowest - (10) highest
- `bty_f1upper` - Beauty rating of professor from upper level female: (1) lowest - (10) highest
- `bty_f2upper` - Beauty rating of professor from upper level female: (1) lowest - (10) highest
- `bty_m1lower` - Beauty rating of professor from lower level male: (1) lowest - (10) highest
- `bty_m1upper` - Beauty rating of professor from upper level male: (1) lowest - (10) highest
- `bty_m2upper` - Beauty rating of professor from upper level male: (1) lowest - (10) highest

# Exercises

## Part 1: Data Manipulation 

1.  Create a new variable called `bty_avg` that is the average attractiveness
    score of the six students for each professor (`bty_f1lower` through `bty_m2upper`). 
    Do this in one pipe, and use the `rowwise` function. (Hint: See function help for 
    `rowwise` more info.)

## Part 2: Exploratory Data Analysis

2.  Visualize the distribution of `score`. Is the distribution skewed? What does 
    that tell you about how students rate courses? Is this what you expected to 
    see? Why, or why not? Include any summary statistics and visualizations
    you use in your response.

3.  Select a numerical variable other than `score` and visualize and describe
    the relationship between these two variables.

## Part 3: Simple linear regression

4.  Replot the scatterplot from Question 3, but this time use  
    `geom_point(position = "jitter")`? What does "jitter" mean? What was 
    misleading about the initial scatterplot?

5.  Let's see if the apparent trend in the plot is something more than
    natural variation. Fit a linear model called `m_bty` to predict average
    professor evaluation `score` by average beauty rating (`bty_avg`) and add 
    the regression line to your plot. Write out the equation for the linear 
    model and interpret the slope.

## Part 4: Multiple linear regression

6.  Fit a new linear model called `m_bty_gen` to predict average
    professor evaluation `score` based on average beauty rating (`bty_avg`) and
    `gender`. How does the adusted $R^2$ of this model and the previous one
    compare? Has the addition of `gender` to the model changed the parameter
    estimate (slope) for `bty_avg`?

7.  What is the equation of the line corresponding to *just* male professors?
    
8.  For two professors who received the same beauty rating, which gender tends 
    to have the higher course evaluation score?
    
9. How does the relationship between beauty and evaluation score
    vary between male and female professors?
    
10.  Create a new model called `m_bty_rank` with `gender` removed and `rank` 
    added in. How is R handling a categorical variables that has more 
    than two levels? Note that the rank variable has three levels: `teaching`, 
    `tenure track`, `tenured`.
