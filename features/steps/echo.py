# echo.py

from behave import *
from bs4 import BeautifulSoup
from colorama import Fore, Style

@when('I load the page')
def step_when_page_loaded(context):
    """This is explicit wait for the page to load WITHOUT any input from the user.
    """
    # Prepare the url
    url = f"http://localhost:8000/{context.page}"
    # Open the URL
    context.response = context.session.get(url)
