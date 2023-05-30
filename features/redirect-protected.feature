# It will check only for existing HTML <a> tags with href attribute without selenium going into the href link
Feature: redirect_protected.php Redirect link with target with htmlspecialchars
    As a user
    I want to see a welcome message with my CSS class
    When I provide my class in the query parameter

    Background:
        Given I am a user accessing the "redirect_protected.php" page with JS disabled

    Scenario: Provide name in query parameter
        When I send "www.google.com" into query parameter "target"
        # A ton of problems with quotes
        Then I should see "Click <a href=\"www.google.com\">here</a> to redirect"

    Scenario: Attempt to pass XSS non-interactive payload in query parameter
        When I send "www.google.com" into query parameter "target"
        Then I should see "Click <a href=\"www.google.com\">here</a> to redirect"
        #? Test only when basic functionality works so no time is wasted on selenium
        Given I am a user accessing the "redirect_protected.php" page
        When I send '\'><script>alert(111)</script> \'' into query parameter "target" as XSS
        Then I should not see "111" as an alert

    Scenario: Attempt to pass XSS interactive payload in query parameter
        When I send "www.google.com" into query parameter "target"
        Then I should see "Click <a href=\"www.google.com\">here</a> to redirect"
        Given I am a user accessing the "redirect_protected.php" page
        When I send "javascript:alert(111)" into query parameter "target"
        When I click on the link with text "here"
        Then I should not see "111" as an alert

# echo "Click <a href='$target'>here</a> to redirect";
# * This works
# '><script>alert(111)</script><a href="javascript:alert(111)">XSS</a> '
# '%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3Ca%20href%3D%22javascript%3Aalert(111)%22%3EXSS%3C%2Fa%3E%20'
# * This works
# '><script>alert(111)</script> '
# '%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%20'
# <a href="javascript:alert(1)">XSS</a>

# <a href="javascript:alert(111)">XSS</a>

# javascript:alert(111)
# javascript%3Aalert(111)