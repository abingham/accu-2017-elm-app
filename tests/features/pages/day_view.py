from .proposal_list_view import ProposalListView


class DayViewPage(ProposalListView):
    """Page showing all proposals for a day."""

    def visit(self, day):
        return super().visit("day/{}".format(day))
