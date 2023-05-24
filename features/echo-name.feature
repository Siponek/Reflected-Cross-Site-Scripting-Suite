Feature: echo-name.php Welcome Message
    As a user
    I want to see a welcome message with my name
    When I provide my name in the query parameter

    Background:
        Given I am a user accessing the "echo-name.php" page with JS disabled

    Scenario: Provide name in query parameter
        When I send "John" into query parameter "name"
        Then I should see "Welcome John!"

    Scenario: Attempt to pass XSS non-interactive payload in query parameter
        When I send "John" into query parameter "name"
        Then I should see "Welcome John!"
        #? Test only when basic functionality works so no time is wasted on selenium
        Given I am a user accessing the "echo-name.php" page
        When I send '<style>@keyframes slidein {}</style><svg style="animation-duration:1s;animation-name:slidein;animation-iteration-count:2" onwebkitanimationiteration="alert(111)"></svg>' into query parameter "name" as XSS
        Then I should not see "111" as an alert


# <style>@keyframes slidein {}</style><script style=\"animation-duration:1s;animation-name:slidein;animation-iteration-count:2\" onwebkitanimationiteration=\"alert(\"ATTACK\")\"></script>