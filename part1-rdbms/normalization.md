## Anomaly Analysis

### 1. Insert Anomaly
**Example:** We cannot add a new Sales Representative (e.g., "Suresh Raina") to the system until they have made their first sale. 
**Reference:** Because the flat file is centered on orders, the `order_id` is likely the primary key. If a new rep has no orders, we cannot create a row for them without leaving mandatory fields like `order_id` or `customer_id` empty.

### 2. Update Anomaly
**Example:** If Sales Rep Anita Desai (`SR02`) changes her email address, we must update it in every single row where she appears.
**Reference:** In the CSV, Anita Desai appears in over 40 rows (e.g., Row 0, 3, 4). If we update 39 rows but miss one, the database becomes inconsistent, showing two different emails for the same person.

### 3. Delete Anomaly
**Example:** If we delete the order `ORD1075` (Row 9), we lose all record of the customer Vikram Singh (`C005`).
**Reference:** Vikram Singh only appears in that one row. Deleting the order record accidentally deletes our only copy of his name, email, and city.

## Normalization Justification

I refute the manager's position that a single table is simpler. While it may appear easier to read at a glance, it is a liability for a growing business. 

Using our dataset as an example, the office address for the Mumbai HQ is repeated identically across every order handled by Deepak Joshi. In a real-world scenario with 100,000 orders, this redundancy wastes massive amounts of storage. More importantly, it invites "Data Corruption." If a clerk accidentally types "Nariman Pt" instead of "Nariman Point" in just one row, a simple search for all Mumbai orders will return incorrect results.

By normalizing to 3NF, we ensure "Data Integrity." We store the customer's info once, the product's price once, and the rep's address once. This makes the system faster, prevents the anomalies identified above, and allows the company to scale without fear of losing or breaking their data.
