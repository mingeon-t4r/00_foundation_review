def calculate_average(values):
    return sum(values) / len(values) if values else 0


def classify_customer(sales):
    if sales >= 300000:
        return "VIP"
    if sales >= 150000:
        return "Regular"
    return "Basic"


def calculate_growth(current, previous):
    if previous == 0:
        return None
    return (current - previous) / previous
