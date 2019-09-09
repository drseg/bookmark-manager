**Bookmark Manager**

The website will have the following specification:

- Show a list of bookmarks
~~~~
As a user
In order to have easy access to my favourite sites
I would like to see a list of bookmarks
~~~~
- Add new bookmarks
~~~~
As a time-pressed user
So that I can save a website
I would like to add the site's address and title to bookmark manager

As a user
So I can store bookmark data for later retrieval
I want to add a bookmark to Bookmark Manager
~~~~
- Delete bookmarks
~~~~
As a user
So I can remove my bookmark from Bookmark Manager
I want to delete a bookmark
~~~~
- Update bookmarks
~~~~
As a user
So I can change a bookmark in Bookmark Manager
I want to update a bookmark
~~~~
- Comment on bookmarks
- Tag bookmarks into categories
- Filter bookmarks by tag
- Users are restricted to manage only their own bookmarks

### To set up the database
	
Connect to `psql` and create the `bookmark_manager` databases:
	
```
CREATE DATABASE bookmark_manager;
CREATE DATABASE bookmark_manager_test;
```
	
To set up the appropriate tables, connect to the database in `psql` and run the SQL scripts in the `db/migrations` folder in the given order.
	