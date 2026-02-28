import pandas as pd
from pathlib import Path

INPUT_PATH = Path("data/country_rules.csv")
OUTPUT_PATH = Path("outputs/predictions.csv")


def compute_ex(df):
    return ((df["Budget_Signal"] == 1) & (df["Blocking_Constraint"] == 0)).astype(int)


def predict_level(df):
    ex = compute_ex(df)
    df["EX"] = ex

    level = []

    for _, row in df.iterrows():
        if row["SA"] == 0:
            level.append(1)
        elif row["SA"] == 1 and (row["STR"] == 0 or row["EX"] == 0):
            level.append(2)
        elif row["SA"] == 1 and row["STR"] == 1 and row["EX"] == 1:
            level.append(3)
        else:
            level.append(None)

    df["Predicted_Level"] = level
    return df


def main():
    df = pd.read_csv(INPUT_PATH)
    df = predict_level(df)
    OUTPUT_PATH.parent.mkdir(exist_ok=True)
    df.to_csv(OUTPUT_PATH, index=False)
    print(df)


if __name__ == "__main__":
    main()
