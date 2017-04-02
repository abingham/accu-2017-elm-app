import time


class BasePage(object):
    """Base class to initialize the base page that will be called from all pages.
    """

    def __init__(self, context):
        self.context = context

    def visit(self, path, timeout=0.1):
        result = self.context.driver.get(
            self.context.base_url + "#/" + path)

        time.sleep(timeout)
        return result
