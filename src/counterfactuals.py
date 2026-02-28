import pandas as pd
from pathlib import Path

INPUT_PATH = Path("data/country_rules.csv")
OUTPUT_PATH = Path("outputs/counterfactuals.csv")


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


def score_row(sa: int, strat: int, budget_signal: int, blocking_constraint: int) -> tuple[int, int]:
    ex = compute_ex(budget_signal, blocking_constraint)
    level = predict_level(sa, strat, ex)
    return ex, level


def main() -> None:
    df = pd.read_csv(INPUT_PATH)

    rows = []
    for _, r in df.iterrows():
        sa = int(r["SA"])
        strat = int(r["STR"])
        budget = int(r["Budget_Signal"])
        block = int(r["Blocking_Constraint"])

        ex_base, lvl_base = score_row(sa, strat, budget, block)

        ex_no_block, lvl_no_block = score_row(sa, strat, budget, 0)
        ex_budget_on, lvl_budget_on = score_row(sa, strat, 1, block)
        ex_both, lvl_both = score_row(sa, strat, 1, 0)

        rows.append(
            {
                "Country": r["Country"],
                "SA": sa,
                "STR": strat,
                "Budget_Signal": budget,
                "Blocking_Constraint": block,
                "EX_base": ex_base,
                "Level_base": lvl_base,
                "Level_if_no_blocking_constraint": lvl_no_block,
                "Level_if_budget_signal_on": lvl_budget_on,
                "Level_if_budget_on_and_no_block": lvl_both,
            }
        )

    out = pd.DataFrame(rows).sort_values(by=["Level_base", "Country"])

    OUTPUT_PATH.parent.mkdir(exist_ok=True)
    out.to_csv(OUTPUT_PATH, index=False)

    print(out.to_string(index=False))


if __name__ == "__main__":
    main()
