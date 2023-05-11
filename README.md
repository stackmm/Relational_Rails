# README
Table -> Pharmacies
- auto-generated ID (PRIMARY KEY)
- name:string
- pharmacist_in_charge:string
- num_employees:integer
- city:string
- open_24_hours:boolean
- created_at:datetime
- updated_at:datetime

Medications belong to a Pharmacy
Table -> Medications
- auto-generated ID (PRIMARY KEY)
- pharmacy_id:integer (FOREIGN KEY)
- name:string
- strength:string
- dosage_form:string
- quantity:integer
- in_stock:boolean
- created_at:datetime
- updated_at:datetime

################################
Iteration 1:
################################

[x] done

User Story 1, Parent Index 

For each parent table
As a visitor
When I visit '/parents'
Then I see the name of each parent record in the system

[x] done
User Story 2, Parent Show 

As a visitor
When I visit '/parents/:id'
Then I see the parent with that id including the parent's attributes
(data from each column that is on the parent table)

[x] done
User Story 3, Child Index 

As a visitor
When I visit '/child_table_name'
Then I see each Child in the system including the Child's attributes
(data from each column that is on the child table)

[x] done
User Story 4, Child Show 

As a visitor
When I visit '/child_table_name/:id'
Then I see the child with that id including the child's attributes
(data from each column that is on the child table)

[x] done
User Story 5, Parent Children Index 

As a visitor
When I visit '/parents/:parent_id/child_table_name'
Then I see each Child that is associated with that Parent with each Child's attributes
(data from each column that is on the child table)

[x] done
User Story 6, Parent Index sorted by Most Recently Created 

As a visitor
When I visit the parent index,
I see that records are ordered by most recently created first
And next to each of the records I see when it was created

[] done
User Story 7, Parent Child Count

As a visitor
When I visit a parent's show page
I see a count of the number of children associated with this parent

[] done
User Story 8, Child Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Child Index

[] done
User Story 9, Parent Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Parent Index

[] done
User Story 10, Parent Child Index Link

As a visitor
When I visit a parent show page ('/parents/:id')
Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')