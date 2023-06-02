"""This is a test file for manual testing of the web server.
    """

import requests
from bs4 import BeautifulSoup


def main():

    # current_session = requests.Session()
    url = "http://localhost:8000/echo-attr.php?name=John"
    # response = current_session.get(url)
    response =  requests.get(url)
    text = BeautifulSoup(response.text, 'html.parser')
    raw_text = str(text)
    print(text)
    print(raw_text, type(raw_text))
    print("class" in raw_text)
    # print(response.status_code)
    # print(response.headers)
    # print(response.cookies)
    # print(response.url)
    


if __name__ == '__main__':
    main()