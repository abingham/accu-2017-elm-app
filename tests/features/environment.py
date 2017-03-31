import behave
from selenium import webdriver


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
    _driver.implicitly_wait(10)  # seconds
    return _driver


def before_all(context):
    context.driver = create_driver(context)
    context.base_url = context.config.userdata.get(
        'base-url',
        'http://localhost:3000/')


def after_all(context):
    _driver.quit()


# Register the Int type converter
behave.register_type(Int=int)
