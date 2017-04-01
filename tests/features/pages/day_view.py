from .base_page import BasePage
from .proposal_card import ProposalCard


class DayViewPage(BasePage):
    """Page showing all proposals for a day."""

    def visit(self, day):
        return self.context.driver.get(
            self.context.base_url + "#/day/{}".format(day))

    def proposals(self):
        elems = self.context.driver.find_elements_by_css_selector(
            '.proposal-card')
        return [ProposalCard(e) for e in elems]
