## Installation Instructions
### Windows:
Use the SQLite executable from the official site.

### macOS:
Run brew install sqlite.

### Linux:
Run sudo apt-get install sqlite3.

## Data Needed:
You will need the following CSV files from data/raw:

-   PRODUCTS_TAKEHOME.csv
-   USER_TAKEHOME.csv
-   TRANSACTION_TAKEHOME.csv

## Data Preparation
Before running SQL queries, check the `exploratory_data_analysis.ipynb` notebook in the notebooks folder. This `notebook` cleans the raw data from `data/raw` and saves it in `data/processed`, which is used by SQL queries.
Installation of required modules is commented in the notebook.

The following CSV files will be loaded in data/processed after `exploratory_data_analysis.ipynb` notebook is run, uncommend to_csv files save the files:

-   PRODUCTS_TAKEHOME.csv
-   USER_TAKEHOME.csv
-   TRANSACTION_TAKEHOME.csv

## Database Setup
1) Run the following command to create a new SQLite database:
-   `sqlite3 <create_new_db_name>.db`

2) In the SQLite shell (sqlite>), execute:
-   `.read create_tables.sql`
-   This will create all the required tables.

3) Run SQL queries from the files:
-   `.read open_ended_querie_1.sql`
-   Expected responses are commented in the SQL files. Refer to closed_ended_querie_3, open_ended_querie_3, open_ended_querie_1 for examples.

4) For better table formatting, enable headers and column mode:
-   `.headers ON`
-   `.mode column`

## Reports & Visuals
Data quality issues and challenging fields are addressed in the `findings.pdf` file inside the `reports` folder.
Visuals are located in the `visuals` directory.