# -*- coding: utf-8 -*-

# Implementado por Eduardo Machado

# Cria uma nova base de dados a cada vez.

require 'rubygems'
require 'active_record'

# As duas linhas abaixo indicam o SGBD a ser usado (sqlite3) e o nome
# do arquivo que contém o banco de dados (dataBase.sqlite3)
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "db/dataBase.sqlite3"

# Cria tabelas dentro do banco
ActiveRecord::Base.connection.create_table :people do |t|
  t.string  :last_name
  t.string  :first_name
  t.integer :age
end

ActiveRecord::Base.connection.create_table :professions do |t|
  t.string  :name
  t.float   :salary
  t.references :person
end

ActiveRecord::Base.connection.create_table :emails do |t|
  t.string  :email_address
  t.references :person
end

ActiveRecord::Base.connection.create_table :addresses do |t|
  t.string  :address_house
  t.string  :city
  t.string  :country
end

ActiveRecord::Base.connection.create_table :addresses_people do |t|
  t.references :person
  t.references :address
end

puts "Banco de dados inicializado."
