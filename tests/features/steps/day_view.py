from behave import step
from pages.day_view import DayViewPage
from pages.enums import day_string


@step('we visit the view for day {day:Int}')
def step_impl(context, day):
    page = DayViewPage(context)
    page.visit(day)


@step('{count:Int} proposal cards are displayed')
def step_impl(context, count):
    page = DayViewPage(context)
    assert len(page.proposals()) == count


@step('all proposals are for day {day:Int}')
def step_impl(context, day):
    page = DayViewPage(context)
    assert all(p.day_text == day_string(day)
               for p in page.proposals())


@step('we bookmark {count:Int} proposal(s)')
def step_impl(context, count):
    page = DayViewPage(context)
    for prop in page.proposals()[:count]:
        prop.bookmarked = True
