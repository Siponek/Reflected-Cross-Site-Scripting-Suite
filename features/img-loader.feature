Feature: img-loader.php Get img from src input
    As a user
    I want to see a welcome message with my CSS class
    When I provide my class in the query parameter

    Background:
        Given I am a user accessing the "img-loader.php" page with JS disabled

    Scenario: Provide name in query parameter
        When I send "https://upload.wikimedia.org/wikipedia/commons/1/1b/Svelte_Logo.svg" into query parameter "target"
        # A ton of problems with quotes
        Then I should see "<img src=\"https://upload.wikimedia.org/wikipedia/commons/1/1b/Svelte_Logo.svg\""

    Scenario: Attempt to pass XSS NON-INTERACTIVE payload in query parameter
        When I send "https://upload.wikimedia.org/wikipedia/commons/1/1b/Svelte_Logo.svg" into query parameter "target"
        Then I should see "<img src=\"https://upload.wikimedia.org/wikipedia/commons/1/1b/Svelte_Logo.svg\""
        #? Test only when basic functionality works so no time is wasted on selenium
        Given I am a user accessing the "img-loader.php" page
        When I send '\'><script>alert(111)</script> \'/>' into query parameter "target" as XSS
        Then I should not see "111" as an alert