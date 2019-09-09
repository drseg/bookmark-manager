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
~~~~
- Delete bookmarks
- Update bookmarks
- Comment on bookmarks
- Tag bookmarks into categories
- Filter bookmarks by tag
- Users are restricted to manage only their own bookmarks

### To set up the database
	
Connect to `psql` and create the `bookmark_manager` database:
	
```
CREATE DATABASE bookmark_manager;
```
	
To set up the appropriate tables, connect to the database in `psql` and run the SQL scripts in the `db/migrations` folder in the given order.
	