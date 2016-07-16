# -*- coding: utf-8 -*-

# Implementado por Eduardo Machado

require 'active_record'

# Só execute este programa depois de criar o banco de dados (ruby
# initDataBase.rb)

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "db/dataBase.sqlite3"

# Inicializa classes
class Person < ActiveRecord::Base
end
class Profession < ActiveRecord::Base
end
class Email < ActiveRecord::Base
end
class Address < ActiveRecord::Base
end

# Organiza relações
class Profession <  ActiveRecord::Base
  belongs_to :people
end

class Email < ActiveRecord::Base
  belongs_to :people
end

class Address  < ActiveRecord::Base
   has_and_belongs_to_many :people, dependent: :destroy
end

class Person < ActiveRecord::Base
  has_one  :profession, dependent: :destroy
  has_many :email, dependent: :destroy
  has_and_belongs_to_many :address, dependent: :destroy
end

class Addresses_People < ActiveRecord::Base
  has_and_belongs_to_many :address
  has_and_belongs_to_many :people
end

# Função de inserção
def insert(element, attributes)
  element.downcase!
  case element
  when "person"
    # Insere pessoa
    instance = Person.new()

    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "last_name"
        attribute.last.delete! '\"'
        instance.last_name = attribute.last
      when "first_name"
        attribute.last.delete! '\"'
        instance.first_name = attribute.last
      when "age"
        attribute.last.delete! '\"'
        instance.age = attribute.last.to_i
      end
    end
    instance.save()
    puts "Pessoa inserida com sucesso."
    return
  when "profession"
    # Insere Profissão
    instance = Profession.new()

    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "name"
        attribute.last.delete! '\"'
        instance.name = attribute.last
      when "salary"
        attribute.last.delete! '\"'
        instance.salary = attribute.last.to_f
      when "person_id"
        attribute.last.delete! '\"'
        instance.person_id = attribute.last.to_i
      end
    end
    instance.save()
    puts "Profissão inserida com sucesso."
    return
  when "email"
    # Insere e-mail
    instance = Email.new()

    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "email_address"
        attribute.last.delete! '\"'
        instance.email_address = attribute.last
      when "person_id"
        attribute.last.delete! '\"'
        instance.person_id = attribute.last.to_i
      end
    end
    instance.save()
    puts "E-mail inserido com sucesso."
    return
  when "address"
    # Insere endereço
    instance = Address.new()

    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "address_house"
        attribute.last.delete! '\"'
        instance.address_house = attribute.last
      when "city"
        attribute.last.delete! '\"'
        instance.city = attribute.last
      when "country"
        attribute.last.delete! '\"'
        instance.country = attribute.last
      end
    end
    instance.save()
    puts "Endereço inserido com sucesso."
    return
  when "addresses_people"
    # Insere lista de relações entre pessoas e endereços
    instance = Addresses_People.new()

    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "address_id"
        attribute.last.delete! '\"'
        instance.address_id = attribute.last.to_i
      when "person_id"
        attribute.last.delete! '\"'
        instance.person_id = attribute.last.to_i
      end
    end
    instance.save()
    puts "Endereço conectado a pessoa com sucesso."
    return
  else
    puts "Tabela não existente."
    return
  end
end

# Função de alteração
def change(element, attributes, key)
  element.downcase!
  case element
  when "person"
    # Altera pessoa
    instance = Person.find(key)
    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "last_name"
        attribute.last.delete! '\"'
        instance.last_name = attribute.last
      when "first_name"
        attribute.last.delete! '\"'
        instance.first_name = attribute.last
      when "age"
        attribute.last.delete! '\"'
        instance.age = attribute.last.to_i
      end
    end
    instance.save()
    puts "Pessoa alterada com sucesso."
    return
  when "profession"
    # Altera Profissão
    instance = Profession.find(key)
    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "name"
        attribute.last.delete! '\"'
        instance.name = attribute.last
      when "salary"
        attribute.last.delete! '\"'
        instance.salary = attribute.last.to_f
      when "person_id"
        attribute.last.delete! '\"'
        instance.person_id = attribute.last.to_i
      end
    end
    instance.save()
    puts "Profissão alterada com sucesso."
    return
  when "email"
    # Altera e-mail
    instance = Email.find(key)
    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "email_address"
        attribute.last.delete! '\"'
        instance.email_address = attribute.last
      when "person_id"
        attribute.last.delete! '\"'
        instance.person_id = attribute.last.to_i
      end
    end
    instance.save()
    puts "E-mail alterado com sucesso."
    return
  when "address"
    # Altera endereço
    instance = Address.find(key)
    attributes.each do |a|
      # Preenche atributos
      attribute = a.split("=")
      case attribute.first
      when "address_house"
        attribute.last.delete! '\"'
        instance.address_house = attribute.last
      when "city"
        attribute.last.delete! '\"'
        instance.city = attribute.last
      when "country"
        attribute.last.delete! '\"'
        instance.country = attribute.last
      end
    end
    instance.save()
    puts "Endereço alterado com sucesso."
    return
  else
    puts "Tabela não existente."
    return
  end
