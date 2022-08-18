### Hexlet tests and linter status:
[![Actions Status](https://github.com/mike090/rails-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/mike090/rails-project-lvl3/actions)
[![CI status](https://github.com/mike090/rails-project-lvl3/actions/workflows/ci.yml/badge.svg)](https://github.com/mike090/rails-project-lvl3/actions)
[![Heroku](https://heroku-badge.herokuapp.com/?app=hexlet-rails-bulletin-board&style=flat)](https://hexlet-rails-bulletin-board.herokuapp.com/)

# Доска объявлений

[Bulletin Board](https://hexlet-rails-bulletin-board.herokuapp.com/) – Сервис-аналогAvito, в котором пользователи могут размещать объявления и откликаться на них и связываться с продавцом. Каждое объявление проходит премодерацию администраторами сервиса. Администраторы могут вернуть объявление на доработку, опубликовать или отправить в архив.

# Установка

```
$ git clone https://github.com/Vasyll/rails-project-lvl3

$ make setup
```

Для полноценного тестирования необходимы права администратора. Для получения прав администратора выполните следующий код из rails/console 

```
$ User.create! name: <your_name>, email: <your_github_registration_email>
```

В корневой папке приложения создайте файл .env (либо переименуйте .env.example). Укажите в нем данные из Github Apps:

```
GITHUB_CLIENT_ID=
GITHUB_CLIENT_SECRET=
```

Запустите приложение командой 

```
$ make start
```
