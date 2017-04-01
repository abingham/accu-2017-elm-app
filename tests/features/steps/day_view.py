from behave import given, then
from pages.day_view import DayViewPage
from pages.enums import day_string


@given('we visit the view for day {day:Int}')
def step_impl(context, day):
    page = DayViewPage(context)
    page.visit(day)


@then('{count:Int} proposal cards are displayed')
def step_impl(context, count):
    page = DayViewPage(context)
    assert len(page.proposals()) == count


@then('all proposals are for day {day:Int}')
def step_impl(context, day):
    page = DayViewPage(context)
    assert all(p.day_text == day_string(day)
               for p in page.proposals())
