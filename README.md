# README

These are the tasks that I was able to do in 4 hours. I gave 1 hour on 28-02-2024 and gave 3 hours on 29-02-2024.

- Must be able to register an account on the site.
	- Must enforce the user to enter the following information:
		- First Name
		- Last Name
		- Username (only alpha-numeric characters)
		- Valid Email Address
		- Password
		- Password Verification
- Must be able to reset password via email and a secure token.
- Must be able to login to the site via email address or username.
- Must be redirected to a Dashboard page placeholder upon login.
- Must ensure that email address is unique.
- Must ensure that username is unique.
- Must be able to select a team from a dropdown in the top nav bar.
	- Must only present teams you are a member or owner of.
	- Must store Active Team so that additional resources can be built off of this.
	- Must have current_team helper available anywhere current_user is available.
- Must be able to manage Users
	- Must provide ability to have an avatar.
	- Must have a first name.
	- Must have a last name.
	- Must be able to edit own profile (first name, last name, email address & username)
	- As an admin must be able to create, edit and destroy all users.
	- As an admin must be able to assign roles to the user on a team level.
- Must be able to manage Teams
	- Must have a name.
	- Must have a description.
	- Must have a single owner that is a user.
	- Must have multiple users with different roles per team.
	- Must be able to create, edit and destroy own teams.
	- As an admin must be able to create, edit and destroy all teams.
- Must be able to manage Roles
	- Must have a name.
	- Must have a description.
	-  Must have granular permissions that can be used in the code.
	- Must be able to create, edit and destroy own roles.
	- As an admin must be able to create, edit and destroy all roles.
* ...
