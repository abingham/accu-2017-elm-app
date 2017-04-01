def day_string(day_id):
    """Get the string representation for a day ID.
    """
    return {
        1: 'Wednesday',
        2: 'Thursday',
        3: 'Friday',
        4: 'Saturday'
    }[day_id]
