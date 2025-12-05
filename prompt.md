I have a sandwich shop app written in Flutter. I need your help writing a good prompt I can send to an LLM to help me implement a new feature for my cart screen.

I have two pages: an order screen where users can select sandwiches and add them to their cart, and a cart screen where users can view their cart items.

I want to let the users modify the items in their cart. There are different ways a user might want to modify their cart like changing quantity or removing items entirely.

The app currently has these models:

- Sandwich (with type, size, bread type)
- Cart (with add/remove/clear methods and total price calculation)

It also has one repository:

- Pricing (calculates prices based on quantity and size; the price of a sandwich has nothing to do with its type or bread)

For each of these features, include a clear description and what should happen when the user performs an action. Output the result as a markdown document that I can save and use as a prompt.

The features I want to implement are:

1. **Increase Quantity**: User can tap a button to increase the quantity of a specific cart item

   - What should happen: The cart updates the quantity, the total price recalculates, and the UI reflects the change immediately

2. **Decrease Quantity**: User can tap a button to decrease the quantity of a specific cart item

   - What should happen: The cart updates the quantity, the total price recalculates. If quantity reaches 0, the item should be removed from the cart automatically

3. **Remove Item**: User can tap a button to remove an item from the cart entirely

   - What should happen: The item is removed regardless of quantity, the total price recalculates, and the UI updates

4. **Clear Cart**: User can tap a button to clear all items from the cart
   - What should happen: All items are removed, the total price becomes £0.00, and the UI shows an empty cart message

Additional requirements:

- Use built-in Flutter widgets only (no third-party packages)
- Each cart item should display: sandwich name, size, bread type, quantity, and individual item total price
- The cart should show a running total at the bottom
- Include proper error handling (e.g., preventing quantity from going below 0)
- Provide widget tests for each feature
- Suggest appropriate UI widgets for the increase/decrease/remove buttons
- Consider UX patterns like showing a confirmation dialog before clearing the entire cart

Please provide:

1. A recommended implementation approach
2. Code snippets for the cart modification methods
3. UI layout suggestions with code examples
4. Widget tests for each feature
5. Edge cases to handle (e.g., empty cart, last item removal)
