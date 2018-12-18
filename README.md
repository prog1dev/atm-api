# README

Реализовать банкомат в виде RESTful API.
1) Должна быть функция "заправки" денег в банкомат - отправляется количество купюр каждого номинала (например, 10 купюр по "50", 8 по "25" и т.д.). Номиналы бывают: 1, 2, 5, 10, 25, 50.

2) Реализовать метод который принимает сумму для выдачи и возвращает нужные номиналы. Если в банкомате не хватает денег для выдачи - пользователь должен получить сообщение об этом.

Например, если поступил запрос на выдачу 200 грн, а в наличии есть 3 купюры по 50 и 4 по 25, то результат может быть таким: {50 => 3, 25 => 2} или {50 => 2, 25 => 4}.

Количество денег в наличии должно уменьшаться после каждой выдачи.

3) Задачу оформить в виде RESTful API, фреймворк - можно выбрать любой который считаете более подходящим для данной задачи. В ShipHawk для API мы используем Grape, поэтому его использование очень предпочтительно.

## Installation

```ruby
git clone git@github.com:prog1dev/atm-api.git && cd atm-api && bundle && rake db:setup
```
