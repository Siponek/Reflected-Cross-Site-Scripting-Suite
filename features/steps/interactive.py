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

@when('I click on the link with text "{link_text}"')
def step_click_on_link(context, link_text):
    # link = context.browser.find_element_by_link_text(link_text)
    # link = WebDriverWait(driver=context.driver,timeout= 4).until(method=EC.visibility_of_element_located(link_text, locator=By.PARTIAL_LINK_TEXT), message = "Timed out on link to appear")
    # wait = WebDriverWait(driver=context.driver,timeout= 10)  # wait for up to 10 seconds
    # link = wait.until(EC.visibility_of_element_located((By.LINK_TEXT, link_text)))
    link = context.driver.find_element(By.PARTIAL_LINK_TEXT, link_text)
    link.click()
    # search the entier page for links
    links = context.driver.find_elements_by_tag_name("a")
    # print the links
    for link in links:
        print(link)
        print(link.text)
        print(link.get_attribute("href"))