# Steps specific to the day-view

from behave import step
from pages.day_view import DayViewPage


@step('we visit the view for day {day:Int}')
def step_impl(context, day):
    page = DayViewPage(context)
    page.visit(day)
