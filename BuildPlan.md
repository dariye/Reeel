###### Build Plan

1. Create a "Screenings" View
	* Create a title label "Screenings"
	* Create 3 UI navigation buttons:
		- Screenings
		- RSVPs
		- Profile
	* Create a ScreeningItem with the following properties:
		- Date+
		- Time+
		- Synopsis+
		- Location+
		- Director+
		- Stars+
		- MetaRating+
		- Content Rating
		- Runtime
		- Release Date
		- Image+
		- Writer
		- RSVPStatus
		
					+ denotes visibility of property in the Screenings view
	* Create a tableview list of ScreeningItems
2. Create a "Detail" View
	* Display a ScreeningItem in expanded format (All properties besides RSVPStatus, which is hidden)
	* Create 2 UI buttons:
		- RSVP
		- Back
	* Include the 3 UI navigation buttons
3. Create RSVP view
	* Create 3 editable text fields:
		- Name
		- Email
		- Number of guests
	* Create two UI buttons:
		- Agree to Terms and Conditions
		- Confirm 
4. Link up exisiting views
	* Implement Back buttons
	* Implement Detail view button
	* Implement RSVP view button
5. Implement RSVP submission
6. Create RSVPs view
	* Create Screenings tableview list
		- Include only ScreeningItems with True RSVPStatus
	* Create a UI button:
		- Change RSVP
7. Create a Profile view
	* Create 2 editable text fields:
		- Name
		- Email
	* Create a new title label "Profile"
	* Create 2 UI buttons:
		- Allow Notifications
		- Review Terms and Conditions
	* Include the 3 UI navigation buttons
8. Link up existing views
	* Implement Change RSVP button
	* Implement Profile buttons
