from .proposal_list_view import ProposalListView


class AgendaPage(ProposalListView):
    def visit(self):
        return super().visit("agenda")
