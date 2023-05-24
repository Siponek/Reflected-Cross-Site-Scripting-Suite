# in steps/welcome_steps.py

from behave import *
from selenium import webdriver
from selenium.webdriver.common.by import By



@then('I should see "{text}"')
def step_should_see(context, text):
    # Check that the page body contains the expected text
    body_text = context.driver.find_element(By.TAG_NAME, "body").text
    assert text in body_text, f'Body text: "{body_text}" does not contain "{text}"'
    
    context.driver.quit()
