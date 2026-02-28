import pandas as pd
from itertools import product
from pathlib import Path


OUTPUT_PATH = Path("outputs/truth_table.csv")


def compute_ex(budget_signal: int, blocking_constraint: int) -> int:
    return int((budget_signal == 1) and (blocking_constraint == 0))


def predict_level(sa: int, strat: int, ex: int) -> int:
    if sa == 0:
        return 1
    if sa == 1 and (strat == 0 or ex == 0):
        return 2
    if sa == 1 and strat == 1 and ex == 1:
        return 3
    raise ValueError(f"Unreachable configuration: SA={sa}, STR={strat}, EX={ex}")


def main() -> None:
    rows = []
    for sa, strat, budget_signal, blocking_constraint in product([0, 1], repeat=4):
        ex = compute_ex(budget_signal, blocking_constraint)
        level = predict_level(sa, strat, ex)
        rows.append(
            {
                "SA": sa,
                "STR": strat,
                "Budget_Signal": budget_signal,
                "Blocking_Constraint": blocking_constraint,
                "EX": ex,
                "Predicted_Level": level,
            }
        )

    df = pd.DataFrame(rows).sort_values(
        by=["SA", "STR", "Budget_Signal", "Blocking_Constraint"]
    )

    OUTPUT_PATH.parent.mkdir(exist_ok=True)
    df.to_csv(OUTPUT_PATH, index=False)

    print(df.to_string(index=False))
    print()
    print("Counts by level:")
    print(df["Predicted_Level"].value_counts().sort_index().to_string())

if __name__ == "__main__":
    main()