end

# Remove um elemento de uma tabela
def remove(element, key)
  case element
  when "person"
    # Exclui pessoa
    Person.destroy(key)
    puts "Pessoa removida com sucesso."
    return
  when "profession"
    # Exclui Profissão
    Profession.delete(key)
    puts "Profissão removida com sucesso."
    return
  when "email"
    # Exclui e-mail
    Email.delete(key)
    puts "E-mail removido com sucesso."
    return
  when "address"
    # Exclui endereço
    Address.destroy(key)
    puts "Endereço removido com sucesso."
    return
  when "addresses_people"
    # Exclui lista de relações entre pessoas e endereços
    Addresses_People.delete(key)
  else
    puts "Tabela não existente."
  end
end

# Lista todos os elementos de uma tabela
def list(element)
  system "clear"
  case element
  when "people"
    # Lista pessoas
    Person.all.each do |a|
      puts "ID: #{a.id}\t| Name: #{a.first_name} #{a.last_name}\t| Age: #{a.age}"
    end
  when "professions"
    # Lista profissões
    Profession.all.each do |a|
      puts "ID: #{a.id}\t| Name: #{a.name}\t| Salary: #{a.salary}\t| Person ID: #{a.person_id}"
    end
  when "emails"
    # Lista emails
    Email.all.each do |a|
      puts "ID: #{a.id}\t| E-mail address: #{a.email_address}\t| Person ID: #{a.person_id}"
    end
  when "addresses"
    # Lista endereços
    Address.all.each do |a|
      puts "ID: #{a.id}\t| Address: #{a.address_house}\t| City: #{a.city}\t| Country: #{a.country}"
    end
  when "addresses_people"
    # Lista relações entre pessoas e endereços
    Addresses_People.all.each do |a|
      puts "ID: #{a.id}\t| Address ID: #{a.address_id}\t| Person ID: #{a.person_id}"
    end
  when "all"
    # Lista pessoas
    puts "People:"
    Person.all.each do |a|
      puts "ID: #{a.id}\t| Name: #{a.first_name} #{a.last_name}\t| Age: #{a.age}"
    end
    # Lista profissões
    puts "Professions:"
    Profession.all.each do |a|
      puts "ID: #{a.id}\t| Name: #{a.name}\t| Salary: #{a.salary}\t| Person ID: #{a.person_id}"
    end
    # Lista emails
    puts "E-mails:"
    Email.all.each do |a|
      puts "ID: #{a.id}\t| E-mail address: #{a.email_address}\t| Person ID: #{a.person_id}"
    end
    # Lista endereços
    puts "Addresses:"
    Address.all.each do |a|
      puts "ID: #{a.id}\t| Address: #{a.address_house}\t| City: #{a.city}\t| Country: #{a.country}"
    end
    # Lista relações entre pessoas e endereços
    puts "Addresses_People:"
    Addresses_People.all.each do |a|
      puts "ID: #{a.id}\t| Address ID: #{a.address_id}\t| Person ID: #{a.person_id}"
    end
  else
    puts "Tabela não existente."
  end
end

# Laço de execução.
while true
  input = gets.chomp
  if input == "exit" then
    # Fecha o programa
    break
  end
  inputSplited = input.split(" ")
  operation = inputSplited.shift
  element = inputSplited.shift
  case operation
  when "insert"
    # Insere um elemento na tabela
    attributes = inputSplited.collect
    insert(element, attributes)
  when "change"
    # Altera um elemento da tabela
    key = inputSplited.shift
    key.delete! '\"'
    key = key.to_i
    attributes = inputSplited.collect
    change(element,attributes,key)
  when "remove"
    # Altera um elemento da tabela
    key = inputSplited.shift
    key.delete! '\"'
    key = key.to_i
    remove(element, key)
  when "list"
    # Altera um elemento da tabela
    list(element)
  end
end
