# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
CUSTOMER_ADDRESS (type 1) -any change will overwrite the previous address.

 
 • CustomerID (Primary Key, Foreign Key to Customer table)
 • Address
 • City
 • Province 
 • ZipCode
 • Country

CUSTOMER_ADDRESS_HISTORY (type 2 ) - will retain the changes

 • Columns:
 • CustomerAddressID (Primary Key)
 • CustomerID (Foreign Key to Customer table)
 • Address
 • City
 • Province 
 • ZipCode
 • Country
 • StartDate
 • EndDate
 • CurrentFlag (to identify if the address is current)

For the Architecture type 1, as the data is going to be overwritten it does not require much data protection except just a current data.

For the Architecture type2 there should be more privacy implication used as it does include all the history of previous addresses of the client, so it’s important to use like access control in order to control the employees with certain access, encryption and data minimization or data masking. The best solution would be use few layers of data protection.

```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
It’s larger Model as it does contain more aspects of operations and departments involved like HR, Purchasing, Production, dbo. In terms of sales part it does have additional tables like SalesTaxRate, Currency, Currency Rate, Special Offer, Sales Reason as well as payment details like CC, Sales Territory and Sales TerritoryHistory. I would definitely change and add more tables in the model if they would require by the business needs to have more accurate data, however it would definitely required another  level of handling and data protection.
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `June 1, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
