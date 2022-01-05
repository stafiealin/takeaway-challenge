# takeaway-challenge
# **Berlin Takeaway challenge**

This is a small project that presents a list of restaurants parsed from a local JSON and presents it to the user.
Restaurants are always grouped by status meaning the open restaurants will always show up first, those where you can order ahead will appear after and closed ones will be last.
## **Functionalities:**
### **1.Filtering**
 Restaurants can be filtered by name using the search bar
### **2.Sorting**
* By pressing the Filter button from the right side of the navigation bar, the user will be able to select multiple types of sortings
* User will need to confirm the selected sort option by pressing Apply
* User can also reset the current sort by pressing Reset
* Note that in the newly sorted list, the cells will also contain the sorting value by which is was sorted
### **2.Persistence:**
* Sort option will be saved during app runs and the list will be sorted the same way as it was last time at every app launch

## **Tests**
* Project contains unit tests around json file reading and parsing logic and sort functionality. Note that these tests do not cover all cases but they do happy flows and some edge cases.
* Also, there are some UI tests around the basic functionalities of the app.
