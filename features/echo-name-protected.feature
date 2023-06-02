Feature: echo-name-protected.php Welcome Message with htmlspecialchars
    As a user
    I want to see a welcome message with my name
    When I provide my name in the query parameter

    Background:
        Given I am a user accessing the "echo-name-protected.php" page with JS disabled

    Scenario: Provide name in query parameter
        When I send "John" into query parameter "name"
        Then I should see "Welcome John!"

    Scenario: Attempt to pass XSS NON-INTERACTIVE payload in query parameter
        When I send "John" into query parameter "name"
        Then I should see "Welcome John!"
        #? Test only when basic functionality works so no time is wasted on selenium
        Given I am a user accessing the "echo-name-protected.php" page
        When I send '\"<svg><animate onbegin=alert(111) attributeName=x dur=1s>\"' into query parameter "name" as XSS
        Then I should not see "111" as an alert



#* This one WORKS!
# '><script>alert(111)</script><span class='
# %27%3E%3Cscript%3Ealert(111)%3C/script%3E%3Cspan%20class=%27

#* This one WORKS!

# '><script>alert(111)</script><span '
# '%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3Cspan%20'

# "><script>alert(111)</script><span "
# "%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3Cspan%20"

# "<svg><animate onbegin=alert(111) attributeName=x dur=1s>"