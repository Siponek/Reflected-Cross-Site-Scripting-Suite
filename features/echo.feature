Feature: echo Welcome Message
    As a user
    I want to see a "Welcome" message
    When I provide my name in the query parameter

    Background:
        Given I am a user accessing the "echo.php" page with JS disabled

    Scenario: See the "Welcome" message
        When I load the page
        Then I should see "Welcome"