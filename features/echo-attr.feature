Feature: echo-attr.php Welcome Message with class
    As a user
    I want to see a welcome message with my CSS class
    When I provide my class in the query parameter

    Background:
        Given I am a user accessing the "echo-attr.php" page with JS disabled

    Scenario: Provide name in query parameter
        When I send "John" into query parameter "name"
        # A ton of problems with quotes
        Then I should see "class=\"John\""

    Scenario: Attempt to pass XSS NON-INTERACTIVE payload in query parameter
        When I send "John" into query parameter "name"
        Then I should see "class=\"John\""
        #? Test only when basic functionality works so no time is wasted on selenium
        Given I am a user accessing the "echo-attr.php" page
        When I send '\'%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3Cspan%20\'' into query parameter "name" as XSS
        Then I should not see "111" as an alert

# \"><script>alert(111)</script><\"
# %5C%22%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3C%5C%22
# "><script>alert(111)</script><"
# %22%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3C%22
# "><script>alert(document.domain)</script>
# %22%3E%3Cscript%3Ealert(document.domain)%3C%2Fscript%3E%3C%22
# " onload="alert(1)
# %22%20onload%3D%22alert(1)


# &#34>(delivered)<script src=&#34https://www.google.com/recaptcha/api.js&#34></script>
#%20%26%2334%3E(delivered)%3Cscript%20src%3D%26%2334https%3A%2F%2Fwww.google.com%2Frecaptcha%2Fapi.js%26%2334%3E%3C%2Fscript%3E

# john" onmouseover="alert(111)" contenteditable style=display:block
# john%22%20onmouseover%3D%22alert(111)%22%20contenteditable%20style%3Ddisplay%3Ablock

# john" onload%3Dalert(1)
# john%22%20onload%3Dalert(1)

#* This one WORKS!
# '><script>alert(111)</script><span class='
# %27%3E%3Cscript%3Ealert(111)%3C/script%3E%3Cspan%20class=%27

#* This one WORKS!

# '><script>alert(111)</script><span '
# '%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3Cspan%20'

# "><script>alert(111)</script><span "
# "%3E%3Cscript%3Ealert(111)%3C%2Fscript%3E%3Cspan%20"