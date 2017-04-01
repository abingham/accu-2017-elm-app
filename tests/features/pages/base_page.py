class BasePage(object):
    """Base class to initialize the base page that will be called from all pages.
    """

    def __init__(self, context):
        self.context = context
