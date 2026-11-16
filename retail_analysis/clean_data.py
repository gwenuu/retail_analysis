
import pandas as pd
from pathlib import Path

file = Path(__file__).parent / "data" / "online_retail.csv"
df = pd.read_csv(file)

print("Rows:", len(df))
print("\nMissing values:")
print(df.isnull().sum())

print("\nDuplicates:", df.duplicated().sum())
print("Negative quantities:", (df["Quantity"] < 0).sum())
print("Invalid prices:", (df["UnitPrice"] <= 0).sum())

cancelled = df["InvoiceNo"].astype(str).str.startswith("C")
print("Cancelled rows:", cancelled.sum())

# cleaning
df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"], errors="coerce")

sales = df[
    (df["Quantity"] > 0) &
    (df["UnitPrice"] > 0) &
    (~cancelled) &
    (df["InvoiceDate"].notna())
].copy()


print("\nRows after cleaning:", len(sales))

sales.to_csv(file.parent / "cleaned_retail.csv", index=False)

