class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :role

end
