class Employee

    attr_reader :name, :title, :salary, :boss 

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss 
    end

    def bonus(multiplier)
        @salary * multiplier
    end
end

class Manager < Employee

    attr_reader :assigned_employees

    def initialize(name, title, salary, boss, assigned_employees = [])
        super(name, title, salary, boss)
        @assigned_employees = assigned_employees
    end

    def bonus(multiplier)
        total = 0
        q = @assigned_employees[0..-1]
        until q.empty?
            emp = q.shift 
            total += emp.salary
            begin 
                q.concat(emp.assigned_employees)
            rescue NoMethodError
                next 
            end
        end

        total * multiplier
    end

    def add_employee(employee)
        @assigned_employees << employee 
    end

end