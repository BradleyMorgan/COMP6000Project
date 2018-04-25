# COMP6000Project

You will need a functioning MySQL server with admin rights to create schemas, etc.  The code assumes that it will be running on localhost.  If you need to use a server running on something other than localhost, you can modify the jdbc connections strings that are located throughout the code.  A global search and replace of jdbc:mysql://localhost/comp6000 might do the trick.

I. Install with NetBeans...

1. Launch NetBeans
2. Team Menu -> Git -> Clone
3. For RepositoryURL, enter github.com:BradleyMorgan/COMP6000Project.git
4. Click "Next..."
5. Choose the Master branch if prompted
6. Click "Next..."
7. Make sure "Scan for NetBeans projects after clone" is checked.
8. Click Finish

The files will be downloaded to the location specified in the clone window.

II. Prepare MySQL ...

1. Using a MySQL client (i.e. MySQL Workbench) execute the COMP6000Project/sql/schema_final.sql file to create the necessary schema and tables.
2. Create a new user "comp6000" with a password of "comp6000" and make sure it has access to the "comp6000" schema.
3. If desired, also execute the COMP6000Project/sql/creddit_sample_data.sql file to populate the tables with some sample data.

III. Launch the program with NetBeans

