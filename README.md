# GitHub Classroom Additional Scripts
Additional scripts I have created to be able to better interact with GitHub Classrooms

`checkout_at_due_date.pl` --- After downloading a collection of repositories using the "Classroom Assistant" application, this utility goes though the folder and checks out the most recent commit before the deadline. The deadline can be given in any `perl` dates format, the folder can be reletive.  
Usage: 
` ./checkout_at_due_date.pl "2020-02-03 13:20" /tmp/Assignment-02-03-2020-03-26-30/`