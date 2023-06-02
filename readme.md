[make_link]: https://www.gnu.org/software/make/
[docker_link]: https://docs.docker.com/install/
[chocolatey_link]: https://chocolatey.org/install
[python_link]: https://www.python.org/downloads/

# Reflected Cross-Site Scripting Suite

This repository contains a set of tests designed to check for potential reflected cross-site scripting (XSS) vulnerabilities in PHP pages, using the Behave testing framework.

## Overview

The tests are implemented as Behave feature files and steps in Python. They simulate various potential XSS attacks, like injecting script tags via query parameters, and check whether these attacks succeed.

The repository also includes a Dockerfile that sets up a Docker container with PHP and Apache, and copies the pages under test into the web root directory.

## Prerequisites

- Docker: You can install Docker by following the instructions on the [Docker website][docker_link]
- Python: This project requires Python 3.11 or newer. You can download it from the [Python website][python_link].
- Make: On Linux, you can install [Make][make_link] with your package manager (e.g., `sudo apt install make` on Debian-based distributions).
  - On Windows, you can install Make with [Chocolatey][chocolatey_link] using `choco install make`.
- A web browser: The tests are designed to be run in a web browser. The tests have been tested in Firefox.

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/Siponek/Reflected-Cross-Site-Scripting-Suite ./siponek-test-suite
    ```

2. Navigate to the project directory:

    ```bash
    cd siponek-test-suite
    ```

3. Install the Python requirements:

    ```bash
    make venv
    make install_reqs
    ```

4. Start the docker container:

    ```bash
    make up
    ```

## Usage

1. Run the tests:

    ```bash
    make run-behave
    ```

You can view the test results in the terminal. For more instructions check out the Makefile.

## Tests

Each test is defined as a scenario in a `.feature` file, with the steps implemented in Python. The tests check for various potential XSS vulnerabilities. For example, the tests for `echo-attr.php` check whether it's possible to inject script tags via a query parameter.

## Contributions

Contributions are welcome! Please create a pull request with your changes.
