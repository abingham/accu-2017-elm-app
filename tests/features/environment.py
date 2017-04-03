import behave
from selenium import webdriver
from pages.agenda import AgendaPage


DRIVER_MAP = {
    'firefox': webdriver.Firefox,
    'chrome': webdriver.Chrome,
    'safari': webdriver.Safari,
    'opera': webdriver.Opera,
    'edge': webdriver.Edge,
    'ie': webdriver.Ie,
    'phantomjs': webdriver.PhantomJS,
}

_driver = None


def create_driver(context):
    """Create a new driver based on the 'browser' entry in config.userdata.

    The default driver is 'phantomjs'. This assigns the new driver to the
    global _driver and returns it.
    """
    global _driver
    driver_name = context.config.userdata.get('browser', 'phantomjs')
    cls = DRIVER_MAP[driver_name]
    _driver = cls()
    return _driver


def before_all(context):
    context.driver = create_driver(context)
    context.base_url = context.config.userdata.get(
        'base-url',
        'http://localhost:3000/')


def after_all(context):
    _driver.quit()


def before_tag(context, tag):
    if tag == 'clear-agenda':
        page = AgendaPage(context)
        page.visit()
        for p in page.proposals():
            p.bookmarked = False

# Register the Int type converter
behave.register_type(Int=int)
