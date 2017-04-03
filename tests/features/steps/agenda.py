# Step specific to the agenda view.

from behave import step
from pages.agenda import AgendaPage


@step('we visit the agenda')
def step_impl(context):
    page = AgendaPage(context)
    page.visit()
