# echo-name.py

from behave import *
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoAlertPresentException, TimeoutException
from bs4 import BeautifulSoup
from colorama import Fore
import colorama

colorama.init(autoreset=True)

def dynamic_string_compare(string_expected:str, string_response:str) -> str:
    """
    returns colored occurence to which string is the same

    Args:
        string_expected (str): String expected from the test/Gherkin
        string_response (str): String response from the test/Gherkin

    Returns:
        str: String that is colored until difference is found
    """
    difference_index : int = 0
    try:
        for index in range(len(string_expected)): # type: ignore
            if string_expected[index] == string_response[index]:
                continue
            else:
                difference_index = index
                break
    except IndexError:
        print( f"{Fore.LIGHTRED_EX}IndexError: {Fore.RESET} strings are not the same length")
    return f"{Fore.LIGHTGREEN_EX}{string_expected[:difference_index]}{Fore.LIGHTRED_EX}{string_expected[difference_index:]}{Fore.RESET}"
    
@then('I should see "{text}"')
def step_should_see(context, text:str) -> None:
    # Check that the page body contains the expected text
    # escape the text for regex
    tmp_text :str = text.replace(r"\"", '"').replace(r"\'", "'")
    soup : BeautifulSoup = BeautifulSoup(context.response.text, 'html.parser')
    dynamic_string : str = dynamic_string_compare(string_expected=tmp_text, string_response=str(soup))
    assert tmp_text in str(soup), dynamic_string + f" is not in {Fore.LIGHTGREEN_EX}{str(soup)}{Fore.RESET}"
    
# I should not see "111" as an alert
@then('I should not see "{text}" as an alert')
def step_should_not_see_alert(context, text:str) -> None:
    try:
        # webdriver.support.ui.WebDriverWait(context.driver, 4).until(lambda driver: driver.switch_to.alert)
        WebDriverWait(driver = context.driver, timeout = 4).until(method=EC.alert_is_present(), message = "Timed out waiting for alert")
        alert : context = context.driver.switch_to.alert
        alert_text : str = alert.text
        assert text not in alert_text, f"Expected {Fore.LIGHTCYAN_EX}'{text}' {Fore.LIGHTRED_EX}not{Fore.RESET} to be in alert, but found {Fore.LIGHTRED_EX}'{alert_text}'{Fore.RESET}"
        alert.dismiss()
        
        context.driver.quit()
    except TimeoutException:
        pass
    finally:
        context.driver.quit()
        