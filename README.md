# SSRSTester
A nimble SQL Server and Powershell solution to automatically test different aspects of SSRS deployments.

This solution consits of two projects:

The database project that sets you up with a working database in SQL 2008 or later for hosting metadata and keeping track of testresults.

The powershell project that gives you access to different types of testing.

You can filter which SSRS reports and linked reports to test, you can run more than one test without losing previous test results, and you can employ some scripts as a post-deployment for automated testing for your reporting services projects.
