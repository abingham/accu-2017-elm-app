from .base_page import BasePage
from .proposal_list_view import ProposalListView


class AgendaPage(BasePage, ProposalListView):
    def visit(self):
        return super().visit("agenda")
