# echo-name.py

from behave import *
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoAlertPresentException, TimeoutException
from bs4 import BeautifulSoup
from colorama import Fore, Style

@then('I should see "{text}"')
def step_should_see(context, text:str) -> None:
    # Check that the page body contains the expected text
    # escape the text for regex
    tmp_text = text.replace(r"\"", '"').replace(r"\'", "'")
    # print(f"{Fore.LIGHTCYAN_EX}Expected text: {Fore.RESET}{tmp_text}")
    soup : BeautifulSoup = BeautifulSoup(context.response.text, 'html.parser')
    assert tmp_text in str(soup), f'Body text: {str(soup)} does not contain {tmp_text}'
    
# I should not see "ATTACK" as an alert
@then('I should not see "{text}" as an alert')
def step_should_not_see_alert(context, text:str) -> None:
    try:
        # webdriver.support.ui.WebDriverWait(context.driver, 4).until(lambda driver: driver.switch_to.alert)
        WebDriverWait(driver = context.driver, timeout = 4).until(method=EC.alert_is_present(), message = "Timed out waiting for alert")
        alert = context.driver.switch_to.alert
        alert_text : str = alert.text
        assert text not in alert_text, f"Expected {Fore.LIGHTCYAN_EX}'{text}'{Fore.RESET} not to be in alert, but found {Fore.LIGHTRED_EX}'{alert_text}'{Fore.RESET}"
        alert.dismiss()
        
        context.driver.quit()
    except TimeoutException:
        pass
    finally:
        context.driver.quit()
        