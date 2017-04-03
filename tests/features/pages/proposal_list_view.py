from .base_page import BasePage
from .proposal_card import ProposalCard


class ProposalListView(BasePage):
    """Pages which show a list of proposals."""

    def proposals(self):
        elems = self.context.driver.find_elements_by_class_name(
            'proposal-card')
        return [ProposalCard(e) for e in elems]
