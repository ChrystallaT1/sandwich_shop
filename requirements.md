# Cart Modification Feature Requirements

## 1. Feature Description and Purpose

The Cart Modification feature enables users of the Sandwich Shop Flutter app to manage the contents of their cart before checkout. Users can adjust the quantity of each sandwich or remove items. Editing sandwich details (such as bread type or size) is not supported on the cart page; users must add a new item from the order screen if they wish to change sandwich options. This feature aims to provide a flexible and user-friendly shopping experience, ensuring users can easily correct mistakes or change their order without starting over.

---

## 2. User Stories

### 2.1. Adjust Quantity

- **As a user**, I want to increase or decrease the quantity of a sandwich in my cart, so I can order the exact number I want.
- **As a user**, I want the cart to automatically remove an item if I decrease its quantity below 1, so my cart never contains items with zero or negative quantity.

### 2.2. Remove Item

- **As a user**, I want to remove a sandwich from my cart with a single action, so I can quickly update my order if I change my mind.

### 2.3. Feedback and UI Responsiveness

- **As a user**, I want the cart and total price to update immediately when I make changes, so I always see an accurate summary of my order.
- **As a user**, I want to receive feedback (such as a snackbar) when I remove or update an item, so I know my action was successful.
- **As a user**, I want to see a clear message if my cart is empty, so I know I need to add items before checking out.

---

## 3. Acceptance Criteria

### 3.1. Quantity Adjustment

- [x] Each cart item displays "+" and "–" buttons for quantity adjustment.
- [x] Tapping "+" increases the quantity by 1.
- [x] Tapping "–" decreases the quantity by 1.
- [x] If the quantity is reduced below 1, the item is removed from the cart.
- [x] The total price updates automatically and accurately.
- [x] The UI updates immediately to reflect changes.

### 3.2. Remove Item

- [x] Each cart item has a "Remove" button (e.g., trash icon).
- [x] Tapping "Remove" deletes the item from the cart.
- [x] The total price updates accordingly.
- [x] A snackbar or similar feedback is shown when an item is removed.

### 3.3. General UI and Behavior

- [x] All changes are reflected immediately in the UI.
- [x] The cart's total price is always accurate.
- [x] The cart handles empty states gracefully (e.g., displays a message if empty).
- [x] The UI prevents negative quantities.
- [x] User feedback is provided for all cart modification actions.

---

## 4. Subtasks

1. ✅ Implement "+" and "–" quantity adjustment buttons for each cart item.
2. ✅ Implement logic to remove an item if its quantity is reduced below 1.
3. ✅ Add a "Remove" button for each cart item.
4. ✅ Ensure the total price and UI update immediately after any change.
5. ✅ Provide user feedback (snackbar) for remove and update actions.
6. ✅ Handle empty cart states with a clear message.

---

# Profile Screen Feature Requirements

## 1. Feature Description and Purpose

The Profile Screen feature allows users to view their personal account information, contact details, and preferences within the Sandwich Shop app. This read-only screen serves as a central hub for displaying user-specific data including name, email, phone number, delivery address, favorite sandwich, and notification preferences. The feature aims to provide users with easy access to their account information and create a personalized experience.

---

## 2. User Stories

### 2.1. View Personal Information

- **As a user**, I want to view my name and email address on my profile, so I can verify my account details are correct.
- **As a user**, I want to see a profile avatar, so I can easily identify my profile visually.

### 2.2. View Contact and Delivery Information

- **As a user**, I want to see my phone number displayed, so I know what contact number is associated with my account.
- **As a user**, I want to view my delivery address, so I can confirm where my orders will be sent.

### 2.3. View Preferences

- **As a user**, I want to see my favorite sandwich displayed, so I can remember my go-to order.
- **As a user**, I want to see my notification settings status, so I know whether I'll receive order updates.

### 2.4. Navigation

- **As a user**, I want to easily access my profile from the Order screen, so I can view my information at any time.
- **As a user**, I want to be able to navigate back from the Profile screen, so I can return to ordering.

---

## 3. Acceptance Criteria

### 3.1. Profile Header Section

