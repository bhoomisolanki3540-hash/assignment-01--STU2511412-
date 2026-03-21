## ETL Decisions

### Decision 1 — Standardizing Date Formats
**Problem:** The raw `retail_transactions.csv` contained dates in multiple formats like `DD/MM/YYYY`, `DD-MM-YYYY`, and `YYYY-MM-DD` (e.g., Row 0 vs Row 2).
**Resolution:** During the ETL process, I converted all strings into a standard ISO format (`YYYY-MM-DD`). I also extracted parts of the date to create a `date_key` (YYYYMMDD) for the `dim_date` table, which improves query performance.

### Decision 2 — Handling Categorical Inconsistency
**Problem:** The `category` column had inconsistent casing (e.g., `electronics` vs `Electronics`) and naming (e.g., `Grocery` vs `Groceries`).
**Resolution:** I applied a `UPPER(LEFT(category, 1)) + LOWER(SUBSTRING(category, 2))` transformation to force Title Case. I also mapped all instances of "Grocery" to "Groceries" to ensure that analytical queries for that category returned the full data set.

### Decision 3 — Imputing Missing Store Cities
**Problem:** Several rows (including the sample provided) had NULL values in the `store_city` column even when the `store_name` was present.
**Resolution:** Since `store_name` (e.g., 'Chennai Anna') is unique to a location, I used a lookup table to fill in the missing cities. Any NULL cities for 'Chennai Anna' were updated to 'Chennai' before being loaded into the `dim_store` dimension table.
