require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    @columns = columns.first.map(&:to_sym)
  end

  def self.finalize!
    # debugger
    self.columns.each do |column|
      define_method(column) do
        attributes.keys.push(column)
      end
      define_method("#{column}=") do |value|
        attributes[column].push(value)
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name

  end

  def self.table_name
    @table_name || ActiveSupport::Inflector.tableize(self.to_s)
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    return @attributes if @attributes
    @attributes = Hash.new { [] }

  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
