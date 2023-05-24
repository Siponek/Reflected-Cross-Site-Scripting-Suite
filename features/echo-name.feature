Feature: Welcome page
    As a user
    I want to see a welcome message with my name
    When I provide my name in the query parameter

    Scenario: Provide name in query parameter
        Given I am a user
        And I will access "echo-name.php" page
        When I send "John" into query parameter "name"
        Then I should see "Welcome John!"