Feature: echo-attr2.php Welcome Message with class with escape quotes
    As a user
    I want to see a welcome message with my CSS class
    When I provide my class in the query parameter

    Background:
        Given I am a user accessing the "echo-attr2.php" page with JS disabled

    Scenario: Provide name in query parameter
        When I send "John" into query parameter "name"
        # A ton of problems with quotes
        Then I should see "class=\"John\""

    Scenario: Attempt to pass XSS NON-INTERACTIVE payload in query parameter
        When I send "John" into query parameter "name"
        Then I should see "class=\"John\""
        #? Test only when basic functionality works so no time is wasted on selenium
        Given I am a user accessing the "echo-attr2.php" page
        When I send '\"%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3Cspan%20\"' into query parameter "name" as XSS
        Then I should not see "111" as an alert