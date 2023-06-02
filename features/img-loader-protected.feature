Feature: img-loader-protected.php Get img from src input
    As a user
    I want to see a welcome message with my CSS class
    When I provide my class in the query parameter

    Background:
        Given I am a user accessing the "img-loader-protected.php" page with JS disabled

    Scenario: Provide name in query parameter
        When I send "https://upload.wikimedia.org/wikipedia/commons/1/1b/Svelte_Logo.svg" into query parameter "target"
        # A ton of problems with quotes
        Then I should see "<img src=\"https://upload.wikimedia.org/wikipedia/commons/1/1b/Svelte_Logo.svg\""

    Scenario: Attempt to pass XSS NON-INTERACTIVE payload in query parameter
        When I send "my-img-address" into query parameter "target"
        Then I should see "<img src=\"my-img-address\""
        #? Test only when basic functionality works so no time is wasted on selenium
        Given I am a user accessing the "img-loader-protected.php" page
        When I send '\"<svg><animate onbegin=alert(111) attributeName=x dur=1s>\"/>' into query parameter "target" as XSS
        Then I should not see "111" as an alert

    Scenario: Attempt to pass XSS INTERACTIVE payload in query parameter
        Given I am a user accessing the "img-loader-protected.php" page
        When I send 'javascript:alert(111)' into query parameter "target" as XSS
        When I click on the link with text "here"
        Then I should not see "111" as an alert