#!/usr/bin/perl
# Script to emulate a browser for posting to a 
#   CGI program with method="POST".

# Specify the URL of the page to post to.
my $URLtoPostTo = "http://www.appaloosa.com/asna2007/mbrverify.aspx";

# Specify the information to post, the form field name on 
#   the left of the => symbol and the value on the right.
my %Fields = (
   "txtMemNumA"    => "739559",
   "Button1"       => "Submit",
   "__EVENTTARGET" => "",
   "__EVENTTARGET" => "",
   "__VIEWSTATE"   => "/wEPDwUKLTI1NDgzMjU5Ng9kFgICAQ9kFhoCBw8PFgIeBFRleHQFASBkZAINDw8WAh8ABQEgZGQCDw8PFgIeB1Zpc2libGVoZGQCEQ8PFgIfAWhkZAITDw8WAh8BaGRkAhUPDxYCHwFoZGQCFw8PFgIfAWhkZAIZDw8WAh8BaGRkAhsPDxYCHwFoZGQCHQ8PFgIfAWhkZAIfDw8WAh8BaGRkAiEPDxYCHwFoZGQCJQ88KwALAGRk+L70K0uYwDzkOWyts5QPi48bLQU=",
);

# If you want to specify a browser name, 
#   do so between the quotation marks. 
#   Otherwise, nothing between the quotes.
my $BrowserName = "";

# It's a good habit to always use the strict module.
use strict;

# Modules with routines for making the browser.
use LWP::UserAgent;
use HTTP::Request::Common;

# Create the browser that will post the information.
my $Browser = new LWP::UserAgent;

# Insert the browser name, if specified.
if($BrowserName) { $Browser->agent($BrowserName); }

# Post the information to the CGI program.
my $Page = $Browser->request(POST $URLtoPostTo,\%Fields);

# Print the returned page (or an error message).
print "Content-type: text/html\n\n";
if ($Page->is_success) { print $Page->content; }
else { print $Page->message; }

# end of script
