class ProposalCard:
    def __init__(self, elem):
        self._elem = elem

    @property
    def day_text(self):
        return self._elem.find_element_by_css_selector(
            'a.day-link').text

    @property
    def _bookmark_button(self):
        return self._elem.find_element_by_class_name(
            'bookmark-button')

    @property
    def bookmarked(self):
        icon = self._bookmark_button.find_element_by_name('i')
        return icon.text != 'bookmark'

    @bookmarked.setter
    def bookmarked(self, value):
        if value != self.bookmarked:
            return self._bookmark_button.click()
