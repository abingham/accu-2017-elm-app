class ProposalCard:
    def __init__(self, elem):
        self._elem = elem

    @property
    def day_text(self):
        return self._elem.find_element_by_css_selector(
            'a.day-link').text
