import dlt
import shutil
import duckdb
from dlt.sources.sql_database import sql_database
from pathlib import Path

# Paths
BASE_DIR = Path(__file__).parent
DATA_PATH = BASE_DIR / "data"
SQLITE_PATH = DATA_PATH / "sqlite-sakila.db"
DUCKDB_DATA_FILE = DATA_PATH / "sakila.duckdb"
REFINED_FILE = BASE_DIR / "sql" / "refined.sql"
EVIDENCE_SOURCE_DIR = BASE_DIR / "dashboard" / "sources" / "sakila"
EVIDENCE_DB_FILE = EVIDENCE_SOURCE_DIR / "sakila.duckdb"

def run_pipeline():
    # Control if DB already exists
    if not DUCKDB_DATA_FILE.exists():
        print(f"Creating DuckDB in {DATA_PATH}...")
        
        source = sql_database(credentials=f"sqlite:///{SQLITE_PATH}")
        
        pipeline = dlt.pipeline(
            pipeline_name="sakila_ingestion",
            destination=dlt.destinations.duckdb(str(DUCKDB_DATA_FILE)),
            dataset_name="staging", # Hamnar i schemat 'staging'
        )
        
        load_info = pipeline.run(source, write_disposition="replace")
        print(load_info)
    else:
        print("The database already exists in /data. Skiping DLT-ingestion.")

    # Creating refined tables in /data
    print("Creating refined tables")
    with duckdb.connect(DUCKDB_DATA_FILE) as conn, open(str(REFINED_FILE)) as ingest_script:
        conn.sql(ingest_script.read())

    # Copy DB from /data to dashboard/sources/sakila
    print(f"Copying database to Evidence: {EVIDENCE_DB_FILE}")
    shutil.copy2(DUCKDB_DATA_FILE, EVIDENCE_DB_FILE)
    print("Copy done. Ready to run Evidence")

if __name__ == "__main__":
    run_pipeline()