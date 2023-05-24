# echo-name.py

from behave import *
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoAlertPresentException
from bs4 import BeautifulSoup


@then('I should see "{text}"')
def step_should_see(context, text:str) -> None:
    # Check that the page body contains the expected text
    soup : BeautifulSoup = BeautifulSoup(context.response.text, 'html.parser')
    assert text in soup, f'Body text: "{soup}" does not contain "{text}"'
    
# I should not see "ATTACK" as an alert
@then('I should not see "{text}" as an alert')
def step_should_not_see_alert(context, text:str) -> None:
    try:
        # webdriver.support.ui.WebDriverWait(context.driver, 4).until(lambda driver: driver.switch_to.alert)
        WebDriverWait(context.driver, 4).until(method=EC.alert_is_present(), message="Timed out waiting for alert")
        alert = context.driver.switch_to.alert
        alert_text : str = alert.text
        assert text not in alert_text, f"Expected '{text}' not to be in alert, but found '{alert_text}'"
        alert.dismiss()
        
        context.driver.quit()
    except NoAlertPresentException:
        pass
    finally:
        context.driver.quit()
        