Задля швидкодії створила окрему таблицю для кожного запиту:

1. Отримувати всі відгуки за заданим product_id

CREATE TABLE review_product(product_id text, review_id text, review_headline text, review_body text, review_date date, star_rating smallint, PRIMARY KEY(product_id, review_id));

Як Partition Key вибираю product_id, аби усі записи з однаковим product_id розміщувалися в одній ноді. Для того, щоб зробити записи унікальними доаю Clustering Key review_id як Clustering Key.


2. Отримувати всі відгуки за заданим product_id та обраним star_rating

CREATE TABLE review_product_with_rating(product_id text, review_id text, review_headline text, review_body text, review_date date, star_rating smallint, PRIMARY KEY((product_id, star_rating), review_id));

Тут використовую Composite Partition Key(product_id, star_rating), щоб записи, які запитуємо розміщувалися в одній ноді. Для того, щоб зробити записи унікальними доаю Clustering review_id як Clustering Key.


3. Отримувати всі відгуки за заданим customer_id

CREATE TABLE review_customer(customer_id text, review_id text, review_headline text, review_body text, review_date date, star_rating smallint, PRIMARY KEY(customer_id, review_id));

Як Partition Key вибираю customer_id, аби усі записи з однаковим customer_id розміщувалися в одній ноді. Для того, щоб зробити записи унікальними додаю review_id як Clustering Key.


4. Отримувати користувачів(customer_id), які залишили більше ніж N відгуків на платформі і які також залишили відгук для продукту product_id (N та product_id повинне задаватися в запиті)

CREATE TABLE review_customer_product(customer_id text, product_id test, number_rated, PRIMARY KEY(product_id, number_rated));

Вирішила, що краще партиціювати по product_id, адже ці данні скоріш за все рівномірніше розподілені аніж кількість відгуків користувачів. Таким чином отримаємо стільки груп, скільки існує продуктів, на які писали коментарі. Якби ж партиціювала по кількості відгуків найбільше записів було б в групах з невеликою кількістю відгуків. До того ж, груп було б значно менше ніж у випадку партиціювання по product_id(чи багато людей, які писали більше 1000 відгуків?).


5. Дізнатися скільки позитивних відгуків (4 або 5 зірок) залишив вказаний користувач customer_id

CREATE TABLE review_customer_rating(customer_id text, star_rating smallint, review_id text, PRIMARY KEY((customer_id,star_rating), review_id));

Для цього запиту потрібно зберігати значно менше інформації у кожному записі. Створюю Composite Partition Key(product_id, star_rating) задля того, щоб утворилося більше груп і вони рівномірно розподілилися по нодам. Аби зробити записи унікальними додаю review_id як Clustering Key.
