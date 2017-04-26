# Webdriver tests for the ACCU app

We use the Python BDD tool [behave](http://pythonhosted.org/behave/) to write
our client-level tests. These in turn
use [Selenium WebDriver](http://www.seleniumhq.org/projects/webdriver/) to
control a browser.

## Install dependencies

Install the necessary Python requirements:
```
pip install -r requirements.txt
```

(You should probably do this in a virtual environment.)

Install the node requirements:
```
npm install -g webdriver
npm install -g phantomjs-prebuilt
```

Optionally, install drivers for other browsers:
```
npm install -g geckodriver
npm install -g operadriver
npm install -g chromedriver
npm install -g safaridriver
```

## Running the tests

First you need to make sure the app is running on localhost:3000 and that it's
using our canned test database. You can do this by running the following command
from the project root:

```
nf -j tests/Procfile start
```

By default the tests will use phantomjs. Run them with the `behave` command:

```
behave features
```

### Specifying a browser

If you want to run them with a different browser you can pass `-D
browser=<name>` to `behave`. For example, to use firefox you would run:

```
behave -D browser=firefox features
```

The available browser names are:
- firefox
- chrome
- safari
- opera
- edge
- ie
- phantomjs

### Specifying a different base URL

By default the tests are run again http://localhost:3000/. You can change this by
passing `-D base-url=<url>` to `behave`. For example, to run against the URL `http://accu.org/app/` you would run:

```
behave -D base-url=http://accu.org/app/
```
