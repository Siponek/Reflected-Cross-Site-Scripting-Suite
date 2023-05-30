# interactive.py

from behave import *
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoAlertPresentException, TimeoutException, UnexpectedAlertPresentException
from bs4 import BeautifulSoup
from colorama import Fore
import colorama

colorama.init(autoreset=True)

@when('I click on the link with text "{link_text}"')
def step_click_on_link(context, link_text):
    try:
        # link = context.browser.find_element_by_link_text(link_text)
        link = WebDriverWait(driver=context.driver,timeout= 4).until(method=EC.visibility_of_element_located(locator=(By.PARTIAL_LINK_TEXT, link_text)), message = "Timed out on link to appear")
        # wait = WebDriverWait(driver=context.driver,timeout= 10)  # wait for up to 10 seconds
        # link = wait.until(EC.visibility_of_element_located((By.LINK_TEXT, link_text)))
        # link = context.driver.find_element(By.PARTIAL_LINK_TEXT, link_text)
        link.click()
    except UnexpectedAlertPresentException:
        # Switch the control to the Alert window
        alert = context.driver.switch_to.alert

        # Retrieve the message on the Alert window
        message = alert.text
        print("Alert shows following message: " + message)

        # use the accept() method to accept the alert
        alert.accept()
        print("Alert Accepted")

        # Use the dismiss() method to cancel the alert
        # alert.dismiss()
        # print("Alert Dismissed")