# file: run_profit.py
from jaclang import jac_import

# import the Jac file
ProfitCalc = jac_import("profit_calc.jac").ProfitCalc

# ask user for inputs
cost_price = float(input("Enter cost price per unit: "))
sell_price = float(input("Enter selling price per unit: "))
qty = int(input("Enter quantity sold: "))

# spawn the Jac walker with user input
ProfitCalc(cost_price=cost_price, sell_price=sell_price, qty=qty).run()
