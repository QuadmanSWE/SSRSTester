# SSRSTester
A nimble SQL Server and Powershell solution to automatically test different aspects of SSRS deployments.

This solution consits of three projects:

The database project that sets you up with a working database in SQL 2008 or later for hosting metadata and keeping track of testresults. There is also a second database project that acts as a dummy for ReportServer so that views can reference the structure.

The powershell project that gives you access to testing report rendering.

You can filter which SSRS reports and linked reports to test, you can run more than one test without losing previous test results, and you can employ some of your own scripts as a post-deployment for automated testing for your reporting services projects.


... instructions ...


Put the reportmetadata that you want to test in Testing.Reports. To help avoid losing data for multiple tests you can use Stage.ReportMetaData to stage the structure you want to test. One way to use it is to get report-information from a different server with ssis to staging and then insert it into Testing.Reports.
Once you have all your reports in the form you want them to be in the database, create a test and connect reports and tests in Testing.ReportTests.

Deploy your reports to your SSRS database (default ReportServer) and you are ready to run the first test.
Any abnormalities with deployment can be recorded in the ManualDeploymentErrors and ManualDeploymentErrorMessage columns of each report if you so wish. You could also create a script that parses the visual studio build and deployment output log to update the records but this is out of scope right now for this solution.

[Testing].[usp_SetDeploymentStatusOnTest] will compare the metadata from Testing.Reports for the reports in your test and the view Testing.v_ReportsThatHaveSuccessfullyDeployed which projects report information from your ReportServer database.
Assuming you are using that reportserver database for deployment this will update the flag ExistsInProject in your local report.

The second test is to render the reports with powershell to see that they all work.
The procedure [Testing].[usp_ReportsToRun] returns the information about the reports as they exist in your target state (Testing.Reports) and the parameters that they are stored with.
The powershell script library looks up the parameters for each of these report from the deployed reports in the service and tries to render them and store them on your local machine.
For each report it updates the test record with success or fail and any exceptiontext caught in the execution.

For the future, there are plans to include more metadata about the reports in the tests. This is reflected in the unused columns in the Testing.ReportTests table.
