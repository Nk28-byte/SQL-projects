create database Onlinebookstore;
use Onlinebookstore;
create table Book(Book_id int primary key,Title varchar(100),Author varchar(50), Genre varchar(40),Published_year int,Price double,stock int);
select * from Book;

create table Customer(Customer_id int primary key,Name varchar(70),email varchar(150),Phone int,City varchar(40),country varchar(40));
select * from Customer;

create table Orders(Order_id int primary key,Customer_id int references Customer(customer_id),book_id int references Book(book_id),Order_date date ,Quantity int,Total_amount decimal);
select * from Orders;


##(.1) Retreive all the books in fiction genre:
select * from Book where genre='fiction';

##(.2) Find books published after the year 1950:
select * from Book where Published_year>1950;

##(.3) List all the customers from the canada:
select * from Customer where country='Canada';

##(.4) Show orders placed in november 2023:
select * from Orders where Order_date between '2023-11-01' and '2023-11-30';

##(.5) Retreive the total stock of book available:

select sum(stock)as total_stock from Book;

##(.6) Find the details of most expensive book:

select * from book order by price desc limit 1;

##(.7) Show all customers who ordered more than 1 quantity of a book:
select * from Orders where Quantity >1;

#(.8) Retrieve all orders where the total amount exceeds $20:
select * from Orders where total_amount>20;

#(.9) List all genre available in the book table:
select distinct(genre) from Book;

#(.10)Find the book with lowest stock:
select * from Book order by stock asc limit 1;

#(.11)Calculate the total revenue generated from all orders;
select sum(total_amount) as total_revenue from orders; 

#Advance Questions:

#(.1) Retrieve the total number of books sold for each genre:
select B.genre,sum(O.quantity) as total_book_sold from orders as O join Book as b on O.Book_id=B.book_id group by B.genre ;


#(.2) Find the average price of books in 'fantacy' genre:
select avg(price) as average_price from Book where genre='Fantasy';

#(.3) List customers who have placed at least 2 orders:
select customer_id,count(order_id) as order_count
from orders group by customer_id having count(order_id)>=2;

#(.4) Find the most frequently ordered book:
select book_id,count(order_id) as order_count from Orders group by book_id order by order_count desc;

#(.5) Show the top 3 most expensive books of fantasy genre:
select *,Price from book where genre='fantasy' order by Price desc limit 3;

#(.6) Retrieve the total Quantity of books sold by each author:
select b.author,sum(o.quantity) as total_quantity_sold from orders o join book b on o.book_id=b.book_id group by author;

# (.7) list the cities where customers who spent over $30 are located:
select distinct c.city from orders o join customers c on o.customer_id=c.customer_id where o.total_amount>30;

#(.8) Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount) as Total_spent  from orders o join Customer c on o.customer_id=c.customer_id group by c.customer_id,c.name order by Total_spent desc;
