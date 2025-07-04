### Hexlet tests and linter status:
[![Actions Status](https://github.com/Ferrayd/rails-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Ferrayd/rails-project-65/actions)
[![CI Status](https://github.com/Ferrayd/rails-project-65/actions/workflows/ci.yml/badge.svg)](https://github.com/Ferrayd/rails-project-65/actions)

### Deployed App: 
[Доска объявлений](https://mysite-0meu.onrender.com/)

# Проект "Доска объявлений"

"Доска объявлений" – Сервис-аналог Avito, в котором пользователи могут размещать объявления и откликаться на них и связываться с продавцом. Каждое объявление проходит премодерацию администраторами сервиса. Администраторы могут вернуть объявление на доработку, опубликовать или отправить в архив. 

## Используемые технологии

Проект реализован с использованием следующих технологий:
Ruby 3.2.2
Ruby on Rails 7.2.0

В проекте используются:  
AASM + ActiveRecord  
Поисковые формы созданные при помощи Ransack  
ACL(Access Control List)  
ActiveStorage и AWS S3 Yandex.Cloud для загрузки и хранения изображений  
Реализована панель администратора/профиль пользователя с использованием вложенных ресурсов  
Использован I18n  
Проект задеплоен на сервисе Render  

## Local installation
```
make install-without-production
```
## Start dev-server
```
make dev-start
```
## Start tests
```
make test
```
## Start linters
```