- [ ] Profile screen displays a circular avatar icon at the top center.
- [ ] Avatar uses a person icon with teal background and white foreground.
- [ ] Avatar has a 60px radius for good visibility.
- [ ] User's full name is displayed below the avatar in heading2 style.
- [ ] User's email address is displayed below the name in normalText style.
- [ ] Header section is centered horizontally.

### 3.2. Account Information Section

- [ ] Section has a clear "Account Information" heading in heading2 style.
- [ ] Section displays phone number with a phone icon (teal color).
- [ ] Phone number is formatted as: "+44 XXX XXX XXXX".
- [ ] Section displays delivery address with a location icon (teal color).
- [ ] Address shows full street address, city, and country.
- [ ] Each item is presented in a ListTile with title and subtitle.
- [ ] Dividers separate individual list items for visual clarity.

### 3.3. Preferences Section

- [ ] Section has a clear "Preferences" heading in heading2 style.
- [ ] Favorite sandwich is displayed with a heart icon (red color).
- [ ] Favorite sandwich shows sandwich name and bread type.
- [ ] Notification status is displayed with a notification icon (orange color).
- [ ] Notification status shows "Enabled" or "Disabled".
- [ ] Each preference is presented in a ListTile format.
- [ ] Dividers separate preference items.

### 3.4. Layout and Styling

- [ ] Screen uses SingleChildScrollView to handle content overflow.
- [ ] Content has 16px padding on all sides.
- [ ] Spacing between sections is consistent (40px between major sections).
- [ ] App bar displays "My Profile" title in heading1 style.
- [ ] Back button is present in app bar for navigation.
- [ ] All text styles match existing app theme (heading1, heading2, normalText).
- [ ] Icon colors are meaningful and consistent (teal for account, red for favorites, orange for notifications).

### 3.5. Navigation

- [ ] "My Profile" button is present on Order screen.
- [ ] Button uses teal background color to match profile theme.
- [ ] Button displays person icon.
- [ ] Tapping button navigates to Profile screen.
- [ ] Back button returns to Order screen.
- [ ] Navigation is smooth with no lag or errors.

---

## 4. Subtasks

1. Create ProfileScreen StatelessWidget with basic structure.
2. Implement app bar with "My Profile" title.
3. Add profile header with avatar, name, and email.
4. Create "Account Information" section with phone and address ListTiles.
5. Create "Preferences" section with favorite sandwich and notifications.
6. Apply appropriate icons and colors to each section.
7. Add dividers between ListTile items.
8. Wrap content in SingleChildScrollView with proper padding.
9. Add "My Profile" navigation button to Order screen.
10. Test navigation flow and screen layout on different device sizes.

---

## 5. Data Structure

### Current Implementation (Static Data)

```dart
// Hardcoded values for initial implementation
- Name: "John Doe"
- Email: "john.doe@example.com"
- Phone: "+44 123 456 7890"
- Address: "123 Main Street, London, UK"
- Favorite Sandwich: "Veggie Delight on White Bread"
- Notifications: "Enabled"
```

### Future Considerations

- Create a User model class to manage profile data
- Integrate with backend API for data persistence
- Add ability to edit profile information
- Support multiple delivery addresses
- Allow users to select/change favorite sandwiches
- Implement customizable notification preferences
- Add profile picture upload functionality
- Include order history in profile

---

## 6. Technical Notes

- **Widget Type**: StatelessWidget (data is static, no state changes)
- **Dependencies**: Uses `app_styles.dart` for text styling
- **Navigation**: Uses `Navigator.push` with `MaterialPageRoute`
- **Layout**: Column-based layout with SingleChildScrollView
- **Icons**: Material Icons (person, phone, location_on, favorite, notifications)
- **Color Scheme**: Follows app theme (teal primary, complementary colors for accents)

---

## 7. Out of Scope (Future Enhancements)

The following features are NOT part of the initial Profile screen implementation:

- Editing profile information (name, email, phone, address)
- Uploading or changing profile picture
- Viewing order history
- Managing multiple delivery addresses
- Customizing notification preferences with toggle switches
- Account security settings (password change, 2FA)
- Loyalty program or rewards display
- Social features (friends, sharing)
- Payment method management
