from behave import given, then


@given('we visit the Wednesday day view')
def step_impl(context):
    context.driver.get(context.base_url + "#/day/1")


@then('{count:Int} proposal cards are displayed')
def step_impl(context, count):
    elems = context.driver.find_elements_by_class_name('proposal-card')
    assert len(elems) == count


@then('all proposals are for {day}')
def step_impl(context, day):
    elems = context.driver.find_elements_by_css_selector(
        '.proposal-card a.day-link')
    assert all(e.text == day for e in elems)
