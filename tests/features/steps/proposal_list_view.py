# Steps which apply to any view which displays a list of proposals.
#
# This includes day-view, agenda, and (technically) session-view.

from behave import step
from pages.enums import day_string
from pages.proposal_list_view import ProposalListView


@step('{count:Int} proposal cards are displayed')
def step_impl(context, count):
    page = ProposalListView(context)
    assert len(page.proposals()) == count


@step('all proposals are for day {day:Int}')
def step_impl(context, day):
    page = ProposalListView(context)
    assert all(p.day_text == day_string(day)
               for p in page.proposals())


@step('we bookmark {count:Int} proposal(s)')
def step_impl(context, count):
    page = ProposalListView(context)
    for prop in page.proposals()[:count]:
        prop.bookmarked = True


@step('we clear all bookmarks')
def step_impl(context):
    page = ProposalListView(context)
    for proposal in page.proposals():
        proposal.bookmarked = False


@step('there are {count:Int} proposals displayed')
def step_impl(context, count):
    page = ProposalListView(context)
    assert len(page.proposals()) == count


@step('{count:Int} proposals are bookmarked')
def step_impl(context, count):
    page = ProposalListView(context)
    assert len([p for p in page.proposals() if p.bookmarked]) == count
