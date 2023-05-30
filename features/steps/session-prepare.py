# session-prepare.py
from behave import * # pylint: disable-all
from selenium import webdriver
from webdriver_manager.firefox import GeckoDriverManager
from requests import Session
from enum import Enum

class RequestType(Enum):
    GET = 1
    POST = 2
    

@given('I am a user accessing the "{page}" page with JS disabled')
def step_user_page_no_js(context, page:str) -> None:
    """Prepare the context for a user accessing a page with JS disabled. This does not include javascript.enabled = false in slelenium driver.
    It is just for parsing the html response with beautiful soup.
    """
    context.page = page
    context.session = Session()
    

@when('I send "{content}" into query parameter "{query_param}"')
def step_send_into_query_param(context, content:str, query_param :str) -> None:
    # Prepare the url
    url = f"http://localhost:8000/{context.page}?{query_param}={content}"
    # Open the URL
    context.response = context.session.get(url)
    
# Given I am a user accessing the "echo-name.php" page
@given('I am a user accessing the "{page}" page')
def step_given_i_am_a_user(context,page : str) -> None:
    context.page = page
    # context.driver = webdriver.Firefox()
    context.driver = webdriver.Firefox(executable_path=GeckoDriverManager().install())
    # context.driver.implicitly_wait(4)

# I send '{payload}' into query parameter "name" as XSS
@when("I send \'{payload}\' into query parameter \"{query_param}\" as XSS")
def step_send_payload(context, payload:str, query_param:str) -> None:
    # Prepare the url
    url = f"http://localhost:8000/{context.page}?{query_param}={payload}"
    # Open the URL
    context.driver.get(url)
    
