# Lab3 - SQL

The task for this Lab was to create a duckDB database from an SQLite database. The database is called Sakila and is a database with fictitious data about a company that rents movies in its two stores. For more information about Sakila, the database is available at [kaggle][1]

I would answer questions from The Manager and insert these into a Manager report in an ipynb file. Then I would also create a Dashboard in Evidence. For more information about the task follow the link below.

![Lab_instructions](./img/Lab_SQL.pdf)

## Video
[![video](./img/thumbnail_yt.png)](https://www.youtube.com/watch?v=sDFPIl1nzCo)


## Sakila DB
Sakila is a database with data about films, how many of each film there are (inventory), how much these have been rented and how much has been paid for this. There is also information about customers who rent and staff who work there.

![ERD-Chart](./img/Sakila_staging.png)

<img = src = 

## Sakila refined
I discovered that there would be many joins in each query if I were to use the structure that was in schema staging, so I created a refined schema with these tables.

![ERD-Chart](./img/Sakila_refined.png)

## Data Loading Tool (DLT)
My DLT checks if there is already a DuckDB database in the data folder. If there is, DLT will not create the database. Then the DLT will run refined.sql were my refined schema and tables are added. All tables are omnipotent so they will not replace if the tables already exist.
After this, DLT will copy the database to evidence. This allows you to add data to the database manually which will then end up in Evidence.

![Pipeline](./img/Pipeline.png)

## Evidence
Comparison operators first compare Area and then Perimeter if the Areas are equal.

## Shape2dPlotter
Shape2dPlotter takes in shape classes and plots them in a coordinate system. In order for the area to adapt to the size and location of the shapes, it calculates where the edge boundaries go. I also wanted both the x and y scales to be the same size and go to an even 10.

## Unittesting
207 unit tests that test each form and check for Error and whether you get correct answers.

## Manual testing
I geometry.ipynb I did some manualtest.

[1]: https://www.kaggle.com/datasets/atanaskanev/sqlite-sakila-sample-database