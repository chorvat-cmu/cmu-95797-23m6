# Import 
import duckdb

# Connect to db
conn = duckdb.connect('main.db')

# Queries
tables_query = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'main';"
tables = conn.execute(tables_query).fetchall()

# Loop counts
for table in tables:
    table_name = table[0]
    count_query = f"SELECT COUNT(*) FROM {table_name};"
    row_count = conn.execute(count_query).fetchone()[0]
    print(f"Table {table_name} has {row_count} rows.")

# Close connection
conn.close()
